# Quickstart Guide

## Table of Contents

- [Overview of the Quickstart Guide](#overview-of-the-quickstart-guide)
- [Setting Up Your Front End](#setting-up-your-frontend)
- [Using SSH Keys](#using-ssh-keys)
- [Installing Your Development Appliance](#installing-your-development-appliance)
- [Installing Rocks Rolls](#installing-rocks-rolls)
- [Debugging your Roll Installations](#debugging-your-roll-installations)
- [Reinstalling Your Development Appliance](#reinstalling-your-development-appliance)

## Overview of the Quickstart Guide

What you will need:

- Frontend Machine
- One or more nodes
- Switch
- Internet Connection
- CD and/or DVD Media
- CD/DVD Burner
- Necessary cables for power and connection to Internet and Switch

In this documentation you will learn how to install the latest version of Rocks
while building your Front End and its nodes. While doing this you will create
the roll distribution for your nodes on your Front End. This process is briefly
shown in the below flow chart.

### Install your Front End

!["Front End and Compute Nodes"](images/FE_+_CN.png?raw=true "Front End and Compute Nodes")

### Replace a Compute Node with a Development Appliance

!["Using insert-ethers to replace a Compute Node with a Development Appliance"](images/FE_+_xCN.png?raw=true "Using insert-ethers to replace a ComputeNode with a Development Appliance")

```
insert-ethers --replace compute-0-0
```

!["Cluster with a Development Appliance"](images/FE_+_DA_+_CN.png?raw=true "Cluster with a Development Appliance")

### Install rolls on your cluster

!["Installing rolls process"](images/Installing_Rolls.png?raw=true "Installing rolls process")

### Replace your Development Appliance as a Compute Node

!["Using insert-ethers to replace a Development Appliance with a Compute Node"](images/FE_+_xDA_+_CN.png?raw=true "Using insert-ethers to replace a Development Appliance with a Compute Node")

```
insert-ethers --replace devel-server-0-0
```

!["Cluster with Compute Nodes"](images/FE_+_CN.png?raw=true "Cluster with Compute Nodes")

The official and much more lengthy version of the Rocks Installation process can
be found in the [Rocks User Guide][rug]

[rug]: http://central6.rocksclusters.org/roll-documentation/base/6.1/ "Rocks Users Guide"

Return to the [Table of Contents](#table-of-contents)

## Setting Up Your Frontend

In this section you will learn where to **download** the most up-to-date version
of Rocks and **install** it on your frontend.

### Downloading Rocks

The current and past releases of Rocks can be found on the [Rocks
Website](http://www.rocksclusters.org/)

Choose the version of Rocks to install.

!["Rocks Download Page"](images/1Download_Rocks_Cropped.png?raw=true "Rocks Download Page")

- Determine whether your CPU architecture is 32-bit or 64-bit. You can run
	the command ``lscpu`` and refer to the "CPU op-modes(s):" section.
- If your system does not support the 64-bit software then you will only be
	able to install rolls under "i386"
- Download the individual rolls you will need or simply download the **jumbo
	(DVD) ISO** which has been created to contain a few general rolls for
	your convenience. *(jumbo (DVD) ISO contains: Boot, Base, Area51, Condor,
	Ganglia, HPC, Java, Perl, Python, Bio, SGE, Web Server, KVM (on the
	x86_64 version), ZFS & OS Rolls)*
- Burn the ISO to a disc or any other bootable media.

It is recommended that you install at least the following rolls: *Boot, Base,
Area51, Ganglia, HPC, Java, Perl, Python, Bio, and SGE*

!["Roll Selection"](images/2Roll_Selection_Cropped.png?raw=true "Roll Selection")

### Installing Rocks

Be aware that when the Rocks Installation boots, if you do not press any button
the ``build`` command will automatically run without clarification of any of the
options (you will be able to fill the options in during the installation, but it
is easier to input them as options of ``build``).

Boot to the media and initiate the ``build`` while supplying appropriate IP/netmask/dns/gateway option...

```
   build IP=192.168.117.5 netmask=255.255.255.128 dns=198.202.75.26 gateway=192.168.117.1
```

*The above is an example of what you can input for the fields. If you are
unsure of what to input, then contact your network administrator. The IP
address is applied to the eth1 port*

Continue to follow the instructions presented to you as it asks for the name of
the machine and the password for the **root user**. Installation may take up to
**20 minutes**. Please note that if the system posts but does not boot after
installation, the node may be do to a hardware failure.

Return to the [Table of Contents](#table-of-contents)

## Using SSH Keys

SSH Keys allow an extra layer of security for your cluster and any other cluster
you access. It is good practice to use SSH Keys to prevent your data from being
accessed or corrupted by infiltrating users.

SSH is required to access the cluster as you cannot use Telnet or RSH and using 
SSH keys will make it easier to access the cluster.

### Setting Up SSH Keys

You can create your ssh keys using the following command on your local computer...

```
	ssh-keygen -t dsa
```

The following text should appear ``Enter file in which to save the key``. Be
sure to give the keys a name that will conflict with anyone else's ssh keys. 
Once you have entered in the name of your ssh keys it will ask for a
**passphrase** ``Enter passphrase (empty for no passphrase):``.

Create a **passphrase** to go with the ssh keys and be sure to remember it as it
will be the password asked from you when you ssh into the remote computers with
your ssh key.

This will create two files (a public key and a private key). The files created
will be located in the *~/.ssh* directory. Now you must copy the generated
keys onto the remote computer (typically your front end that you are accessing). The following example demonstrates that process using `scp`...

```
	scp ~/.ssh/<user>_dsa.pub root@frontend:.ssh/<user>_dsa.pub
```

Then ``ssh`` onto your front end and ``cd`` into the */.ssh* directory. Append
the key you copied to the *authorized_keys* file by running the following command...

```
	cat <user>_dsa.pub >> authorized_keys
```

Your ssh key is now on the remote compute. Keep in mind that when you ssh into
the computer now it will ask you for the **passphrase** you entered in earlier.

Return to the [Table of Contents](#table-of-contents)
 
## Installing Your Development Appliance

!["Cluster with a Development Appliance"](images/FE_+_DA_+_CN.png?raw=true "Cluster with a Development Appliance")

After connecting all the hardware up through a switch on their *eth0* ports to
connect all the nodes up to the front end, make sure that all the nodes are off.
 Keep in mind that *eth0* is usually used for local purposes such as this, while
*eth1* is used for connecting to the WLAN. Take note of the ``rocks help``
command for more information on rocks commands.

Now open up a terminal on your front end and execute the following command...

```
	insert-ethers
```

The screen below will then pop up on your terminal:

!["insert-ethers interface"](images/01_insert-ethers_devel-server.png?raw=true "insert-ethers interface")

Select to install a Development Appliance. Now turn on the desired node and
wait until it is detected. The boot screens were captured to be the following 
next few screens.

!["devel-server pxe boot"](images/02_devel-server_pxe_boot_01.png?raw=true "devel-server pxe boot")

!["devel-server pxe boot"](images/03_devel-server_pxe_boot_02.png?raw=true "devel-server pxe boot")

You may encounter disk failures when attempting to reinstall the node. You will 
see this screen if you are.

!["insert-ethers node discovered"](images/04_devel-server_disk_fail.png?raw=true "insert-ethers node discovered")

When the node is detected you will see the mac
address of the node in the *Inserted Appliances* window shown below.

!["insert-ethers node discovered"](images/05_insert-ethers_devel-server_discovered.png?raw=true "insert-ethers node discovered")

*The node you turned on will pop up with its mac address and host name*

In order to prevent risk of corrupted hardware, do **not** exit this terminal
until it is safe to do so (this is explained later in this tutorial). When a
node is installing you can check its progress by executing the following command...

```
	rocks console devel-server-0-0
```

If you have connected to your frontend from a machine with an X server you will
see the following window displayed...

!["rocks-console display"](images/5rocks-console_Cropped.png?raw=true "rocks-console display")

If you need to look up the **hostnames** of your nodes then use the following command...

```
	[root@frontend ~]$ rocks list host
	HOST               MEMBERSHIP   CPUS RACK RANK RUNACTION INSTALLACTION
	frontend:          Frontend     8    0    0    os        install
	devel-server-0-0:  Development  16   0    0    os        install
```
   *The hostnames are in the first column*

You will not be able to use the ``rocks console`` command once the installation
is done, but at that point you will be able to simply ``ssh`` into it. When an
asterisk character appears between all of the *()s* you may press the *f8* key
to quit the GUI without interrupting the installation.

!["Exit insert-ethers with <F8>"](images/07_insert-ethers_devel-server_kickstart_sent.png?raw=true "Exit insert-ethers with <F8>")

Once the installation of your node(s) is complete test if you can ``ping`` and
``ssh`` into all of your nodes as demonstrated in the following commands...

Ping 

```
	localhost:~ <user>$ ping frontend
	PING frontend.localdomain (192.168.117.10): 56 data bytes
	64 bytes from 192.168.117.10: icmp_seq=0 ttl=63 time=0.465 ms
	64 bytes from 192.168.117.10: icmp_seq=1 ttl=63 time=0.475 ms
	64 bytes from 192.168.117.10: icmp_seq=2 ttl=63 time=1.452 ms
	^C
	--- frontend.localdomain ping statistics ---
	3 packets transmitted, 3 packets received, 0.0% packet loss
	round-trip min/avg/max/stddev = 0.465/0.797/1.452/0.463 ms
```

SSH

```
	localhost:~ <user>$ ssh frontend
	Last login: Mon Sep 23 14:52:53 2013 from localhost.localdomain
	Rocks 6.1 (Emerald Boa)
	Profile built 00:06 05-Sep-2013

	Kickstarted 17:25 04-Sep-2013
	[root@frontend ~]# ssh devel-server-0-0
	Last login: Fri Sep 20 12:34:53 2013 from frontend.local
	Rocks 6.1 Development Server
	Rocks 6.1 (Emerald Boa)
	Profile built 16:48 16-Sep-2013

	Kickstarted 16:57 16-Sep-2013
	[root@devel-server-0-0 ~]#
```

Return to the [Table of Contents](#table-of-contents)

## Installing Rocks Rolls

Throughout this tutorial bear in mind that executing commands while logged in 
as the root user is potentially dangerous. Use caution and double-check commands 
before executing them. This is the primary reason for building rolls on a 
development appliance as it can help keep you from messing up your frontend.

In order to avoid unnecessary reinstallation of your frontend, please do all
``make`` commands for creating ISOs on the development appliance. This is to
prevent any errors that may occur when creating the rolls from affecting your
frontend. You may always reinstall your nodes if an error were to occur.


### How To Get The Triton Rolls

The Triton Rolls are currently located on the [Rocks Cluster Website](http://git.rocksclusters.org/cgi-bin/gitweb.cgi). A bash script has been supplied below in order for you to use git clone to 
acquire your own copy of a handful of these rolls...

[Triton Rolls Script](https://raw.github.com/sdsc/cluster-guide/master/scripts/triton_rolls_script.sh)

```
	#/bin/bash
	#This script will use git clone to copy over the triton repo from GitHub

	#run a 'for loop' to grab each file using 'git clone'
	for i in "beast" biotools "chemistry" cilk "cmake" cpmd "data-transfer" dataform "fftw" fsa "gamess" hadoop "intel" hdf "mpi" myri10Gbe "nagios" R "scar" scipy "triton-base" triton-config
	do
	   git clone "http://git.rocksclusters.org/git/triton/$i/.git" "/state/partition1/triton/$i"
	done
```

Create a directory on your Development Appliance to hold the Triton Rolls using `mkdir`, change to that directory using `cd` and create the above script using a text editor such as `emacs` or `vi`. Save the script as `triton_rolls_script.sh` then make it executable using `chmod` and run it on your development appliance as demonstrated below...

```
	[root@devel-server-0-0 ~]# mkdir -p /state/partition1/triton
	[root@devel-server-0-0 ~]# cd /state/partition1/triton
	[root@devel-server-0-0 triton]# vi triton_repo_script.sh
	[root@devel-server-0-0 triton]# chmod +x triton_rolls_script.sh
	[root@devel-server-0-0 triton]# ./triton_rolls_script.sh
	Cloning into '/state/partition1/triton/beast'...
	Cloning into '/state/partition1/triton/biotools'...
	Cloning into '/state/partition1/triton/chemistry'...
	Cloning into '/state/partition1/triton/cilk'...
	Cloning into '/state/partition1/triton/cmake'...
	Cloning into '/state/partition1/triton/cpmd'...
	Cloning into '/state/partition1/triton/data-transfer'...
	Cloning into '/state/partition1/triton/dataform'...
	Cloning into '/state/partition1/triton/fftw'...
	Cloning into '/state/partition1/triton/fsa'...
	Cloning into '/state/partition1/triton/gamess'...
	Cloning into '/state/partition1/triton/hadoop'...
	Cloning into '/state/partition1/triton/hdf'...
	Cloning into '/state/partition1/triton/intel'...
	Cloning into '/state/partition1/triton/mpi'...
	Cloning into '/state/partition1/triton/myri10Gbe'...
	Cloning into '/state/partition1/triton/nagios'...
	Cloning into '/state/partition1/triton/R'...
	Cloning into '/state/partition1/triton/scar'...
	Cloning into '/state/partition1/triton/scipy'...
	Cloning into '/state/partition1/triton/triton-base'...
	Cloning into '/state/partition1/triton/triton-config'...
	[root@devel-server-0-0 triton]#
```

These rolls are not *needed* on every cluster. They are provided as examples of different software tools built into manageable bundles. In subsequent sections of this document you will be lead through the process of building and installing one of the Triton rolls.

### Compiling the Intel Roll

Each Triton roll needs to be built in it's own directory. For our example of building the Intel Roll first you must ``cd`` into the directory of the roll...

```
	[root@devel-server-0-0 triton]# cd /state/partition1/triton/src/roll/intel
```

Once in the directory run the ``make`` command. It is recommended that you
create a log file to keep track of the installation records. This can be done
by using the following command...


```
	[root@devel-server-0-0 intel]# make default 2>&1 | tee log
```

This command will create a log file located in the roll's directory and will redirect both the standard output (stdout) and standard error (stderr) streams into it.

You can check the log file for errors using the following command...

```
	[root@devel-server-0-0 intel]# grep 'build err' log
```

If the ``make`` command created an ISO file successfully the end of the log file will contain messages similar to the following...

```
	[root@devel-server-0-0 intel]# tail log
			rocks create roll roll-intel.xml
	intel-roll-test-1-8: 084cc799446e22b2ee9a6ca293a22f44
	roll-intel-kickstart-6.1-8: 1a8988709a2c7d57b1a2fd904840bffa
	intel-modules-2013.1.117-8: 43729a84686a7283cdd8161d2b9d8da6
	intel-compilers-2013.1.117-8: e85a326e2c4e27e1079a80593d671e97
	Creating disk1 (528.92MB)...
	Building ISO image for disk1 ...
	Creating disk2 (474.44MB)...  This disk is optional (extra rpms)
	Building ISO image for disk2 ...
	
	[root@devel-server-0-0 intel]# ls *.iso
	intel-6.1-8.x86_64.disk1.iso  intel-6.1-8.x86_64.disk2.iso
```

You need to copy the *ISO* file(s) from the development appliance over to your
frontend to set up the distribution. To do this you need to return to the frontend and copy the rolls you just created on the development appliance to a directory of your choice. The following example demonstrates the steps required...

```
	[root@devel-server-0-0 intel]# exit
	logout
	Connection to devel-server-0-0 closed.
	[root@frontend ~]# mkdir -p ~/rolls_to_add
	[root@frontend ~]# scp "devel-server-0-0:/state/partition1/triton/intel/*.iso" ~/rolls_to_add/
	intel-6.1-8.x86_64.disk1.iso               100%  529MB  52.9MB/s   00:10
	intel-6.1-8.x86_64.disk2.iso               100%  475MB  47.5MB/s   00:10	
```

### Installing the Intel Roll

Change into the directory that you copied the ISO's to on your frontend and once
there execute the following commands...

```
	[root@frontend rolls_to_add]# rocks add roll intel-*.iso
	[root@frontend rolls_to_add]# rocks enable roll intel
```

You may check to see if your roll has been properly added and enabled by executing the following Rocks command...

```
	[root@frontend ~]# rocks list roll
	NAME                VERSION    ARCH   ENABLED
	ganglia:            6.1        x86_64 yes
	web-server:         6.1        x86_64 yes
	service-pack:       6.1        x86_64 yes
	CentOS:             6.3        x86_64 yes
	kernel:             6.1        x86_64 yes
	Updates-CentOS-6.3: 2012-11-26 x86_64 yes
	base:               6.1        x86_64 yes
	os:                 6.1        x86_64 yes
	hpc:                6.1        x86_64 yes
	intel:              6.1        x86_64 yes
	torque:             6.0.0      x86_64 yes
```

   *Look for the name of the roll in the first column*

In order to rebuild the Rocks distribution you must ``cd`` to the correct location on your frontend. Do that with the following command...

```
	[root@frontend ~]# cd /export/rocks/install
```

Once there you may rebuild the Rocks distribution by executing the following command...

```
	[root@frontend install]# rocks create distro
	Cleaning distribution
	Resolving versions (base files)
		including "kernel" (6.1,x86_64) roll...
		including "intel" (6.1,x86_64) roll...
		including "CentOS" (6.3,x86_64) roll...
		including "hpc" (6.1,x86_64) roll...
		including "torque" (6.0.0,x86_64) roll...
		including "service-pack" (6.1,x86_64) roll...
		including "web-server" (6.1,x86_64) roll...
		including "base" (6.1,x86_64) roll...
		including "ganglia" (6.1,x86_64) roll...
		including "os" (6.1,x86_64) roll...
		including "Updates-CentOS-6.3" (2012-11-26,x86_64) roll...
	Including critical RPMS
	Resolving versions (RPMs)
		including "kernel" (6.1,x86_64) roll...
		including "intel" (6.1,x86_64) roll...
		including "CentOS" (6.3,x86_64) roll...
		including "hpc" (6.1,x86_64) roll...
		including "torque" (6.0.0,x86_64) roll...
		including "service-pack" (6.1,x86_64) roll...
		including "web-server" (6.1,x86_64) roll...
		including "base" (6.1,x86_64) roll...
		including "ganglia" (6.1,x86_64) roll...
		including "os" (6.1,x86_64) roll...
		including "Updates-CentOS-6.3" (2012-11-26,x86_64) roll...
	Resolving versions (SRPMs)
		including "kernel" (6.1,x86_64) roll...
		including "intel" (6.1,x86_64) roll...
		including "CentOS" (6.3,x86_64) roll...
		including "hpc" (6.1,x86_64) roll...
		including "torque" (6.0.0,x86_64) roll...
		including "service-pack" (6.1,x86_64) roll...
		including "web-server" (6.1,x86_64) roll...
		including "base" (6.1,x86_64) roll...
		including "ganglia" (6.1,x86_64) roll...
		including "os" (6.1,x86_64) roll...
		including "Updates-CentOS-6.3" (2012-11-26,x86_64) roll...
	Creating files (symbolic links - fast)
	Applying stage2.img
	Applying updates.img
	Installing XML Kickstart profiles
		installing "condor" profiles...
		installing "ganglia" profiles...
		installing "service-pack" profiles...
		installing "web-server" profiles...
		installing "base" profiles...
		installing "intel" profiles...
		installing "hpc" profiles...
		installing "torque" profiles...
		installing "kernel" profiles...
		installing "os" profiles...
		installing "site" profiles...
		 Calling Yum genpkgmetadata.py
	Creating repository

	iso-8859-1 encoding on Ville Skytt� <ville.skytta@iki.fi> - 2.8.2-2

		 Rebuilding Product Image including md5 sums
		 Creating Directory Listing
	
```

Repeat these steps for each roll that needs to be installed. When you run into
an error building an ISO on the development appliance it may be due to missing
dependencies. If this is the case you must reinstall the development appliance
by following the method described in [Reinstalling Your Development
Appliance](#reinstalling-your-development-appliance) before attempting to build the roll that had the dependency.

<!--
	This is an interesting problem and should be expanded upon. Simply
	reinstalling the node will not necessarily resolve a dependency issue as
	the missing dependency may not be built. Perhaps we need to be careful to
	document any dependencies that exist in the Triton rolls. The rolls we
	release 'should' not be inter-dependent.
-->	


Return to the [Table of Contents](#table-of-contents)

## Debugging your Roll Installations

There are a few ways that you can test whether or not a roll has been
successfully installed on a cluster. These debugging methods are discussed in
detail on the Rocks Clusters documentation site listed below.

[Rocks Cluster Debugging](http://www.rocksclusters.org/roll-documentation/developers-guide/5.4.3/testing-post.html)

Below are a few debugging tests that you may also use.

### The XML File Test

The roll should now be added. One way to see that the rolls are working is to
run the following command...

```
	rocks list host xml compute-0-1 >& ~/xml_files/intel.xml
```

   *This will create an xml file that you can search for errors*

If the output does not contain errors then the roll should have installed
correctly. Run a ``grep`` command to search for errors...

```
	grep 'err' ~/xml_files/intel.xml
```

If you do not grep any errors then this test has passed.

### The Perl Script Test

A Perl script may be installed with each of the roll installations after running 
``rocks run roll <rollname> | bash`` on the front end after rebuilding the 
distro to test whether or not the roll has been properly installed. First you 
must change directory into the directory that the scripts are installed into...

```
	cd /root/rolltests/
```

Once you are in this directory you should be able to use an ``ls`` command to
check which of the rolls you installed have perl scripts. To run a Perl scripts
simply put in the following command...

```
	./intel.t
```

Assuming a license is installed for the Intel compilers in the appropriate
location, this script should create an output similar to the following...

Intel compilers and license installed correctly...

```
[root@frontend ~]# ./rolltests/intel.t
ok 1 - intel compilers installed
ok 2 - intel C compiler works
ok 3 - compiled C program runs
ok 4 - compile C program correct output
ok 5 - intel FORTRAN compiler works
ok 6 - compiled FORTRAN program runs
ok 7 - compile FORTRAN program correct output
ok 8 - man works for intel
ok 9 - intel module installed
ok 10 - intel version module installed
ok 11 - intel version module link created
1..11
```

From these outputs you should be able to find out whether or not your rolls have
been installed correctly.

Return to the [Table of Contents](#table-of-contents)

## Reinstalling Your Development Appliance

You may wish to reinstall your Development Appliance as a Compute Node. In
order to do so you must first remove it as an installed appliance on your Front
End.

First set the boot action to install on the Front End running the following Rocks command...

```
	rocks set host boot devel-server-0-0 action=install
```

``ssh`` into the appliance you are reinstalling and change its BIOS settings to
ensure it is configured to PXE boot and reboot the node...

```
	ssh devel-server-0-0
	ipmitool chassis bootdev pxe options=persistent
	shutdown
```

*Your nodes may be required to be reinstalled so that the installed rolls on the
frontend are installed on your nodes clearing up any dependency issues. If you
are reinstalling your Development Appliance for this reason then perform a
``reboot`` instead of a ``shutdown``*

``ipmitool`` is being used to changed the settings of your node to conduct a pxe
boot. This needs to be changed using ipmitool because it is a setting outside of
your UNIX installation.

Return to your Front End and remove the host so that it will reinstall upon boot...

```
	rocks remove host devel-server-0-0
```

Finally you may reinstall the node and your remaining nodes as compute nodes
using the *insert ethers* method described in [Installing Your Development
Appliance](#installing-your-development-appliance).

Return to the [Table of Contents](#table-of-contents)