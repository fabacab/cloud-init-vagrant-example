# Vagrant project configuration.
# See https://www.vagrantup.com/docs/vagrantfile/
Vagrant.configure("2") do |config|

  # Ubuntu's Vagrant base boxes are provided by the company's cloud
  # images service, which offers Ubuntu Server images that already
  # have cloud-init included in the Operating System image.
  #
  # See https://www.vagrantup.com/docs/boxes.html
  config.vm.box = "ubuntu/bionic64"

  # When enabled, the cloud-init program attempts to retrieve data
  # about the machine on which it was launched from a number of
  # different sources. This can include an IaaS metadata service,
  # an attached ISO-9660 filesystem, or data on the local filesystem,
  # in a seed directory.
  #
  # The simplest possible situation is to upload seed data to the
  # local system, as done here.
  config.vm.provision "file", source: "cloud-init", destination: "/tmp/cloud-init"

  # Since Vagrant's file provisioner (above) cannot write to filesystem
  # paths owned by the guest's `root` Operating System user, we wrote
  # the cloud-init seed data to the `/tmp/cloud-init` directory. Then
  # we use a simple shell script to complete the setup.
  config.vm.provision "shell", path: "provision.sh"

end
