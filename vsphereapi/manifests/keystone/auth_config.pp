
class vsphereapi::keystone::auth_config (
  $password,
  $username                = 'vsphereapi',
  $auth_plugin             = 'password',
  $auth_url                = 'http://127.0.0.1:5000',
  $project_name            = 'services',
  $project_domain_name     = 'Default',
  $user_domain_name        = 'Default',
) {

  include vsphereapi::config

  vsphereapi_config {
    'keystone_authtoken/password':               value => $password, secret => true;
    'keystone_authtoken/username':               value => $username;
    'keystone_authtoken/auth_plugin':            value => $auth_plugin;
    'keystone_authtoken/auth_url':               value => $auth_url;
    'keystone_authtoken/project_name':           value => $project_name;
    'keystone_authtoken/project_domain_name':    value => $project_domain_name;
    'keystone_authtoken/user_domain_name':       value => $user_domain_name;
  }
}
