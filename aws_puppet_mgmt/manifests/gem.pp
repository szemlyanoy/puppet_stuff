define aws_puppet_mgmt::gem (
  $package = $name,
  $version = undef,
  $ensure = present
){
  # gem command should either recieve version value or avoid passing any flags like '-v'
  if !empty($version){
    $version_option = "-v $version"
    $version_filter = "| grep $version"
  }

  if $ensure == 'present'{
    exec{ "${package}_install":
      command => "/opt/puppetlabs/puppet/bin/gem install $package $version_option",
      onlyif  => "/bin/test `/opt/puppetlabs/puppet/bin/gem list $package|grep $package $version_filter >/dev/null; echo $?` -ne 0",
    }
  }
  elsif $ensure == 'absent'{
    exec{ "${package}_removal":
      command => "/opt/puppetlabs/puppet/bin/gem uninstall $package $version_option",
      onlyif  => "/bin/test `/opt/puppetlabs/puppet/bin/gem list $package|grep $package $version_filter >/dev/null; echo $?` -eq 0",
    }
  }
}