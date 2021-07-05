resource "aws_instance" "My-Webserver" {

  ami                    = "ami-0ab4d1e9cf9a1215a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.webserver_sg.id}"]
  tags = {
    Name = "My-Webserver"
  }
  key_name = "terrraform"
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo yum install docker",
      "sudo service docker start",
      "sudo docker pull gazgeek/springboot-helloworld",
      "sudo docker container run -itd -p 8080:8080 -d gazgeek/springboot-helloworld"

    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("/home/pratik/Downloads/terrraform.pem")
  }

}
