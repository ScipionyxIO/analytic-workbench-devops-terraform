# Procedure

## Nework
1. Vpc
2. Vpc Subnets

## Rancher
2. Nexus
3. MariaDB
4. Rancher

## Sequence:
### Deployments/Infrastructure
1. s3/terraform (this is necessary as it keeps the remote configuration)

	terraform init
	terraform apply

2. network/vpc

	rm -fr .terraform/
	terraform init
	terraform apply

3. network/vpc_subnet

	rm -fr .terraform/
	terraform init
	terraform apply
	
4. network/dns

	rm -fr .terraform/
	terraform init
	terraform apply
	
5. rds/subnet

	rm -fr .terraform/
	terraform init
	terraform apply

6. rds/mariadb

	rm -fr .terraform/
	terraform init
	terraform apply
	
### Rancher	

7. rancher

	rm -fr .terraform/
	terraform init
	terraform apply
	
8. k8/sg

	rm -fr .terraform/
	terraform init
	terraform apply
	
9. k8/nodes/infra

	rm -fr .terraform/
	terraform init
	terraform apply

#### Nexus

10. ebs/nexus

	rm -fr .terraform/
	terraform init
	terraform apply
	