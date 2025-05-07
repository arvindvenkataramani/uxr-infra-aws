#!/bin/bash

# Get Terraform JSON output and parse it
terraform output -json > terraform_output.json

# Extract instance info and passwords
instance_info=$(jq -r '.instance_info.value | to_entries[] | "\(.key) : \(.value)"' terraform_output.json)
uxrops_password=$(jq -r '.uxrops_password.value' terraform_output.json)

# Print the formatted output
echo "Instances:"
echo "-------------------------------------------"
echo "$instance_info"
echo ""
echo "uxrops"
echo "-------------------------------------------"
echo "$uxrops_password"

rm terraform_output.json