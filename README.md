# IMPORTANT COMMANDS TO REMEMBER #

### terraform state -> a bunch of commands for future use
### terraform state list -> displays all the existing resources created after the terraform apply
### terraform state show -> displays the detailed information about a specific resource(use after the command above for ease of use)
### terraform output -> shows the output variables after 'terraform apply' (used in testing environment)
### terraform refresh -> same as 'terraform output' but better used in a production environment
### terraform destroy -target [resource (ex: aws_instance.web-server-instance)] -> removes a single specified resource
### terraform apply -target [resource (ex: aws_instance.web-server-instance)] -> creates a single specified resource
### specify the provider | change the values of the variables every time you launch aws 
