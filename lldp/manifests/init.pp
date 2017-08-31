# === Class: lldp
#
# Setup lldpad service
#
# === Parameters
#
# [*package_ensure*]
#   (optional) The state of the package
#   Defaults to present
#
# [*enabled*]
#   (optional) The state of the service
#   Defaults to true
#
# [*manage_service*]
#   (optional) Whether to start/stop the service
#   Defaults to true
#

class lldp(

  $package_ensure = 'present',
  $enabled        = true,
  $manage_service = true,

) inherits lldp::params {

  validate_bool($enabled)
  validate_bool($manage_service)

  if $enabled {
    if $manage_service {
      $ensure = 'running'
    }
  } else {
    if $manage_service {
      $ensure = 'stopped'
    }
  }

#  package { 'libconfig':
#    ensure  => $package_ensure,
#    name    => 'libconfig',
#    tag     => 'libconfig-package',
#  } ->
  package { 'lldpad':
    ensure  => $package_ensure,
    name    => $::lldp::params::package_name,
    tag     => 'lldpad-package',
  } ->
  service { 'lldpad':
    ensure    => $ensure,
    name      => $::lldp::params::service_name,
    enable    => $enabled,
    hasstatus => true,
    tag       => 'lldpad-service',
  }
}
