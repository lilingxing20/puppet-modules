class vsphereapi (
  $ensure_package            = 'present',
  $enabled                   = true,
  $manage_service            = true,
  $bind_host                 = '0.0.0.0',
  $bind_port                 = '9886',
  $workers                   = 1,
  $verbose                   = true,
  $debug                     = false,
  $use_syslog                = false,
  $auth_strategy             = noauth,
) inherits vsphereapi::params {

  include vsphereapi::config

  package { 'vsphere-api':
    ensure => $ensure_package,
    name    => $::vsphereapi::params::package_name,
    tag    => ['openstack', 'vsphere-api-package'],
  }

  vsphereapi_config {
    'DEFAULT/api_workers':          value => $workers;
    'DEFAULT/use_syslog':           value => $use_syslog;
    'DEFAULT/verbose':              value => $verbose;
    'DEFAULT/debug':                value => $debug;
    'DEFAULT/bind_host':            value => $bind_host;
    'DEFAULT/bind_port':            value => $bind_port;
    'DEFAULT/auth_strategy':        value => $auth_strategy;
  }

  if $auth_strategy == 'keystone' {
    include vsphereapi::keystone::auth_config
  }

  if $manage_service {
    if $enabled {
      $ensure = 'running'
    } else {
      $ensure = 'stopped'
    }
  }

  service {'vsphere-api':
    ensure    => $ensure,
    name      => $::vsphereapi::params::service_name,
    enable    => $enabled,
    hasstatus => true,
    require   => Package['vsphere-api'],
    tag       => 'vsphere-api-service',
  }

  Package['vsphere-api'] -> Vsphereapi_config<||> ~> Service['vsphere-api'] 
}
