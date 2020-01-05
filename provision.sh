#!/bin/bash

# This shell provisioner completes the set up process for seeding the
# cloud-init meta-data and user-data files for Ubuntu servers.

# First, we need to ensure that the vendor-provided ISO disc that has
# its own cloud-init user-data is removed, so we blow away the
# contents of that disk (`/dev/sdb` on Ubuntu's cloud images). This is
# important because the cloud-init NoCloud datasource will use seed data
# on an external drive over seed data on the same ("internal") filesystem.
# See:
# https://github.com/canonical/cloud-init/blob/master/cloudinit/sources/DataSourceNoCloud.py#L120-L144
dd if=/dev/zero of=/dev/sdb bs=4096k

# Remove prior cloud-init information. This removes information about
# prior runs of cloud-init. Use `cloud-init clean -l` to remove logs.
# See https://cloudinit.readthedocs.io/en/latest/topics/cli.html
cloud-init clean

# Put our own cloud-init seed files into place.
# See https://cloudinit.readthedocs.io/en/latest/topics/dir_layout.html
mv /tmp/cloud-init/* /var/lib/cloud/seed/

# Force cloud-init to run (again).
# See https://cloudinit.readthedocs.io/en/latest/topics/boot.html
cloud-init init                 # Run the init stage.
cloud-init modules              # Run the config stage.
cloud-init modules --mode=final # Run the final stage.
