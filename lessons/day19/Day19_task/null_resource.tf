resource "null_resource" "local_demo" {
     # Trigger re-run when EC2 is recreated
     triggers = {
       instance_id = aws_instance.demo.id
     }
        provisioner "local-exec" {
        command = "echo 'EC2 Instance ID: ${aws_instance.demo.id}' >> ec2_instance_info.txt"
        }

        provisioner "local-exec" {
        when    = destroy
        command = "echo 'Terraform destroy started – local cleanup executed'"
  }
  
}