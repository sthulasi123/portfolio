resource "aws_instance" "example" {
  ami           = "ami-006f82a1d5a27da54"
  instance_type = "t3.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.mysubnet.id
  security_groups = [aws_default_security_group.default.id]
  key_name = "key"

  tags = {
    Name = "portfolio-EC2"
  }


connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("${path.module}/key.pem")
  host        = self.public_ip
  timeout     = "5m"
}

# Upload local website files to the Ubuntu home directory
provisioner "file" {
  source      = "${path.module}/index.html"
  destination = "/home/ubuntu/index.html"
}

provisioner "file" {
  source      = "${path.module}/thulasi.jpg"
  destination = "/home/ubuntu/thulasi.jpg"
}

# Install Nginx and publish the website
provisioner "remote-exec" {
  inline = [
    "sudo apt-get update -y",
    "sudo apt-get install -y nginx",
    "sudo cp /home/ubuntu/index.html /var/www/html/index.html",
    "sudo cp /home/ubuntu/thulasi.jpg /var/www/html/thulasi.jpg",
    "sudo chown -R www-data:www-data /var/www/html",
    "sudo find /var/www/html -type d -exec chmod 755 {} \\;",
    "sudo find /var/www/html -type f -exec chmod 644 {} \\;",
    "sudo systemctl enable nginx",
    "sudo systemctl restart nginx"
  ]
}

}
