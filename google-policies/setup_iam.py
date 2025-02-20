from googleapiclient.discovery import build
from google.oauth2 import service_account

# Define service account credentials
SERVICE_ACCOUNT_FILE = 'path/to/service-account-key.json'
PROJECT_ID = 'your-project-id'
STUDENT_EMAILS = [
    'student1@example.com',
    'student2@example.com',
    'student3@example.com'
]

# Define custom IAM role
CUSTOM_ROLE_ID = 'studentRestrictedRole'
CUSTOM_ROLE_PERMISSIONS = [
    "bigquery.datasets.create",
    "bigquery.jobs.create",
    "bigquery.tables.create",
    "bigquery.tables.getData",
    "bigquery.tables.list",
    "bigquery.tables.updateData",
    "storage.buckets.create",
    "storage.buckets.list",
    "storage.objects.create",
    "storage.objects.get",
    "storage.objects.list"
]

def create_custom_role():
    """Create a custom IAM role."""
    client = build('iam', 'v1', credentials=service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE))
    role_body = {
        "roleId": CUSTOM_ROLE_ID,
        "role": {
            "title": "Student Restricted Role",
            "description": "Restrictive role for students using Google Cloud within Always Free Tier.",
            "includedPermissions": CUSTOM_ROLE_PERMISSIONS,
            "stage": "GA"
        }
    }
    request = client.projects().roles().create(parent=f'projects/{PROJECT_ID}', body=role_body)
    response = request.execute()
    print(f"Custom role created: {response['name']}")

def assign_iam_role(email):
    """Assign the custom IAM role to a student."""
    client = build('cloudresourcemanager', 'v1', credentials=service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE))
    policy = client.projects().getIamPolicy(resource=PROJECT_ID, body={}).execute()

    # Add binding for the custom role
    policy['bindings'].append({
        'role': f'projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}',
        'members': [f'user:{email}']
    })

    request = client.projects().setIamPolicy(resource=PROJECT_ID, body={'policy': policy})
    response = request.execute()
    print(f"Role assigned to {email}: {CUSTOM_ROLE_ID}")

def remove_editor_owner_roles(email):
    """Remove Editor or Owner roles from the student."""
    client = build('cloudresourcemanager', 'v1', credentials=service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE))
    policy = client.projects().getIamPolicy(resource=PROJECT_ID, body={}).execute()

    # Remove overly permissive roles
    for binding in policy['bindings']:
        if binding['role'] in ['roles/editor', 'roles/owner'] and f'user:{email}' in binding['members']:
            binding['members'].remove(f'user:{email}')

    # Apply the updated policy
    request = client.projects().setIamPolicy(resource=PROJECT_ID, body={'policy': policy})
    response = request.execute()
    print(f"Removed Editor/Owner roles from {email}")

if __name__ == '__main__':
    create_custom_role()
    for email in STUDENT_EMAILS:
        assign_iam_role(email)
        remove_editor_owner_roles(email)
