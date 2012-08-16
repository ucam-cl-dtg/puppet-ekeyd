class ekeyd::base {

  package{'ekeyd':
    ensure => installed,
  }

  # TODO (from riseup code)
  # * eventually it would be cool if we could have two classes: one for
  # SetOutputToKernel and one for EGDTCPSocket. But for now we're just going
  # to have puppet deliver the ekeyd.conf file.
  file{'/etc/entropykey/ekeyd.conf':
    content => template("ekeyd/ekeyd.conf.erb"),
    require => Package['ekeyd'],
    notify => Service['ekeyd'],
    owner => root, group => 0, mode => 0644;
  }
  service{'ekeyd':
    ensure => running,
    enable => true,
  }

  if $ekeyd::masterkey != '' {
    exec{'configure_ekeyd_key':
      command => "ekey-rekey `ekeydctl list | grep \"/dev/entropykey\" | awk -F, '{ print \$5}'` ${ekeyd::masterkey}",
      unless => "ekeydctl list | grep -q 'Running OK'",
      require => Service['ekeyd'],
    }
  } else {
    # Not configuring automatically, check was configured manually
    exec {'check_ekeyd_key_configured':
      command => "ekeydctl list | grep -q 'Running OK'",
      require => Service['ekeyd'],
    }
  }
}
