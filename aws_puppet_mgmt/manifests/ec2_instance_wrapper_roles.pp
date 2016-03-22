define aws_puppet_mgmt::ec2_instance_wrapper_roles(
  $ensure = undef,
  $role,
  $region = undef,
  $image_id = undef,
  $instance_type = undef,
  $subnet = undef,
  $security_groups = undef,
  $block_devices = undef,
  $key_name = undef,
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
){

  $roles_hash = hiera_hash('aws_puppet_mgmt::ec2_roles', {})
  $role_params = $roles_hash[$role]

  $ec2_instances = hiera_hash('aws_puppet_mgmt::ec2_instances', {})
  $instance_params = $ec2_instances[$title]
  $full_role_params = merge($role_params, $instance_params)
  #building normal hash with index and key-value pairs
  $full_role_params_with_index = {$title => $full_role_params}

  create_resources('aws_puppet_mgmt::ec2_instance_wrapper', $full_role_params_with_index, {})
}