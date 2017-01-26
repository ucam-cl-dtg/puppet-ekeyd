# masterkey is used to configure access to the entropy key, set to ''
#  to disable
# host_ip and port are the TCP ip and port that egd will be serving on
# manage_munin and manage_shorewall configure whether those services should be enabled
class ekeyd(
  $masterkey,
  $host             = false,
  $host_ip          = '127.0.0.1',
  $port             = '8888',
  $outputmode    = 'tcp',
  $manage_munin     = false,
  $manage_shorewall = false,
){

  if $::ekeyd_key_present != 'true'{
    if !$::clientnoop {
      fail("Can't find an ekey key plugged into usb on ${::fqdn}, ${::clientnoop}")
    } else {
      warning("Can't find an ekey key plugged into usb on ${::fqdn}")
    }
  }

  case $::operatingsystem {
    ubuntu: { include ekeyd::debian }
    debian: { include ekeyd::debian }
    default: { include ekeyd::base }
  }

  if $ekeyd::host {
    case $::operatingsystem {
      centos: { include ekeyd::host::centos }
      default: { include ekeyd::host::base }
    }

    if $ekeyd::manage_shorewall {
      include shorewall::rules::ekeyd
    }
  }

  if $ekeyd::manage_munin {
    include ekeyd::munin
  }
}
