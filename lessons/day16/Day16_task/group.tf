resource "aws_iam_group" "education" {
  name = "Education"
  path = "/groups/"
}

resource "aws_iam_group" "managers" {
  name = "Managers"
  path = "/groups/"
}

resource "aws_iam_group" "engineers" {
  name = "Engineers"
  path = "/groups/"
}

resource "aws_iam_group_membership" "education_membership" {
  name = "education-group-membership"
  group = aws_iam_group.education.name
  users = [
    for user in aws_iam_user.users :
    user.name if user.tags["Department"] == "Education"
  ] 
}

resource "aws_iam_group_membership" "engineers_membership" {
  name = "engineers-group-membership"
  group = aws_iam_group.engineers.name
  users = [
    for user in aws_iam_user.users :
    user.name if user.tags["Department"] == "Engineering"
  ] 
  
}

resource "aws_iam_group_membership" "managers_membership" {
  name = "managers-group-membership"
  group = aws_iam_group.managers.name
  users = [
    for user in aws_iam_user.users :
    user.name if user.tags["JobTitle"] == "Manager"
  ]
  
}

# Education → ReadOnly
resource "aws_iam_group_policy_attachment" "education_readonly" {
  group      = aws_iam_group.education.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Engineers → PowerUser
resource "aws_iam_group_policy_attachment" "engineers_poweruser" {
  group      = aws_iam_group.engineers.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# Managers → Administrator
resource "aws_iam_group_policy_attachment" "managers_admin" {
  group      = aws_iam_group.managers.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
