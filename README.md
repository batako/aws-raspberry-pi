# Create Packer vars file

```
cat > ./packer/variables.pkrvars.hcl << EOF
region        = "ap-northeast-1"
ami_name      = "raspberry-pi-dev"
instance_type = "t2.micro"
ssh_username  = "ec2-user"
environment   = "dev"
EOF
```

# Create Terraform vars file

```
cat > ./terraform/terraform.tfvars << EOF
aws_region          = "ap-northeast-1"
aws_profile         = "automan"
base_ami_name       = "raspberry-pi-dev_*"
my_cidr_block       = "xxx.xxx.xxx.xxx/32"
route53_zone_name   = "my-domain"
route53_record_name = "my-sub-domain"
EOF
```
