[![learn-terraform-aws-instance](https://github.com/remiljw/learn-terraform-aws-instance/workflows/Build%20and%20Test/badge.svg)](https://github.com/remiljw/learn-terraform-aws-instance/actions/workflows/test.yml)  [![learn-terraform-aws-instance](https://github.com/remiljw/learn-terraform-aws-instance/workflows/Deploy%20to%20Production/badge.svg)](https://github.com/remiljw/learn-terraform-aws-instance/actions/workflows/deploy.yml) 

# Prerequisites
To be able to run or test this infrastructure, you will need to get a few things up and running: 
- [Golang](https://golang.org/doc/install) installed
- A [Terraform Cloud Account](https://app.terraform.io/)
- The [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) 0.14.8+ installed.
- The [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed.
- An [AWS](https://aws.amazon.com/free/) account.
- Your AWS credentials. You can create a new [Access Key on this page](https://console.aws.amazon.com/iam/home?#/security_credentials).

# Steps
- Configure the AWS CLI from your terminal. Follow the prompts to input your AWS Access Key ID and Secret Access Key. Also input `us-east-1` as region, then `json` as format.
```json
aws configure
```
- You will need to create your organization and workspace on Terraform Cloud. Follow these [instructions](https://learn.hashicorp.com/tutorials/terraform/github-actions) to help you set that up.

- Open `main.tf` and on line 5 and 9 respectively, replace the `organization` and workspaces `name` field to the organization and workspace you created in the previous step.
```hcl
terraform {
  backend "remote" {
    #         # The name of your Terraform Cloud organization.
    hostname     = "app.terraform.io"
    organization = "<your-organozation>"
    #
    #         # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "<your-workspace>"
    }
  }
```
- Create your [AWS Key Pair in the AWS Console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair), download it, and move it to the root of this project.

- Open `main.tf` and on line 134 change the value of `key_name` to the name of your downloaded key
```json
key_name      = "<your_key_name>"
```
- On line 149, edit the `private_key` to the path of tour key which you added to the root of this project. 
```json
file("${path.module}/<your_key_name>.pem")
```

- Launch your terminal and cd to the root of this project, run the following commands to deploy the infrastructure:
- - `terraform init`
- - - initiates terraform
- - `terraform fmt` 
- - - formats the files to match the canonical standar
- - `terraform validate`
- - - ensures the files are syntactically valid and internally consistent
- - `terraform apply -auto-approve`
- - - creates the infrastructure

- Wait for the infrastructure to deploy. On successful deploy you should have an output as this on your terminal:
```shell
Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

instance_id = "i-0941f1d034a2f2f6d"
instance_url = "Visit http://52.204.187.105:8080 in your browser."
public_ip = "52.204.187.105"
resource_tags = tomap({
  "Name" = "Flugel"
  "Owner" = "InfraTeam"
})
```
- Run `terraform show` to see the details of the infrastructure. 
- Once you are done, you will need to destroy what you just built, so run:
`terraform destroy -auto-approve` 

# Testing
To run the tests:
- Launch your terminal and cd to the root of this project
- run `cd test` to navigate to the test folder
- run `go build -v`
- run `go test -v`