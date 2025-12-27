Day 19: Terraform Provisioners Demo (null_resource & Cleanup)
Overview

This project demonstrates the usage of Terraform provisioners and null_resource through a hands-on EC2 demo.

Provisioners allow Terraform to execute commands after resource creation or during destruction.
Although provisioners are discouraged for production, they are important to understand for edge cases and legacy workflows.

This demo covers:

file provisioner

remote-exec provisioner

local-exec provisioner

null_resource with triggers

when = destroy cleanup provisioners

Best-practice alternatives

What This Demo Does

Creates an EC2 instance using Terraform

Copies a shell script from local machine to EC2

Executes the script on the EC2 instance

Uses null_resource to run local commands

Runs cleanup commands during terraform destroy

Explains why provisioners should be avoided in production

Architecture Flow
Terraform Apply
   ↓
EC2 Instance Created
   ↓
File Provisioner → Copies script
   ↓
Remote Exec → Runs script on EC2
   ↓
Null Resource → Runs local command

Terraform Destroy
   ↓
Remote Cleanup on EC2
   ↓
Local Cleanup Command
   ↓
Resources Destroyed

File Structure
day19/
├── provider.tf
├── versions.tf
├── security_group.tf
├── ec2.tf
├── null_resource.tf
├── scripts/
│   └── welcome.sh
└── README.md

Step 1: EC2 Creation

An EC2 instance is created using the latest Amazon Linux AMI resolved via SSM.

Key points:

Uses default VPC for simplicity

SSH access enabled for demo purposes

Lightweight instance type

Step 2: File & Remote-Exec Provisioners

A shell script is copied from the local system to the EC2 instance and executed remotely.

Script Functionality

Writes a welcome message to /tmp/welcome_msg.txt

Appends system information

Prints file contents

This demonstrates post-creation configuration using provisioners.

Step 3: null_resource with local-exec

A null_resource is used to run a local command when the EC2 instance is created.

Why null_resource?

No real infrastructure is required

Used to trigger automation or scripts

Controlled using triggers

The trigger is tied to the EC2 instance ID, so it re-runs when the instance is recreated.

Step 4: Destroy-Time Provisioners

Cleanup tasks are executed during terraform destroy.

Remote Cleanup

Deletes files created on the EC2 instance

Local Cleanup

Prints a cleanup message locally

⚠️ Destroy provisioners are best-effort only and should not be relied upon for critical cleanup.

Important Notes (Best Practices)

Terraform provisioners are imperative, not declarative

Failures may leave infrastructure in an inconsistent state

Provisioners should be used only as a last resort

Recommended Alternatives

user_data / cloud-init

Packer (custom AMIs)

Configuration management tools (Ansible)

How to Run
terraform init
terraform plan
terraform apply

Cleanup
terraform destroy

Key Learnings

How Terraform provisioners work

Difference between local-exec and remote-exec

Purpose of null_resource

When and why destroy provisioners are used

Why provisioners are discouraged in production

✅ Day 19 Completed

This demo provides a clear understanding of Terraform provisioners, their limitations, and real-world alternatives.

📌 Reference

Challenge inspired by:
https://github.com/piyushsachdeva/Terraform-Full-Course-Aws