define aws_puppet_mgmt::ec2_instance_flusher (
  $ec2_name = $title,
){
  file { "/root/.ssh/techops_key":
    ensure => present,
    mode   => "0400",
    owner  => root,
    group  => root,
    source => 'puppet:///modules/users/techops_rsa',
  }

  $ec2_fqdn = "${ec2_name}.improve"
 # notify{$ec2_fqdn:}

  file { "/opt/aws_module/flushing_${ec2_fqdn}":
    ensure => present,
    mode   => "0500",
    owner  => root,
    group  => root,
    content => template('aws_puppet_mgmt/ec2_flusher.sh.erb'),
    require => File['/opt/aws_module'],
  }

}
