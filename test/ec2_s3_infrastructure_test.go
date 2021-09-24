package test

import (
	"testing"
	
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestInfrastructure(t *testing.T) {
	t.Parallel()

	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../infrastructure",
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created.
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply`. Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the tags of the instance
	tag = "{ 
			'Name'  = 'Flugel'
			'Owner' = 'InfraTeam' 
		}"
	ec2_output := terraform.Output(t, terraformOptions, "ec2_tags")
	s3_output := terraform.Output(t, terraformOptions, "s3_tags")
	assert.Equal(t, tag, ec2_output)
	assert.Equal(t, tag, s3__output)

}
