# == Class: vsphereapi::backends
#
# Class to set the vcenter_backends list
#
# === Parameters
#
# [*vcenter_backends*]
#   (Required) a list of ini sections to enable.
#   This should contain names used in ceph::backend::* resources.
#   Example: ['vcenter1', 'vcenter2', 'vcenter3']
#
# [*api_retry_count*]
#   (optional) The number of times we retry on failures,
#   e.g., socket error, etc.
#   Defaults to $::os_service_default.
#
# [*max_object_retrieval*]
#   (optional) The maximum number of ObjectContent data objects that should
#   be returned in a single result. A positive value will cause
#   the operation to suspend the retrieval when the count of
#   objects reaches the specified maximum. The server may still
#   limit the count to something less than the configured value.
#   Any remaining objects may be retrieved with additional requests.
#   Defaults to $::os_service_default
#
# [*task_poll_interval*]
#   (optional) The interval in seconds used for polling of remote tasks.
#   Defaults to 5.
#

# Author: Andrew Woodward <awoodward@mirantis.com>
class vsphereapi::backends (
  $vcenter_backends            = undef,
  $api_retry_count             = $::os_service_default,
  $max_object_retrieval        = $::os_service_default,
  $task_poll_interval          = 5,
) {

  if !$vcenter_backends {
    warning('The vcenter_backends parameter is undef')
    $vcenter_backends = []
  }

  if $task_poll_interval == 5 {
    warning('The OpenStack default value of task_poll_interval differs from the puppet module default of "5" and will be changed to the upstream OpenStack default in N-release.')
  }

  # Maybe this could be extented to dynamicly find the enabled names
  vsphereapi_config {
    'DEFAULT/vcenter_backends':       value => join($vcenter_backends, ',');
    "vmware/api_retry_count":         value => $api_retry_count;
    "vmware/max_object_retrieval":    value => $max_object_retrieval;
    "vmware/task_poll_interval":      value => $task_poll_interval;
  }
}
