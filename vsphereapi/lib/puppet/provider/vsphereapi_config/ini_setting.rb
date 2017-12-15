Puppet::Type.type(:vsphereapi_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:openstack_config).provider(:ini_setting)
) do

  def file_path
    '/etc/vsphere-api/vsphere_api.conf'
  end

end
