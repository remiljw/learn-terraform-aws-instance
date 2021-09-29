[![learn-terraform-aws-instance](https://github.com/remiljw/learn-terraform-aws-instance/workflows/Build%20and%20Test/badge.svg)](https://github.com/remiljw/learn-terraform-aws-instance/actions/workflows/test.yml)  [![learn-terraform-aws-instance](https://github.com/remiljw/learn-terraform-aws-instance/workflows/Deploy%20to%20Production/badge.svg)](https://github.com/remiljw/learn-terraform-aws-instance/actions/workflows/deploy.yml) 

# Prerequisites
To be able to run or test this infrastructure, you will need to get a few things up and running: 
- [Golang](https://golang.org/doc/install) installed
- The [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) 0.14.8+ installed.
- The [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed.
- An [AWS](https://aws.amazon.com/free/) account.
- Your AWS credentials. You can create a new [Access Key on this page](https://console.aws.amazon.com/iam/home?#/security_credentials).

Configure the AWS CLI from your terminal. Follow the prompts to input your AWS Access Key ID and Secret Access Key. Also input `us-east-1` as region, then `json` as format.
```json
aws configure
```
Create your [AWS Key Pair in the AWS Console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair), download it, and move it to the root of this project.

Open `main.tf` and on line 134 change the value of `key_name` to the name of your downloaded key
```json
key_name      = "your_key_name"
```
- on line 149, edit the `private_key` to the path of tour key which you added to the root of this project. 
```json
file("${path.module}/<your_key_name>.pem")
```

Launch your terminal and cd to the root of this project, run the following commands to deploy the infrastructure:
- `terraform init`
- `terraform fmt` 
- `terraform validate`
- `terraform apply -auto-approve`
Wait for the infrastructure to deploy. On successful deploy you should have an output as this on your terminal:
```json
Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

instance_id = "i-0941f1d034a2f2f6d"
instance_url = "Visit http://52.204.187.105:8080 in your browser."
public_ip = "52.204.187.105"
resource_tags = tomap({
  "Name" = "Flugel"
  "Owner" = "InfraTeam"
})
server_public_ip = "52.204.187.105"
```
Once you are done, you will need to destroy what you just built, so run:
`terraform destroy -auto-approve` 

# Testing
To run the tests:
- Launch your terminal and cd to the root of this project
- run `cd test` to navigate to the test folder
- run `go build -v`
- run `go test -v`