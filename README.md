# Encora test

This Terraform project is designed to create essential infrastructure components on AWS for deploying applications. It allows you to create a flexible VPC setup, subnets, an Autoscaling Group with EC2 instances, and an Application Load Balancer (ALB) to facilitate high availability and load balancing for your application servers.

## Infrastructure components

- 1 VPC in us-east-1 region. This should be flexible based on region. If no region is provided, this should be built in us-east-1. 
- 2 Subnets with high availability supported in 2 zones
- 1 Route table not including the default one. Routes should not be routed using the local route. 
- Autoscaling group with a flexible cool down, deregistration delay, instance warm up.
- 2 EC2 instances created from the autoscaling group
- ALB to load-balance the app servers. Ensure the port is flexible based on the application. 

## Getting Started
You can run this Terraform code with the following commands:
- Run `terraform init` to initialize the working directory.
- Execute `terraform plan` to see the execution plan.
- Finally, run `terraform apply` to create the resources.

## Customization
To change the region when running Terraform, you can use the -var option like so:
```bash
terraform apply -var="aws_region=us-west-2"
```

To change the ALB Target Group Port, you can use the -var option:
```bash
terraform apply -var="target_group_port=8080"
```

## Additional Information
### Configuration Details
- The variable `aws_region` allows you to specify the AWS region. If not provided, it defaults to us-east-1.
- The resource `aws_vpc` block creates the VPC with the CIDR block 10.0.0.0/16. You can modify this block to match your specific requirements.