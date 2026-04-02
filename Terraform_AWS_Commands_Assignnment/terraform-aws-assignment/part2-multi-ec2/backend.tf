resource "aws_instance" "backend" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y python3-pip git
              git clone https://github.com/MahiTzy/linux-devops-learning.git
              cd linux-devops-learning/Kubernetes_Commands_Assignment/node-flask-app/backend
              pip3 install -r requirements.txt
              python3 app.py
              EOF
  tags = {
    Name = "seperate-ec2-backend-app"
  }
}