# Terraform Project: Deploy Python Flask Application on AWS

## 📌 Project Overview

In this project, I deployed a simple **Python Flask web application** using **Terraform**, which is one of the most common real-world tasks performed by DevOps engineers.

Instead of manually creating infrastructure, I automated the deployment process by writing Terraform scripts to provision the required AWS resources and deploy the application.

This project demonstrates how Infrastructure as Code (IaC) helps teams deploy applications faster, maintain consistency, and reduce manual effort.

---

## 🛠 Tech Stack

* **Terraform** – Infrastructure provisioning
* **Python Flask** – Web application
* **AWS** – Cloud infrastructure
* **EC2** – Application hosting
* **Security Groups** – Network access management
* **Git & GitHub** – Version control

---

## 📂 Project Structure

```bash
project-8-terraform-python-app-deployment/
│
├── app.py                # Flask application code
├── requirements.txt      # Python dependencies
├── main.tf               # Main Terraform configuration
├── variables.tf          # Input variables
├── outputs.tf            # Output values
├── provider.tf           # AWS provider configuration
└── README.md             # Project documentation
```

---

## 🎯 Project Objective

The goal of this project was to automate the deployment of a Python application using Terraform.

In real-world environments, DevOps teams frequently receive tasks like:

* Provision infrastructure for applications
* Deploy applications quickly
* Maintain consistency across environments
* Reduce manual configuration errors

This project simulates that exact workflow.

---

## ⚙️ What Terraform Provisioned

Using Terraform, I automated the creation of:

✅ AWS EC2 Instance
✅ Security Group
✅ Application deployment environment
✅ Required configurations to host the Flask app

---

## 🚀 Deployment Workflow

### Step 1: Clone Repository

```bash
git clone https://github.com/amtulsaboor/project-8-terraform-python-app-deployment.git
cd project-8-terraform-python-app-deployment
```

---

### Step 2: Initialize Terraform

```bash
terraform init
```

This downloads the required providers and initializes Terraform.

---

### Step 3: Validate Configuration

```bash
terraform validate
```

This checks whether your Terraform configuration is correct.

---

### Step 4: Preview Infrastructure

```bash
terraform plan
```

This shows what resources Terraform will create.

---

### Step 5: Deploy Infrastructure

```bash
terraform apply
```

Type:

```bash
yes
```

Terraform will provision the infrastructure and deploy the application.

---

## 🌐 Access the Application

After successful deployment:

* Copy the EC2 public IP from Terraform output
* Open it in your browser

Example:

```bash
http://<public-ip>:5000
```

---

## 🔥 Real-World Use Case

This is one of the most common tasks in DevOps:

➡️ Developer creates application
➡️ DevOps engineer automates infrastructure
➡️ Application gets deployed automatically

This project demonstrates how Terraform simplifies that entire workflow.

---

## Key Learnings

Through this project, I learned:

* Writing reusable Terraform scripts
* Automating infrastructure deployment
* Deploying Python applications on AWS
* Managing cloud resources efficiently
* Real-world Infrastructure as Code practices

---

## Cleanup Resources

To avoid unnecessary AWS charges:

```bash
terraform destroy
```

---

## Future Improvements

* Add Docker containerization
* Deploy using AWS ECS/EKS
* Integrate CI/CD pipeline using GitHub Actions or Jenkins
* Store Terraform state remotely using Amazon Web Services S3 + DynamoDB locking

---

## Author

**Amtul Saboor**
DevOps & Cloud Engineer

