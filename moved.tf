moved {
  from = aws_iam_role.privatebin_ec2
  to   = module.privatebin.aws_iam_role.privatebin_ec2
}

moved {
  from = aws_iam_role_policy_attachment.ssm
  to   = module.privatebin.aws_iam_role_policy_attachment.ssm
}

moved {
  from = aws_iam_role_policy.privatebin_s3
  to   = module.privatebin.aws_iam_role_policy.privatebin_s3
}

moved {
  from = aws_iam_instance_profile.privatebin
  to   = module.privatebin.aws_iam_instance_profile.privatebin
}

moved {
  from = aws_security_group.privatebin
  to   = module.privatebin.aws_security_group.privatebin
}

moved {
  from = aws_instance.privatebin
  to   = module.privatebin.aws_instance.privatebin
}
