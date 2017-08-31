Facter.add("physical_interfaces") do
  setcode do
    Facter::Util::Resolution.exec('ls /sys/class/net/ | grep "^eth\|ens\|eno\|enp" | paste -s -d ","')
  end
end
