## IMPORTANT COMMANDS TO REMEMBER

- `terraform state`: A bunch of commands for future use.
- `terraform state list`: Displays all the existing resources created after the `terraform apply`.
- `terraform state show`: Displays detailed information about a specific resource (use after the command above for ease of use).
- `terraform output`: Shows the output variables after `terraform apply` (used in testing environment).
- `terraform refresh`: Similar to `terraform output` but better used in a production environment.
- `terraform destroy -target [resource]`: Removes a single specified resource.
- `terraform apply -target [resource]`: Creates a single specified resource.
- Specify the provider | Change the values of the variables every time you launch AWS. You won't be able to commit your changes if you hardcode the credentials; they have to be saved to the credentials file.

## AWS CONFIGURATION

1. [Install AWS CLI on Windows/Linux/Mac](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
2. On the command prompt/terminal, run `aws configure`, then add the keys in the AWS details (awsacademy.instructure.com/courses), add the region, and format (I use JSON). 
   - Reference: [Stack Overflow - Unable to Find AWS Directory](https://stackoverflow.com/questions/46455908/unable-to-find-aws-directory)
3. ON LINUX: `home/.aws` | ON WINDOWS: `C:/Users/username/.aws`
4. The config file will already be configured.
5. If using AWS Academy (school), add the token given in the AWS Learner Lab Launcher (red circle icon in the tab).
6. The variables of the credentials file have to be exactly like this (at least on Windows): `aws_access_key_id`, `aws_secret_access_key`, `aws_session_token`.
7. For Linux it should be: `access_key`, `secret_key`, `token`.
8. For this error: 'Error: No valid credential sources found', add the variable 'shared_credentials_files' to the provider "aws" function in main.tf.

## Terraform installation(deb linux)

1. sudo apt-get update
2. sudo apt-get install -y wget unzip
3. wget https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip
4. unzip terraform_1.5.2_linux_amd64.zip
5. sudo mv terraform /usr/local/bin/
6. terraform --version

  ### create a symbolic link for terraform
  - sudo ln -s /usr/local/bin/terraform /usr/local/bin/tf
  - tf --version
