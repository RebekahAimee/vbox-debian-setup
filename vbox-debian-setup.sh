#!/bin/bash

# A script for installing guest additions and important packages on Debian VMs.
# Must be run as root.

echo "This script requires that you insert the Virtualbox Guest Additions CD"
echo "before continuing. If you have not inserted the CD, press ^C."

# need dkms to install external kernel modules
apt-get install dkms

# next we run a script on the CD; first we need to know where the CD is
echo "Please enter the directory where the Guest Additions CD is mounted."
echo "If you don't enter anything here, the script assumes /media/cdrom"
echo -n ">> "
read mount_location

# if nothing entered, this sets the default /media/cdrom
if ($mountlocation = "")
    set mount_location = "/media/cdrom"
fi

# appends script name
set mount_location = mount_location + "/VBoxLinuxAdditions.run"

#runs script
sh $mount_location

# updates package list, upgrades anything that needs it, installs make and gcc
apt-get update
apt-get upgrade
apt-get install make gcc

# Next we need the exact version of the kernel. We're looking for something
# with the syntax #.#.#-[stuff], so we'll use sed to figure out where it is.
# Theoretically, according to the man page, uname -a (the command we'll use to
# get the version number) always lists the version fourth. However, my test
# system lists it third, so basing the command off of whitespace placement
# would be a brittle hack. Don't try it!

# first let's get the raw input
uname_raw = $(uname -a)

#now use sed to pick out something that looks like the kernel version
kernel_version = $(sed '/



