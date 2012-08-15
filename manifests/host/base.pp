class ekeyd::host::base inherits ekeyd::base {
  sysctl::value{'kernel.random.write_wakeup_threshold':
    value => 1024
  }

  Service['ekeyd']{
    before => Service['egd-linux'],
  }

  class { 'ekeyd::egd' :
    manage_shorewall => $ekeyd::manage_shorewall
  }
}
