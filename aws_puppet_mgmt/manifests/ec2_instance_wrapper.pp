define aws_puppet_mgmt::ec2_instance_wrapper(
  $ensure,
  $region,
  $image_id,
  $instance_type,
  $subnet,
  $security_groups,
  $block_devices,
  $key_name,
  $user_data = undef,
  $monitoring = undef,
  $availability_zone = undef,
  $private_ip_address = undef,
  $associate_public_ip_address = undef,
  $ebs_optimized = undef,
  $instance_initiated_shutdown_behavior = undef,
  $hypervisor = undef,
  $virtualization_type = undef,
  $public_ip_address = undef,
  $private_dns_name = undef,
  $public_dns_name = undef,
  $kernel_id = undef,
  $iam_instance_profile_name = undef,
  $iam_instance_profile_arn = undef,
  $role = undef
){
  ec2_instance{ $title:
   ensure  => $ensure,
   region  => $region,
   image_id  => $image_id,
   instance_type => $instance_type,
   subnet  => $subnet,
   security_groups  => $security_groups,
   user_data => template('aws_puppet_mgmt/aws_ec2_init.sh.erb'),
   block_devices => $block_devices,
   key_name  => $key_name,
   monitoring  => $monitoring,
   availability_zone => $availability_zone,
   private_ip_address  => $private_ip_address,
   associate_public_ip_address => $associate_public_ip_address,
   ebs_optimized => $ebs_optimized,
   instance_initiated_shutdown_behavior  => $instance_initiated_shutdown_behavior,
   hypervisor  => $hypervisor,
   virtualization_type => $virtualization_type,
   public_ip_address => $public_ip_address,
   private_dns_name  => $private_dns_name,
   public_dns_name => $public_dns_name,
   kernel_id => $kernel_id,
   iam_instance_profile_name => $iam_instance_profile_name,
   iam_instance_profile_arn  => $iam_instance_profile_arn,
  }

  # flushin instance from LDAP, DNS, puppet
  if $ensure == 'absent' {
    aws_puppet_mgmt::ec2_instance_flusher{ $title: }
  }

}
