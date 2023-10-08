all:
	cd terraform && terraform apply

destroy:
	cd terraform && terraform destroy
