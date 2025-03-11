# Cloud Engineering Technical Assessment

## Overview
This assessment evaluates your proficiency with Docker, Terraform, AWS (specifically ECS), and CI/CD pipelines. You'll be containerizing a simple Python application and deploying it to AWS ECS using Terraform. If you are not familiar with any of the technologies, feel free to complete as much as you can.

## Time Expectation
This assessment should take approximately 3-4 hours to complete.

## Requirements

### Part 1: Containerization
- Containerize the provided Python Flask application
- Create an optimized Dockerfile that follows security best practices
- Ensure the container properly runs the application on port 5000

### Part 2: Infrastructure as Code
- Create Terraform configurations to deploy the application to AWS ECS
- Set up the following AWS resources:
  - VPC with public and private subnets
  - ECS Cluster (Fargate launch type)
  - ECS Task Definition and Service for the containerized application
  - All necessary security groups, IAM roles, etc.
- Feel free to use any ready-made open-source terraform modules available

### Part 3: CI/CD Implementation
- Create a CI/CD pipeline configuration using GitHub Actions
- The pipeline should:
  - Build and tag the Docker image
  - Push the image to Amazon ECR
  - Deploy the updated image to ECS

### Part 4: Documentation
- Provide a README.md with:
  - Setup and deployment instructions
  - Potential improvements for a production environment
- Optionally include a simple architecture diagram (can be created with any tool)

## Deliverables
Please provide:
1. All source code in a GitHub repository (public or private with access shared)
2. Complete Terraform configurations
3. CI/CD pipeline configuration files
4. Documentation and architecture diagram (if you have any)
5. Any additional scripts or configurations you created

## Evaluation Criteria
Your submission will be evaluated based on:
- Docker best practices (security, optimization, multi-stage builds)
- Terraform organization, structure, and best practices
- AWS resource configuration and security
- Code quality and documentation
- CI/CD pipeline effectiveness

## Optional Extensions
If you have additional time and would like to demonstrate more of your skills, consider implementing these optional features:
- Adding an Application Load Balancer to distribute traffic to your service
- Configuring CloudWatch Logs for container logging

## Files Included in This Package
1. `app/` - Directory containing the Python Flask application
   - `app.py` - The main application file
   - `requirements.txt` - Python dependencies
2. `README.md` - This file with instructions

Good luck!

## Walkthrough

### VPC

I opted to use an existing module from the registry that would deploy a VPC, 3 public and 3 private subnets, route tables and also an IGW, NACLs and flow logs.
I made the decision at this point to not deploy a NAT GW to save on cost as it would not be required.

### Containerisation

I decided to go for a slim image to keep build and deployment time as low as possible, I went for a single stage build as we don't require the use of apt-get to install dependencies, these are stored in requirements.txt

I have created a new user so we are not using root user privileges. This image was tested locally first on localhost:8080 before setting up ECS

### ECS

I opted to build this module myself, I noted a lot of existing modules had networking resources, such as a VPC and subnets so thought best to do this myself, I decided to deploy into a public subnet and fronted requests with an ALB. The reasoning was additionally configuration being require in private subnets via VPC Endpoints. For public subnets I assigned a public IP to tasks otherwise we get failures to ECR.

### CI/CD

My CI/CD experience is mainly in AWS' suite of services so I first read up on some information regarding GitHub Actions. We login to ECR, build and push our image and then update the service with the new task definition.

## Improvements for a production environment

To make this a production ready multi environment service there are some improvements to be made. 

### Terraform
Firstly, a remote backend, either S3/DynamoDB or TF Cloud. Next we could pull in VPC and Subnet ids via the outputs and store these as locals.

### ECS

We would deploy into private subnets and use VPCEs. Instead of exposing the ALB URL we would deploy a domain name via Route 53 and an ACM cert to secure the traffic over 443. We would also configure container logging.

Finally we would implement service auto scaling

### CI/CD

We could build and tag images with the commit SHA instead of latest and we could also use env vars for the region and IAM Role.

We could also do a blue/green deployment to send 10% of traffic for 10 minutes to a new task before switching over.
