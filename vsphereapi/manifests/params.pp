# == Class: vsphereapi::params
#
# These parameters need to be accessed from several locations and
# should be considered to be constant
class vsphereapi::params {

  case $::osfamily {
    'RedHat': {
      # package names
      $package_name = 'vsphere-api'
      # service names
      $service_name = 'vsphere-api'
      # redhat specific config defaults
      $lock_path    = '/var/lib/vsphere-api/tmp'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}

