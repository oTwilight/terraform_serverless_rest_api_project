#!/bin/bash

# Create base directories
mkdir -p envs modules

# Create environment directories and files
for env in dev test prod; do
    mkdir -p envs/$env
    touch envs/$env/{main.tf,backend.tf,provider.tf,variables.tf,terraform.tfvars}
done

# Prompt user for module names
echo "Enter the module names (space-separated, e.g., lambda api_gateway dynamodb):"
read -r -a modules

# Validate and create module directories and files
for module in "${modules[@]}"; do
    # Check if module directory already exists
    if [ -d "modules/$module" ]; then
        echo "Module '$module' already exists, skipping creation."
    else
        # Create module directory and files
        mkdir -p modules/$module
        touch modules/$module/{main.tf,output.tf,variables.tf}
        echo "Created module '$module' with files."
    fi
done