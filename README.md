# learnaws

This repository for source code or anywhere after learn AWS on my Medium - budionosan.medium.com

- AWS Glue : Source code from AWS Glue Data Catalog to Amazon Redshift
  - gluestudio.py : Python code when use for ETL jobs
  - mergeclean.csv : CSV file for crawlers on AWS Glue Data Catalog
- Amazon EKS (on Amazon EC2) : 
  - firsteks.yaml : YAML file for create EKS cluster on Amazon EC2
  - eksconfig : EKS configuration before create EKS cluster
- Amazon Redshift :
  - redshift.sql.txt : copy CSV file from Amazon S3 to Amazon Redshift with COPY command
- Amazon EKS on AWS Fargate :
  - service.yaml : define load balancer, port and target port
  - ingress.yaml : application load balancer (ALB) controller
- Terraform on AWS :
  - main.tf : define AWS resources needed - EC2 instance and security group.
