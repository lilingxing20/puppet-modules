# === Class: lldp::config
#
# This class is used to manage lldped configurations.
#
# === Parameters
#
# [*interface_names*]
#   (optional) List of host interfaces
#   Defaults to value from to lib/facter/physical_interfaces.rb
#
# [*mng_addr_ipv4*]
#   (optional) The host management network IP
#   Defaults to undef
#
# [*mng_addr_interface*]
#   (optional) Wish to pass the management address via LLDP TLV on specific interface
#   Defaults to undef
#
# [*admin_status*]
#   (optional) Configuration LLDP mode
#   Defaults to rxtx
#
# [*enable_sys_name_tx*]
#   (optional) Whether to enable the System Name TLV
#   Defaults to true
#
# [*enable_sys_cap_tx*]
#   (optional) Whether to enable the System 
#   Defaults to true
#
# [*enable_sys_desc_tx*]
#   (optional) Whether to enable System Description TLV
#   Defaults to true
#
# [*enable_port_desc_tx*]
#   (optional) Whether to enable Port Description TLV
#   Defaults to true
#
# [*enable_mng_addr_tx*]
#   (optional) Whether to enable Management Address TLV
#   Defaults to true
#

### func
define config_lldp_mode (
  $mode,
) {
  exec {"Configuration LLDP mode ($name)":
    command => "lldptool set-lldp -i $name adminStatus=$mode",
    path    => "/usr/sbin" ,
  }
}

define set_sys_name_tlv (
  $enabled,
) {
  if $enabled {
    $yesorno = 'yes'
  } else {
    $yesorno = 'no'
  }
  exec {"Enable the system name identifier ($name)":
    command => "lldptool -T -i $name -V sysName enableTx=$yesorno",
    path    => "/usr/sbin",
  }
}

define set_sys_desc_tlv (
  $enabled,
) {
  if $enabled {
    $yesorno = 'yes'
  } else {
    $yesorno = 'no'
  }
  exec {"Enable system description identifier ($name)":
    command => "lldptool -T -i $name -V sysDesc enableTx=$yesorno",
    path    => "/usr/sbin",
  }
}

define set_port_desc_tlv (
  $enabled,
) {
  if $enabled {
    $yesorno = 'yes'
  } else {
    $yesorno = 'no'
  }
  exec {"Enable port description identifier ($name)":
    command => "lldptool -T -i $name -V portDesc enableTx=$yesorno",
    path    => "/usr/sbin",
  }
}

define set_sys_cap_tlv (
  $enabled,
) {
  if $enabled {
    $yesorno = 'yes'
  } else {
    $yesorno = 'no'
  }
  exec {"Enable the system Capabilities identifier ($name)":
    command => "lldptool -T -i $name -V sysCap enableTx=$yesorno",
    path    => "/usr/sbin",
  }
}

define set_mng_addr_tlv (
  $enabled,
) {
  if $enabled {
    $yesorno = 'yes'
  } else {
    $yesorno = 'no'
  }
  exec {"Enable the management address identifier ($name)":
    command => "lldptool -T -i $name -V mngAddr enableTx=$yesorno",
    path    => "/usr/sbin",
  }
}

define config_mng_addr_ipv4 (
  $ipv4,
) {
  exec {"Configuration management address IPv4 ($name)":
    command => "lldptool -T -i $name -V mngAddr ipv4=$ipv4",
    path    => "/usr/sbin",
  }
}


class lldp::config(
  $mng_addr_ipv4       = undef,
  $mng_addr_interface  = undef,
  $interface_names     = split($physical_interfaces, ','),
  $admin_mode          = $lldp::params::admin_mode,
  $enable_sys_name_tx  = $lldp::params::enable_sys_name_tx,
  $enable_sys_cap_tx   = $lldp::params::enable_sys_cap_tx,
  $enable_sys_desc_tx  = $lldp::params::enable_sys_desc_tx,
  $enable_port_desc_tx = $lldp::params::enable_port_desc_tx,
  $enable_mng_addr_tx  = $lldp::params::enable_mng_addr_tx,

) inherits lldp::params {

  validate_array($interface_names)
  validate_string($admin_status)
  validate_bool($enable_sys_name_tx)
  validate_bool($enable_sys_cap_tx)
  validate_bool($enable_sys_desc_tx)
  validate_bool($enable_port_desc_tx)
  validate_bool($enable_mng_addr_tx)

  config_lldp_mode { $interface_names:
    mode => $admin_mode,
  }
  set_sys_name_tlv { $interface_names:
    enabled => $enable_sys_name_tx,
  }
  set_port_desc_tlv { $interface_names:
    enabled => $enable_port_desc_tx,
  }
  set_sys_desc_tlv { $interface_names:
    enabled => $enable_sys_desc_tx,
  }
  set_sys_cap_tlv { $interface_names:
    enabled => $enable_sys_cap_tx,
  }

  if !$mng_addr_ipv4 or !$mng_addr_interface {
    warning("The lack of management IPv4 address or network card interface!")
  } else {
    config_mng_addr_ipv4 { $mng_addr_interface:
      ipv4 => $mng_addr_ipv4,
    }
  }

}
