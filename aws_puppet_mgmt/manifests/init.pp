# Class for managing AWS recources by aws-puppetlabs module. Applies all pre-requisistes

class aws_puppet_mgmt
{
  # ruby gems
  $gems  = hiera_hash('aws_puppet_mgmt::gems', {})
  if !empty($gems){
    create_resources('aws_puppet_mgmt::gem', $gems)
  }
/*
  # ec2 insatnces handling
  $ec2_vms_defaults = hiera_hash('aws_puppet_mgmt::ec2_vms_defaults', {})
 # $ec2_vms_user_data = {user_data => template('files/aws_ec2_init.sh.erb')}
#  $ec2_vms_defaults_merged = merge($ec2_vms_defaults, $ec2_vms_user_data)
  $ec2_vms = hiera_hash('aws_puppet_mgmt::ec2_vms', {})
  if !empty($ec2_vms){
    create_resources('aws_puppet_mgmt::ec2_instance_wrapper', $ec2_vms, $ec2_vms_defaults)
   # create_resources('ec2_instance', $ec2_vms, $ec2_vms_defaults)
    #create_resources('ec2_instance', $ec2_vms, {user_data => template('files/aws_ec2_init.sh.erb')})
  }
*/

 file { '/opt/aws_module':
    ensure  => directory,
    owner   => root,
    group   => root,
    purge   => true,
    recurse => true,
    mode    => '0750',
  }

  file { "/root/.ssh/techops_key":
    ensure => present,
    mode   => "0400",
    owner  => root,
    group  => root,
    source => 'puppet:///modules/users/techops_rsa',
  }
  
  $ec2_instances = hiera_hash('aws_puppet_mgmt::ec2_instances', {})
  create_resources('aws_puppet_mgmt::ec2_instance_wrapper_roles', $ec2_instances, {})
}

