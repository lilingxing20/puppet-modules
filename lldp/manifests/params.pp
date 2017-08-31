class lldp::params {

  $admin_mode          = 'rxtx'
  $enable_sys_name_tx  = true
  $enable_sys_cap_tx   = true
  $enable_sys_desc_tx  = true
  $enable_port_desc_tx = true
  $enable_mng_addr_tx  = true

  if $::osfamily == 'Debian' {
    $package_name = 'lldpad'
    $service_name = 'lldpad'

  } elsif($::osfamily == 'RedHat') {

    $package_name = 'lldpad'
    $service_name = 'lldpad'

  } else {
    fail("unsupported osfamily ${::osfamily}, currently Debian and Redhat are the only supported platforms")
  }
}
