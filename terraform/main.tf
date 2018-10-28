#https://www.youtube.com/watch?v=bO5jeCYkSFY
#https://github.com/InflatibleYoshi/fabric-1.1-kafka-multi-orderer
#https://www.youtube.com/watch?v=gAxK6zYrfxI
#https://github.com/rudiro/fabric

#https://www.youtube.com/watch?v=gAxK6zYrfxI

provider "aws" {
  region     = "${var.region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"

  version = "1.8"
}

variable "n" {
  default = 2
}

resource "aws_vpc" "fabric-vpc" {
   cidr_block           = "${var.cidr_block}"
   #tags {
     # PROBLEM NOT POSSIBLE WHEN IMPORTING VPC
    #Name = "${var.environment}_${var.project}_${var.product}"
    #Name = "get_productive"
  #}
}

resource "aws_subnet" "fabric-public-subnet" {
  vpc_id                  = "${aws_vpc.fabric-vpc.id}"
  cidr_block              = "10.160.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"
  tags {
    Name = "FABRIC_MULTINODE_PUBLIC_SUBNET"
  }

}
resource "aws_eip" "eip" {
  vpc      = true
  #depends_on = ["aws_internet_gateway.igw"]
  tags {
    Name = "${var.environment}_${var.project}_${var.product}_EIP"
  }

}

resource "aws_nat_gateway" "natgw_az1" {
    allocation_id = "${aws_eip.eip.id}"
    subnet_id = "${aws_subnet.fabric-public-subnet.id}"
    #depends_on = ["aws_internet_gateway.igw"]
    tags {
      Name = "${var.environment}_${var.project}_${var.product}_NATGW_az1"
    }

}

resource "aws_route_table" "publicroute" {
  vpc_id = "${aws_vpc.fabric-vpc.id}"
  tags {
    Name = "${var.environment}_${var.project}_${var.product}_publicroute"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = "${aws_route_table.publicroute.id}"
  #gateway_id             = "${aws_internet_gateway.igw.id}"
  gateway_id             = "igw-0fdb5240939b77ebf"
  
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "internet" {
  route_table_id         = "${aws_route_table.publicroute.id}"
  #gateway_id             = "${aws_internet_gateway.igw.id}"
  gateway_id             = "igw-0fdb5240939b77ebf"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table" "internroute" {
  vpc_id = "${aws_vpc.fabric-vpc.id}"
  tags {
    Name = "${var.environment}_${var.project}_${var.product}_internroute"
  }

}

resource "aws_route" "nat" {
  route_table_id         = "${aws_route_table.internroute.id}"
  nat_gateway_id         = "${aws_nat_gateway.natgw_az1.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "route_subnet_3" {
  subnet_id      = "${aws_subnet.fabric-public-subnet.id}"
  route_table_id = "${aws_route_table.publicroute.id}"
}


resource "aws_route_table_association" "route_private_subnet_1" {
  subnet_id      = "${aws_subnet.fabric-subnet.id}"
  route_table_id = "${aws_route_table.internroute.id}"
}










resource "aws_subnet" "fabric-subnet" {
  vpc_id                  = "${aws_vpc.fabric-vpc.id}"
  cidr_block              = "10.160.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-central-1a"
  tags {
    Name = "FABRIC_MULTINODE_SUBNET"
  }

}



#variable "public_key_path" {
#  description = "Enter the path to the SSH Public Key to add to AWS."
#  default     = "/Users/rudiro/.ssh/kafka_aws.pub"
#}

#resource "aws_key_pair" "auth" {
#  key_name   = "HL_UBUNTU"
#  #public_key = "${file(var.public_key_path)}"
#}

resource "aws_efs_file_system" "blockchain-data" {}

resource "aws_efs_mount_target" "multi-machine-HLF11" {
  ip_address      = "10.160.2.240"
  file_system_id  = "${aws_efs_file_system.blockchain-data.id}"
  subnet_id       = "${aws_subnet.fabric-subnet.id}"
  security_groups = ["${aws_security_group.allow_http.id}"]
  depends_on      = ["aws_efs_file_system.blockchain-data"]

}

resource "aws_instance" "fabric" {
  count                  = 1
  availability_zone      = "eu-central-1a"
  private_ip             = "10.160.2.5"
  ami                    = "ami-062903ba092e9a0b5"
  instance_type          = "t2.small"
  key_name               = "HL_UBUNTU"
  subnet_id              = "${aws_subnet.fabric-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]

  tags {
    Name = "FABRIC_MULTINODE_PEERS_FABRIC"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 10.160.2.240:/ /home/ubuntu/fabric-1.1-kafka-multi-orderer",
      "sudo chown -R ubuntu fabric-1.1-kafka-multi-orderer",
      "source .profile",
      "git clone https://github.com/rudiro/fabric",
      "mv fabric/* fabric-1.1-kafka-multi-orderer/.",
      "cd fabric-1.1-kafka-multi-orderer",
      "python start.py ${var.n} terraform",
    ]

    # "cd composer",
    # "chmod +x ./howtobuild.sh",
    # "/howtobuild.sh",
    # "cd ..",
    # "sudo chown -R ubuntu ../",
    # "/startFabric.sh",
    # "chmod +x createPeerAdminCard.sh",
    # "/createPeerAdminCard.sh",
    # "composer-playground",

    connection {
      type = "ssh"
      user = "ubuntu"
      #key_file = "/Users/rudiro/.ssh/HL_UBUNTU"
      private_key = "${file("/Users/rudiro/.ssh/HL_UBUNTU")}"
    }
  }

  depends_on = ["aws_efs_mount_target.multi-machine-HLF11"]
}

resource "aws_instance" "fabric-peers" {
  count                  = "${var.n - 1}"
  availability_zone      = "eu-central-1a"
  private_ip             = "10.160.2.${count.index + 6}"
  ami                    = "ami-062903ba092e9a0b5"
  instance_type          = "t2.small"
  key_name               = "HL_UBUNTU"
  subnet_id              = "${aws_subnet.fabric-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]

  provisioner "remote-exec" {
    inline = [
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 10.160.2.240:/ /home/ubuntu/fabric-1.1-kafka-multi-orderer",
      "sudo chown -R ubuntu fabric-1.1-kafka-multi-orderer",
    ]

    # "source .profile",
    # "cd fabric-1.1-kafka-multi-orderer",
    # "chmod +x startFabric-Peer${count.index + 2}.sh",
    # "/startFabric-Peer${count.index + 2}.sh",
    # "chmod +x createPeerAdminCard.sh",
    # "/createPeerAdminCard.sh",
    # "composer-playground",

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("/Users/rudiro/.ssh/HL_UBUNTU")}"
    }
  }

  #depends_on = ["aws_instance.fabric"]
  depends_on = ["aws_efs_mount_target.multi-machine-HLF11"]
  tags {
    Name = "FABRIC_MULTINODE_PEERS"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP traffic"
  vpc_id      = "${aws_vpc.fabric-vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.160.2.0/24"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8181
    to_port     = 8181
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
