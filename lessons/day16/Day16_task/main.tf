locals {
  users = csvdecode(file("users.csv"))
}

resource "aws_iam_user" "users" {
  for_each = { for user in local.users : user.username => user }

  name = each.value.username
  path = "/users/"

  tags = {
    DisplayName = "${each.value.first_name} ${each.value.last_name}"
    Department  = each.value.department
    JobTitle    = each.value.job_title
    Email       = each.value.email
    Phone       = each.value.phone
  }
}


resource "aws_iam_user_login_profile" "users" {
  for_each = aws_iam_user.users
  user = each.value.name
  password_reset_required = true

    lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
    ]
  }
    
}

output "user_passwords" {
  value = {
    for user, profile in aws_iam_user_login_profile.users :
    user => "Password created - user must reset on first login"
  }
  sensitive = true
}

resource "aws_iam_virtual_mfa_device" "mfa_devices" {
  for_each = aws_iam_user.users
  virtual_mfa_device_name = "${each.value.name}_mfa"
  
}



