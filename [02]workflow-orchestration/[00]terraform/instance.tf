resource "aws_instance" "web" {
  ami           = var.amiID[var.region]
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [
    aws_security_group.just_test.id
  ]
  availability_zone = var.zone

  tags = {
    "Name"    = "The kestra"
    "Project" = "test"
  }

  root_block_device {
    volume_size = 20
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "file" {
    source      = "docker-compose-postgres.yml"
    destination = "/tmp/docker-compose.yml"
  }


  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("developer")
    host        = self.public_ip
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ip.txt"

  }
}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

output "web_public_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.web.public_ip
}

output "web_private_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.web.private_ip
}

output "web_public_dns" {
  description = "Public IP of the instance"
  value       = aws_instance.web.public_dns
}

