resource "aws_instance" "frontend" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type
  key_name      = var.key_name


  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y nodejs npm git
              git clone https://github.com/MahiTzy/linux-devops-learning.git
              cd linux-devops-learning/Kubernetes_Commands_Assignment/node-flask-app/frontend
              npm install
              node app.js
              EOF
  tags = {
    Name = "seperate-ec2-frontend-app"
  }
}
