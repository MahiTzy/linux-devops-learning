resource "aws_instance" "app" {
  ami           = "ami-0f5ee92e2d63afc18" # Ubuntu (check latest)
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y python3-pip nodejs npm git


              git clone https://github.com/MahiTzy/linux-devops-learning.git
              cd linux-devops-learning/Kubernetes_Commands_Assignment/node-flask-app

              # Backend
              cd backend
              pip3 install -r requirements.txt
              nohup python3 app.py &

              # Frontend
              cd ../frontend
              npm install
              nohup node app.js &
              EOF

  tags = {
    Name = "single-ec2-app"
  }
}