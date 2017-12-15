# == define: vsphereapi::backend::vcenter
#
# Configure the VMware vCenter authentication for vSphere Api Service.
#
# === Parameters
#
# [*host_ip*]
#   The IP address of the VMware vCenter server.
#
# [*host_username*]
#   The username for connection to VMware vCenter server.
#
# [*host_password*]
#   The password for connection to VMware vCenter server.
#
# [*insecure*]
#   (optional) Allow insecure conections.
#   If true, the vCenter server certificate is not verified. If
#   false, then the default CA truststore is used for verification. This
#   option is ignored if 'ca_file' is set.
#   Defaults to $::os_service_default
#
# [*ca_file*]
#   (optional) Specify a CA bundle file to use in verifying the vCenter server
#   certificate.
#   Defaults to $::os_service_default
#
# [*wsdl_location*]
#   (optional) VIM Service WSDL Location e.g
#   http://<server>/vimService.wsdl. Optional over-ride to
#   default location for bug work-arounds.
#   Defaults to $::os_service_default.
#
# [*compute_cluster_map*]
#   (optional) Provides the nova-compute node and the vCenter cluster mapping.
#   Defaults to '[<hostname1>:<cluster1>,<hostname2>:<cluster2>]'.
#
# [*extra_options*]
#   (optional) Hash of extra options to pass to the backend stanza
#   Defaults to: {}
#   Example :
#     { 'vcenter_backend/param1' => { 'value' => value1 } }
#

define vsphereapi::backend::vcenter (
  $extra_options = {},
  ) {

  $backend_name = $name
  if !$backend_name {
    fail('The backend_name parameter is required !')
  }

  $vc_dict = hiera($backend_name, {})
  $host_ip = $vc_dict['host_ip']
  $host_username        = $vc_dict['host_username']
  $host_password        = $vc_dict['host_password']
  $insecure             = $vc_dict['insecure']
  $ca_file              = $vc_dict['ca_file']
  $wsdl_location        = $vc_dict['wsdl_location']
  $compute_cluster_map  = $vc_dict['compute_cluster_map']

  vsphereapi_config {
    "${backend_name}/host_ip":                value => $host_ip;
    "${backend_name}/host_username":          value => $host_username;
    "${backend_name}/host_password":          value => $host_password, secret => true;
    "${backend_name}/insecure":               value => $insecure;
    "${backend_name}/ca_file":                value => $ca_file;
    "${backend_name}/wsdl_location":          value => $wsdl_location;
    "${backend_name}/compute_cluster_map":    value => $compute_cluster_map;
  }

  create_resources('vsphereapi_config', $extra_options)

}
