define aws_puppet_mgmt::ec2_instance_flusher (
  $ec2_name = $title,
){
  $ec2_fqdn = "${ec2_name}.improve"
 # notify{$ec2_fqdn:}

  file { "/opt/aws_module/flushing_${ec2_fqdn}.sh":
    ensure => present,
    mode   => "0500",
    owner  => root,
    group  => root,
    content => template('aws_puppet_mgmt/ec2_flusher.sh.erb'),
    require => File['/opt/aws_module'],
  }

  exec {"${ec2_fqdn}_flushing":
    command  => "/opt/aws_module/flushing_${ec2_fqdn}.sh",
    require  => File["/opt/aws_module/flushing_${ec2_fqdn}.sh"],
  }
}
