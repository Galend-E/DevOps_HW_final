provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "build" {
  ami = "ami-0bcc094591f354be2"
  instance_type = "t2.micro"
  key_name = "ansible"
  security_groups = ["sg-02cc480bb425000f4"]
  subnet_id = "subnet-8f7f0ec2"
  associate_public_ip_address = true
  tags = {
    Name = "build"
  }

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ~/.ssh/ansible.pem -i '${aws_instance.build.public_ip},' build.yml"
  }
}

resource "aws_instance" "web" {
  ami = "ami-0bcc094591f354be2"
  instance_type = "t2.micro"
  key_name = "ansible"
  security_groups = ["sg-02cc480bb425000f4"]
  subnet_id = "subnet-8f7f0ec2"
  depends_on = ["aws_instance.build"]
  associate_public_ip_address = true
  tags = {
    Name = "web"
  }

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ~/.ssh/ansible.pem -i '${aws_instance.web.public_ip},' web.yml"
  }
}