## 🚀 Execute Terraform Commands ##

Follow these steps to deploy your Google Cloud Storage bucket using Terraform.

### 1️⃣ Initialize Terraform ###
First, navigate to the project folder in your terminal and run:

```bash
terraform init
```

This command:

- Initializes Terraform.
- Downloads the required **Google Cloud provider**.
- Sets up the working directory for Terraform operations.

You should see output confirming that Terraform has been successfully initialized. You need to run this command only once when you start to work on your Terraform code.

---

## 2️⃣ Plan the Deployment ##

Run the following command to preview what Terraform will create:

```bash
terraform plan
```

This command:

- Analyzes the Terraform configuration (`main.tf`).
- Shows the resources Terraform will create **without** making any actual changes.
- Helps you verify your setup before applying changes.

If everything looks good, proceed to the next step.

---

## 3️⃣ Apply the Changes ##

To create your storage bucket, run:

```bash
terraform apply -auto-approve
```

This command:

- Provisions the cloud resources defined in `main.tf`.
- Displays the progress of resource creation.
- **Automatically approves** changes (without asking for confirmation). If you leave out `-auto-approve`, terraform will ask you to enter `yes` at the prompt to proceed.

**Once complete, Terraform will output the URL of your new storage bucket.**  
You can also verify your bucket in the **Google Cloud Console**.

---

## 4️⃣ Verify in Google Cloud Console ##

After running `terraform apply`, go to the **Google Cloud Console**:

1. Open [Google Cloud Storage](https://console.cloud.google.com/storage).
2. Check for a bucket with the name you specified in your terraform code.
3. Click on the bucket to view its details.

Alternatively, use the Google Cloud SDK (`gsutil`) to verify the bucket:

```bash
gsutil ls -p <your-project-id>
```

If the bucket appears in the output, it has been successfully created.

---

## 5️⃣ Destroy Resources (Cleanup) ##

To avoid unnecessary costs, **destroy the resources when you're done**:

```bash
terraform destroy -auto-approve
```

This command:

- **Deletes all** resources created by Terraform.
- Ensures you don’t leave unnecessary infrastructure running.
- Frees up cloud resources for future use.

**⚠️ Important:**  
Running `terraform destroy` will remove **all** resources defined in `main.tf`. Be sure you want to delete everything before proceeding.

## Destroying buckets which already contain data ##

When you try to destroy a bucket that already contains data, terraform will prevent destroying the bucket unless you add 

```terraform
force_destroy = true
```

to your storage bucket configuration.

**⚠️ Important:**
You need to run `terraform apply` first, to change the storage bucket's configuration to include `force_destroy` and then you can delete a non-empty bucket with `terraform destroy`.

## Troubleshooting ##

### Missing storage.buckets.create permission ###

Add the permission to your user account for the project:

```bash
gcloud projects add-iam-policy-binding <project-id> \
    --member="user:<your user email>" \
    --role="roles/storage.admin"
```

Check the roles you have in your project with the command:

```bash
gcloud projects get-iam-policy <project-id> --flatten="bindings[].members" --format="table(bindings.role)"
```
