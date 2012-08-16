class ekeyd::client::base {
  # To allow a host to also have the client installed
  if ! defined(Class['ekeyd::egd']) {
    class { 'ekeyd::egd':}
  }
}
