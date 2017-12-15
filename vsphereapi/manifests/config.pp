class vsphereapi::config (
  $vsphereapi_config        = {},
) {

  include ::vsphereapi::params

  validate_hash($vsphereapi_config)

  create_resources('vsphereapi_config', $vsphereapi_config)
}
