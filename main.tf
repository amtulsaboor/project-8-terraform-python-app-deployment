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
