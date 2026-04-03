# 🚀 CI/CD Deployment Assignment

**Flask Backend + Express Frontend with Jenkins on AWS EC2**

---

## 📌 Project Overview

This project demonstrates a complete **CI/CD pipeline** where a Flask backend and an Express frontend are deployed on an AWS EC2 instance. Jenkins is used to automate the deployment process triggered via GitHub webhooks.

---

## 🏗️ Architecture

```
Developer → GitHub → Webhook → Jenkins Server → SSH → App Server
                                             ↓
                              Flask (5000) + Express (3000) + PM2
                                             ↓
                                          User
```

---

## ⚙️ Tech Stack

* AWS EC2
* Flask (Python)
* Express (Node.js)
* Jenkins (CI/CD)
* GitHub (Source Control)
* PM2 (Process Manager)
* Axios (API communication)

---

## 🧱 Infrastructure Setup

### 1️⃣ EC2 Instances

* **Jenkins Server** → Handles CI/CD
* **Application Server** → Hosts Flask & Express apps

---

### 2️⃣ Installed Dependencies

#### On App Server:

```bash
sudo apt update
sudo apt install python3-pip nodejs npm git -y
sudo npm install -g pm2
```

#### On Jenkins Server:

* Java (OpenJDK 17)
* Jenkins

---

## 📦 Application Setup

### 🔹 Backend (Flask)

```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

Run with PM2:

```bash
pm2 start app.py --name backend --interpreter ./venv/bin/python
```

---

### 🔹 Frontend (Express)

```bash
cd frontend
npm install
```

Run with PM2:

```bash
pm2 start app.js --name frontend
```

---

## 🔁 CI/CD Pipeline (Jenkins)

### 📄 Jenkinsfile (Example)

```groovy
pipeline {
    agent any

    stages {
        stage('Deploy Frontend') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@<APP_SERVER_IP> "
                cd linux-devops-learning/Jenkins_Pipeline_Assignment/node-flask-app/frontend &&
                git reset --hard &&
                git clean -fd &&
                git pull &&
                npm install &&
                pm2 restart frontend || pm2 start app.js --name frontend
                "
                '''
            }
        }
    }
}
```

---

## 🔗 GitHub Webhook Integration

1. Go to GitHub Repo → Settings → Webhooks

2. Add Webhook:

   * **Payload URL**:

     ```
     http://<JENKINS-IP>:8080/github-webhook/
     ```
   * Content Type: `application/json`
   * Event: `Just the push event`

3. Enable in Jenkins:

   ```
   Build Triggers → GitHub hook trigger for GITScm polling
   ```

---

## 🔐 SSH Setup (Jenkins → App Server)

```bash
sudo su - jenkins
ssh-keygen
ssh-copy-id ubuntu@<APP_SERVER_IP>
```

---

## 🧪 Testing

### Backend:

```
http://<APP-IP>:5000/
```

### Frontend:

```
http://<APP-IP>:3000/
```

---

## 🔍 Troubleshooting

| Issue                        | Solution                              |
| ---------------------------- | ------------------------------------- |
| `ModuleNotFoundError`        | Use venv interpreter in PM2           |
| Git conflicts                | Use `git reset --hard` or fresh clone |
| SSH Permission Denied        | Configure SSH keys properly           |
| Webhook not triggering       | Check Jenkins port & webhook delivery |
| Host key verification failed | Use `StrictHostKeyChecking=no`        |

---

## 💡 Key Learnings

* CI/CD automation using Jenkins
* GitHub webhook integration
* Multi-server deployment architecture
* Process management using PM2
* Handling real-world deployment issues

---

## 🧠 Interview Summary

> Implemented a CI/CD pipeline where GitHub triggers Jenkins via webhook. Jenkins pulls the latest code and deploys it to an EC2 application server using SSH. Flask and Express applications are managed using PM2 for high availability.

---

## 🚀 Future Improvements

* Add Nginx reverse proxy
* Use Docker for containerization
* Implement Kubernetes deployment
* Add automated testing stage

---

## 👨‍💻 Author

Mohit Singh

---
