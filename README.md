#  Deploy Python Flask Application Using Terraform on AWS

## Project Overview

This project demonstrates a common real-world DevOps task where a simple **Python Flask application** is deployed on AWS infrastructure using **Terraform**.

Instead of manually creating cloud resources, Terraform automates the provisioning of infrastructure and application deployment.

---

# Prerequisites

Make sure the following are installed:

* Terraform
* AWS CLI
* Python
* Git

Verify installations:

```bash
terraform --version
aws --version
python3 --version
git --version
```

---

# Step 1: Create Project Directory

```bash
mkdir terraform-app-deploy
cd terraform-app-deploy
```
<img width="1710" height="1107" alt="Screenshot 2026-05-17 at 11 52 22 PM" src="https://github.com/user-attachments/assets/a2e91c99-f9ec-4728-80c8-82692f9939ad" />

---

# Step 2: Create Python Application File

Create app file:

```bash
vim app.py
```

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "<h1>Hello, Saboor!</h1><p>Your Python web app is running.</p>"

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)
```
---

# Step 3: Create Provider Configuration

```bash
vim provider.tf
```

Add:

```hcl
provider "aws" {
  region = "us-east-1"
}
```
---

# Step 4: Create Main Terraform File

```bash
vim main.tf
```

Add:

```hcl
resource "aws_key_pair" "example" {
  key_name   = "app-deploy-key"
  public_key = file("/Users/amtulsaboor/.ssh/id_rsa.pub")
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "websg" {
  name        = "web"
  vpc_id      = aws_vpc.myvpc.id

ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server" {
  ami           = "ami-091138d0f0d41ff90"
  instance_type = "t2.micro"
  key_name = aws_key_pair.example.key_name
  subnet_id   = aws_subnet.sub1.id
  vpc_security_group_ids = [aws_security_group.websg.id]

 connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/Users/amtulsaboor/.ssh/id_rsa")
    host = self.public_ip
 }

 provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"
 }

 provisioner "remote-exec" {
  inline = [
    "echo 'Hello from remote instance'",
    "sudo apt update -y",
    "sudo apt-get install -y python3-venv",
    "python3 -m venv /home/ubuntu/venv",
    "/home/ubuntu/venv/bin/pip install flask",
    "sudo bash -c 'nohup /home/ubuntu/venv/bin/python /home/ubuntu/app.py > /home/ubuntu/app.log 2>&1 &'"
  ]
}
}
```
---

# Step 5: Initialize Terraform

```bash
terraform init
```

---

# Step 6: Preview Infrastructure

```bash
terraform plan
```
<img width="1710" height="1107" alt="Screenshot 2026-05-18 at 12 23 15 AM" src="https://github.com/user-attachments/assets/8d5aaba0-cc26-46f6-a615-472674c1aa2c" />

<img width="1710" height="1107" alt="Screenshot 2026-05-18 at 12 23 35 AM" src="https://github.com/user-attachments/assets/a38be3b2-3b7e-44b2-9cd7-73a17c35aab5" />

Shows resources Terraform will create.

---

# Step 7: Deploy Infrastructure

```bash
terraform apply
```

Type:

```bash
yes
```
<img width="1710" height="1107" alt="Screenshot 2026-05-18 at 2 57 22 AM" src="https://github.com/user-attachments/assets/801291b3-e9fb-425d-8a92-e80046056a9a" />

Terraform will create:

* EC2 instance
* Security group
* Flask app deployment

---

# Step 8: Access Application

Open browser:

```bash
http://<public-ip>
```

Output:

```bash
Hello, Saboor!
Your Python web app is running.
```
<img width="1710" height="1107" alt="Screenshot 2026-05-18 at 2 57 47 AM" src="https://github.com/user-attachments/assets/5d467e49-18de-4522-820f-e8583b875f99" />

---

# Project Structure

```bash
terraform-python-app/
│
├── app.py
├── requirements.txt
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

---

# Destroy Resources

To avoid AWS charges:

```bash
terraform destroy
```

Type:

```bash
yes
```
<img width="1710" height="1107" alt="Screenshot 2026-05-18 at 3 01 29 AM" src="https://github.com/user-attachments/assets/9be8c221-3a4d-477e-99ad-f757e1ddeb8c" />

---

# Key Learnings

* Terraform automation
* AWS EC2 provisioning
* Security group configuration
* Python Flask deployment
* Infrastructure as Code (IaC)

---

## Author

**Amtul Saboor**
DevOps & Cloud Engineer 
