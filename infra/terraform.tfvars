name                 = "vpc-sample"
vpc-cidr             = "10.0.0.0/16"
private-subnets-cidr = ["10.0.1.0/24", "10.0.2.0/24"]
public-subnets-cidr  = ["10.0.101.0/24", "10.0.102.0/24"]
region               = "eu-west-1"
bucket-name          = "upload-file-to-s3-bucket-145"
topic-name           = "s3-event-send-email"
email                = "milad.be@gmail.com"
