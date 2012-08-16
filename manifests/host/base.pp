class ekeyd::host::base inherits ekeyd::base {
  sysctl::value{'kernel.random.write_wakeup_threshold':
    value => 1024
  }

  Service['ekeyd']{
    before => Service['egd-linux'],
  }

  # To allow the host to also have the client installed
  if ! defined(Class['ekeyd::egd']) {
    class { 'ekeyd::egd' :
      manage_shorewall => $ekeyd::manage_shorewall
    }
  }
}
