# Important Commands to Remember

## Terraform State Management
- `terraform state`: A suite of commands for managing the state.
- `terraform state list`: Lists all resources created after running `terraform apply`.
- `terraform state show <resource>`: Shows detailed information about a specific resource. Use this after `terraform state list` for ease.
- `terraform output`: Displays the output variables post `terraform apply`. Useful in testing environments.
- `terraform refresh`: Refreshes the state file to match the real infrastructure. Preferred for production environments.

## Resource Management
- `terraform destroy -target <resource>`: Removes a specified resource.
- `terraform apply -target <resource>`: Creates a specified resource.

## Best Practices
- **Specify the Provider:** Update variable values each time you launch AWS. Avoid hardcoding credentials; save them to the credentials file to enable commits.

# AWS Configuration

1. **Install AWS CLI:**
   - [Windows/Linux/Mac Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

2. **Configure AWS CLI:**
   - Run `aws configure` in the command prompt or terminal.
   - Enter keys from AWS details (found at awsacademy.instructure.com/courses).
   - Set the region and format (JSON is recommended).

   - Reference: [Unable to Find AWS Directory - Stack Overflow](https://stackoverflow.com/questions/46455908/unable-to-find-aws-directory)

3. **Configuration File Locations:**
   - **Linux:** `~/.aws`
   - **Windows:** `C:/Users/<username>/.aws`

4. **Pre-configured Config File:**
   - Your config file will already be set up.

5. **Using AWS Academy:**
   - Add the token from the AWS Learner Lab Launcher (red circle icon in the tab).

6. **Credentials File Variables:**
   - **Windows:** 
     ```
     aws_access_key_id
     aws_secret_access_key
     aws_session_token
     ```
   - **Linux(im not sure if thats how it is):**
     ```
     access_key
     secret_key
     token
     ```

7. **Handling Credential Errors:**
   - For errors like 'Error: No valid credential sources found', add the variable `shared_credentials_files` to the provider "aws" function in `main.tf`.

# Terraform Installation on Debian-based Linux

1. Update the package list:
   ```sh
   sudo apt-get update
   sudo apt-get install -y wget unzip
   wget https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip
   unzip terraform_1.5.2_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   terraform --version
   ```

2. Create a symbolic link for terraform
   ```sh
   sudo ln -s /usr/local/bin/terraform /usr/local/bin/tf
   tf --version
   ```
