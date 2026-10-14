resource "aws_instance" "example" {
  ami                         = "ami-006f82a1d5a27da54"
  instance_type               = "t3.micro"
  associate_public_ip_address = true

  subnet_id              = aws_subnet.mysubnet.id
  vpc_security_group_ids = [aws_default_security_group.default.id]
  key_name               = "key"

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

  provisioner "remote-exec" {
    inline = [
      "set -e",

      # Install Nginx, Git and rsync
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx git rsync",
      "sudo systemctl enable --now nginx",

      # Clone the repository or update the existing clone
      "if [ -d /home/ubuntu/portfolio/.git ]; then sudo git -C /home/ubuntu/portfolio fetch origin main && sudo git -C /home/ubuntu/portfolio reset --hard origin/main; else sudo git clone --branch main https://github.com/sthulasi123/portfolio.git /home/ubuntu/portfolio; fi",

      # Publish files from the port folder
      "sudo rsync -a --delete --exclude='.git' /home/ubuntu/portfolio/port/ /var/www/html/",

      # Set ownership and permissions
      "sudo chown -R www-data:www-data /var/www/html",
      "sudo find /var/www/html -type d -exec chmod 755 {} +",
      "sudo find /var/www/html -type f -exec chmod 644 {} +",

      # Validate and restart Nginx
      "sudo nginx -t",
      "sudo systemctl restart nginx"
    ]
  }
}
