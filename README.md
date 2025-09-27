## 🛠 Prerequisites

Before using this Terraform configuration, ensure you have the following:

1. **AWS Account** – You need access to an AWS account with sufficient permissions.  
2. **Access Keys** – Create an AWS access key pair (Access Key ID and Secret Access Key) from the [AWS IAM Console](https://console.aws.amazon.com/iam/).

---
# Setup:

## 🔑 Provider Authentication

Terraform requires AWS credentials to interact with your AWS account.  
You can authenticate using Environment Variables like this

### Option 1: Environment Variables Directly
Export your credentials as environment variables:

```bash
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
```
#### or

### Option 2: Use the .aws/credentials file
refer to [Terraform AWS authentication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)


## 🗂  Project Structure
```bash
── backend.tf
├── dev.tfvars
├── main.tf
├── outputs.tf
├── variables.tf
├── modules
│   ├── ec2-backend
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ec2-proxy
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── loadbalancer
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── security
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── varibles.tf
```

## 📦 Remote State Storage with S3

Terraform state should be stored in a remote backend to enable collaboration and prevent local state corruption.
You can use an **S3 bucket** to store the state file.

### Step 1: Create an S3 Bucket
Use the AWS CLI (or Console) to create a bucket. Example with CLI:

```bash
aws s3api create-bucket \
  --bucket terraform-state-lab \
  --region us-east-1
```
Enable bucket versioning to main previous states of statefile
### Step 2: Define the "backend" in the backend.tf
Define the S3 bucket as the backend for storing the statefile. 
Set "use_lockfile" as true if state lock is needed. Otherwise set as false**
**Note: "use_lockfile" is a new feature to lock the file in S3 natively. An additional 
  DynamoDB table was used previously to maintain the lock mechanism, but this method is soon-to-be deprecated

In the backend.tf file: 
```hcl
terraform {
  backend "s3" {
    bucket = "terraform-lab3" 
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = false
  }
}
```
For this lab, `use_lockfile` is set to false


## Terrform Workspace
- In the root directory, create a new workspace called "dev"
`terraform workspace new dev`
- Select the new dev workspace to create the infrastructure in
`terraform workspace select dev`

## Create the infrastructure
- In the root directory, initialize Terraform to start downloading the provider plugins, etc..

  `terraform init`
  
- Create a terraform plan to make sure no errors are occuring

  `terraform plan -var-file=def.tfvars`
  
- Deploy the Infrastructure
  
  `terraform apply -var-file=dev.tfvars -auto-approve`

  **If it asks to enter the "key-name", this is only to name key-pair file that will be stored on AWS and locally. This is used so Terraform can SSH into the proxy servers to provisin them as reverse-proxies 
  
Now wait until the successful deployment message is displayed. Then wait a a few more minutes (5 minutes) until VMs and Load Balancers are running


## Test the infrastructure
 - After Deployment, take public load balancer dns name and type it in any browser as follows:
    `http://<public-lb-dns-name>`


That is it !
Thanks !!

