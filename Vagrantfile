# -*- mode: ruby -*-
# vi: set ft=ruby :

UBUNTU = "bento/ubuntu-16.04"

Vagrant.configure(2) do |config|
	# Build the dev environment in the vm
	config.vm.define "linux", autostart: true, primary: true do |vmconfig|
		vmconfig.vm.box = UBUNTU
		vmconfig.vm.hostname = "VAGRANT-DEV-BOX"
		vmconfig.vm.network "forwarded_port", guest: 5901, host: 5901
		vmconfig = configureProviders vmconfig,
			cpus: suggestedCPUCores()

		vmconfig.vm.synced_folder ".", "/vagrant", disabled: true
		vmconfig.vm.synced_folder '.', '/share'

		#vmconfig.vm.provision "shell",
		#	privileged: true,
		#	inline: 'rm -f /home/vagrant/linux.iso'

		#vmconfig.vm.provision "shell",
		#	privileged: true,
		#	path: './scripts/vagrant-linux-priv-go.sh'

		#vmconfig.vm.provision "shell",
		#	privileged: true,
		#	path: './scripts/vagrant-linux-priv-config.sh'

		#vmconfig.vm.provision "shell",
		#	privileged: false,
		#	path: './scripts/vagrant-linux-unpriv-bootstrap.sh'

		vmconfig.vm.provision "shell",
			privileged: true,
			inline: 'sudo timedatectl set-timezone America/Los_Angeles'

		vmconfig.vm.provision "shell",
			privileged: true,
			path: './scripts/install_chef.sh'

		vmconfig.vm.provision "shell",
			privileged: true,
			path: './scripts/install_docker_kitchen.sh'

    #comment these lines if you don't want VNC Server
		vmconfig.vm.provision "shell",
			privileged: true,
			path: './scripts/install_vnc.sh'

	end

end

def configureProviders(vmconfig, cpus: "2", memory: "4096")
	vmconfig.vm.provider "virtualbox" do |v|
		v.memory = memory
		v.cpus = cpus
	end

	["vmware_fusion", "vmware_workstation"].each do |p|
		vmconfig.vm.provider p do |v|
			v.enable_vmrun_ip_lookup = false
			v.vmx["memsize"] = memory
			v.vmx["numvcpus"] = cpus
		end
	end

	return vmconfig
end

def suggestedCPUCores()
	case RbConfig::CONFIG['host_os']
	when /darwin/
		Integer(`sysctl -n hw.ncpu`) / 2
	when /linux/
		Integer(`cat /proc/cpuinfo | grep processor | wc -l`) / 2
	else
		2
	end
end
