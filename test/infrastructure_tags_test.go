package test

import (
	"testing"
	
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestInfrastructureTags(t *testing.T) {
	t.Parallel()

	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../",
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created.
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply`. Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the tags of the instance
	
	output := terraform.OutputMap(t, terraformOptions, "resource_tags")


	expectedLen := 2
	expectedMap := map[string]string{
		"Name": "Flugel",
		"Owner": "InfraTeam",
	}

	require.Len(t, output, expectedLen, "Output should contain %d item(s)", expectedLen)
	require.Equal(t, expectedMap, output, "Map %q should match %q", expectedMap, output)

}
