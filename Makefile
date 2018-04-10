plan:
	terraform plan -var-file="project.tfvars"

init:
	terraform init

deploy:
	terraform apply -auto-approve -var-file="project.tfvars"

destroy:
	terraform destroy -auto-approve -var-file="project.tfvars"
