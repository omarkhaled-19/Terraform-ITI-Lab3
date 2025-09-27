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
├── backend.tf # Remote state backend config
├── dev.tfvars # Variable values for dev environment
├── main.tf # Root Terraform configuration
├── outputs.tf # Output definitions
├── variables.tf # Input variables
├── README.md # Project documentation
├── modules/ # Reusable Terraform modules
│ ├── ec2/ # EC2 instance(s) module
│ ├── loadbalancer/ # Load balancer module
│ ├── security/ # Security groups module
│ └── vpc/ # VPC networking module: including subnets, gateways, etc..
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
