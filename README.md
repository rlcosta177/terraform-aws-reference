# IMPORTANT COMMANDS TO REMEMBER #

### terraform state -> a bunch of commands for future use
### terraform state list -> displays all the existing resources created after the terraform apply
### terraform state show -> displays the detailed information about a specific resource(use after the command above for ease of use)
### terraform output -> shows the output variables after 'terraform apply' (used in testing environment)
### terraform refresh -> same as 'terraform output' but better used in a production environment
### terraform destroy -target [resource (ex: aws_instance.web-server-instance)] -> removes a single specified resource
### terraform apply -target [resource (ex: aws_instance.web-server-instance)] -> creates a single specified resource
### specify the provider | change the values of the variables every time you launch aws 




# AWS CONFIGURATION #

### 1) https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html <- install aws cli on windows/linux/mac
### 2) On the cmd/terminal -> aws configure -> add the keys in the aws details(awsacademy.instructure.com/courses) -> add the region -> format(i use json) | reference: https://stackoverflow.com/questions/46455908/unable-to-find-aws-directory
### 3) ON LINUX: home/.aws | ON WINDOWS: C:/Users/<username>/.aws
### 4) The config file will already be configured
### 5) If using aws academy(school) add the token given in the aws learner lab launcher(red circle icon in the tab)
### 6) The variables of the credentials file have to be exactly like this(at least on windows) -> aws_access_key_id; aws_secret_access_key; aws_session_token
### 7) For linux it should be -> access_key; secret_key; token
### 8) For this error: 'Error: No valid credential sources found', add the variable 'shared_credentials_files' to the provider "aws" function in main.tf
