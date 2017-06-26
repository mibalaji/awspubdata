# The various ${var.foo} come from variables.tf

# Specify the provider and access details
provider "aws" {
    region = "${var.aws_region}"
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
}


resource "aws_instance" "web" {

  connection {
  user = "ec2-user"
  }
  # subnet ID for our VPC
  subnet_id = "${var.subnet_id}"
  instance_type = "${var.instance_type}"
  ami = "${var.ami_id}"


  # The name of our SSH keypair you've created and downloaded
  key_name = "${var.key_name}"

  user_data = "${file("userdata.sh")}"

  # We set the name as a tag
  tags {
    "Name" = "${var.instance_name}"
  }

  provisioner "file" {
    source      = "credentials"
    destination = "/home/ec2-user/.aws/"
  }

  provisioner "remote-exec" {
    inline = [
      "wget http://regexp.s3.amazonaws.com/list.html",
      "/usr/bin/aws s3 cp list.html s3://${aws_s3_bucket.bucket.bucket}",
      "/usr/bin/aws s3 /data sync s3://${aws_s3_bucket.bucket.bucket} &"
    ]
  }
}



# Creating ebs volume from snapshot

resource "aws_ebs_volume" "public_dataset_example" {
    availability_zone = "${var.aws_az}"
    size = "${var.ebs_size}"
    snapshot_id = "${var.snapshot_id}"
    type = "standard"
}


# Attaching ebs volume created above

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.public_dataset_example.id}"
  instance_id = "${aws_instance.web.id}"
}


# Mounting the volume to data


# Creating S3 bucket

resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}"
    acl = "public-read"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        }
    ]
}
EOF
}
