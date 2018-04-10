# Terraform + Digital Ocean Hello World

1. Download terraform at https://www.terraform.io/downloads.html and put in a global path

2. Copy `project.template.tfvars` to `project.tfvars` and populate with real data. You'll have to go to Digital Ocean and upload an SSH key and generate an API token.

3. `make init` will setup terraform and its digital ocean provider. This should only need to be done on setup or whenever you upgrade terraform.

4. `make deploy` will push up the single server defined in www-helloworld.tf

5. `make destroy` will remove it
