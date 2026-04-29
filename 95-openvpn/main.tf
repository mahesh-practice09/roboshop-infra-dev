resource "aws_instance" "openvpn" {
   ami = data.aws_ami.openvpnami.id
   instance_type = var.instance_type
   subnet_id = local.public_subnet_ids[0]
   vpc_security_group_ids = [ local.openvpnsg_id ]
   user_data = file("openvpn.sh")
   tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-openvpn"})     
   root_block_device {
         volume_size = 50
         volume_type = "gp3"
         tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-openvpn"})  
   }
}