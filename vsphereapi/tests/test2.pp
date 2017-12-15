
include ::vsphereapi
include ::vsphereapi::backends

define test_func1(
) {
  $vc_dict = hiera($name, {})
  notify{$name:}
  notify{$vc_dict:}
  ::vsphereapi::backend::vcenter_v1 {$name:
    host_ip       => $vc_dict['host_ip'],
    host_username => $vc_dict['host_username'],
    host_password => $vc_dict['host_password'],
    insecure      => $vc_dict['insecur'],
  }
}

test_func1{$::vsphereapi::backends::vcenter_backends:
}

