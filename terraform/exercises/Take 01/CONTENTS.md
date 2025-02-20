# 🚀 Terraform Lab: Google Cloud Storage & Compute Engine

## ✅ Overview of Terraform Steps

| Step | `main.tf` File Creates |
|------|-----------------------|
| **Step 1** | A **simple Cloud Storage bucket** |
| **Step 2** | **Adds versioning & labels** to the storage bucket |
| **Step 3** | **Assigns IAM permissions** for a storage bucket |
| **Step 4** | **Deploys a Compute Engine VM** |

## Notes for use

- Students use Cloud Shell and the build-in editor in the Google Cloud Console to work

### Check resources

After provisioning the resources with terraform, to check them use either the web console or execute in the cloud console:

```bash
gcloud storage buckets list
gcloud compute instances list
```
