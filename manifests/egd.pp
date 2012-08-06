class ekeyd::egd ( 
  $manage_shorewall = false
) {
  if ( $::virtual == "vserver" ) {
    fail("This class shouldn't be included on vservers")
  }

  case $::operatingsystem {
    ubuntu: { include ekeyd::egd::debian }
    debian: { include ekeyd::egd::debian }
    default: { include ekeyd::egd::base }
  }
}
