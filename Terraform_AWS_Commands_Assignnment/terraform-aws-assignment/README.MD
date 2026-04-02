# 🚀 AWS Deployment Assignment – DevOps Project

## 📌 Overview

This project demonstrates deployment of a **Flask backend** and **Node.js (Express) frontend** using three different architectures:

1. **Single EC2 Deployment**
2. **Separate EC2 Deployment**
3. **Containerized Deployment using ECS, ECR, and ALB (Fargate)**

The goal is to understand infrastructure evolution from basic VM hosting to modern containerized cloud deployment.

---

# 🏗️ Architecture Summary

## 🔹 Part 1: Single EC2 Instance

* Both frontend and backend run on the same EC2 instance
* Different ports:

  * Frontend → `3000`
  * Backend → `5000`

## 🔹 Part 2: Separate EC2 Instances

* Frontend and backend deployed on different EC2 instances
* Communication via public/private IP

## 🔹 Part 3: ECS + ECR + ALB (Fargate)

* Applications containerized using Docker
* Images stored in ECR
* ECS Fargate runs containers (serverless)
* ALB routes traffic to frontend container

---

# 🛠️ Tech Stack

* **Frontend:** Node.js (Express)
* **Backend:** Flask (Python)
* **Containerization:** Docker
* **Cloud:** AWS (EC2, ECS, ECR, ALB, VPC)
* **Infrastructure as Code:** Terraform

---

# 📁 Project Structure

```
project-root/
│
├── frontend/
│   ├── app.js
│   ├── package.json
│   └── Dockerfile
│
├── backend/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── terraform/
│   ├── provider.tf
│   ├── vpc.tf
│   ├── alb.tf
│   ├── ecs.tf
│   ├── outputs.tf
│
└── README.md
```

---

# ⚙️ Prerequisites

* AWS CLI configured
* Terraform installed
* Docker installed
* Git installed

---

# 🚀 Part 1: Single EC2 Deployment

## Steps:

1. Launch EC2 instance

2. Install dependencies:

   ```bash
   sudo apt update
   sudo apt install python3-pip nodejs npm git -y
   ```

3. Clone repo:

   ```bash
   git clone <repo_url>
   ```

4. Run backend:

   ```bash
   cd backend
   pip3 install -r requirements.txt
   python3 app.py
   ```

5. Run frontend:

   ```bash
   cd ../frontend
   npm install
   node app.js
   ```

---

# 🚀 Part 2: Separate EC2 Deployment

## Backend EC2:

```bash
sudo apt update
sudo apt install python3-pip git -y
git clone <repo_url>
cd backend
pip3 install -r requirements.txt
python3 app.py
```

## Frontend EC2:

```bash
sudo apt update
sudo apt install nodejs npm git -y
git clone <repo_url>
cd frontend
npm install
node app.js
```

## Important:

Update frontend API URL:

```javascript
http://<backend-ip>:5000
```

---

# 🚀 Part 3: ECS + ECR + ALB Deployment

---

## 🔹 Step 1: Build Docker Images

```bash
docker build -t frontend ./frontend
docker build -t backend ./backend
```

---

## 🔹 Step 2: Login to ECR

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

---

## 🔹 Step 3: Tag Images

```bash
docker tag frontend:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/learning/frontend:latest
docker tag backend:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/learning/backend:latest
```

---

## 🔹 Step 4: Push Images

```bash
docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/learning/frontend:latest
docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/learning/backend:latest
```

---

## 🔹 Step 5: Deploy using Terraform

```bash
terraform init
terraform apply
```

---

## 🔹 Step 6: Access Application

```bash
terraform output alb_dns
```

Open in browser:

```
http://<alb_dns>
```

---

# ⚠️ Important Configuration Notes

### Node.js

```javascript
app.listen(3000, "0.0.0.0")
```

### Flask

```python
app.run(host="0.0.0.0", port=5000)
```

### Frontend → Backend Communication

```javascript
http://backend:5000
```

---

# 🔍 Troubleshooting

| Issue                 | Fix                                       |
| --------------------- | ----------------------------------------- |
| 503 Error             | Check target group health                 |
| Timeout               | Ensure ALB is public (`internal = false`) |
| Container crash       | Check ECS logs                            |
| ECR push fails        | Login again using AWS CLI                 |
| Backend not reachable | Use `backend` hostname                    |

---

# 🎯 Key Learnings

* Difference between **EC2 vs Fargate**
* Infrastructure automation using **Terraform**
* Container deployment using **ECS & ECR**
* Load balancing with **ALB**
* Multi-tier application architecture

---

# 📌 Conclusion

This project demonstrates a complete DevOps workflow:

* Build → Containerize → Push → Deploy → Scale

It highlights how modern applications evolve from:

```
Single Server → Distributed → Containerized Cloud Architecture
```

---

# 🙌 Author

**Mohit Singh**
DevOps / Cloud Enthusiast 🚀

---
