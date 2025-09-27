terraform {
  backend "s3" {
    bucket = "terraform-lab3" 
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = false
  }
}