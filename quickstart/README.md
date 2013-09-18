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

In this documentation you will learn how to install the latest version of Rocks
while building your Front End and its nodes..  While doing this you will create
the roll distrobution for your nodes on your Front End.  This process is briefly
shown in the below flow chart.

Install your Front End

!["Front End and Compute Nodes"](images/FE_+_CN.png?raw=true "Front End and Compute Nodes")

Replace a Compute Node with a Development Appliance

!["Using insert-ethers to replace a Compute Node with a Development Appliance"](images/new_images/FE_+_xCN.png?raw=true "Using insert-ethers to replace a ComputeNode with a Development Appliance")

```
insert-ethers --replace compute-0-0
```

!["Cluster with a Development Appliance"](images/FE_+_DA_+_CN.png?raw=true "Cluster with a Development Appliance")

Install rolls on your cluster

!["Installing rolls process"](images/Installing_Rolls.png?raw=true "Installing rolls process")

Replace your Development Appliance as a Compute Node

!["Using insert-ethers to replace a Development Appliance with a Compute Node"](images/new_images/FE_+_xDA_+_CN.png?raw=true "Using insert-ethers to replace a Development Appliance with a Compute Node")

```
insert-ethers --replace devel-0-0
```

!["Cluster with Compute Nodes"](images/FE_+_CN.png?raw=true "Cluster with Compute Nodes")

The official and much more lengthy version of the Rocks Installation process can
be found in the [Rocks User Guid][rug]

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

- Download the individual rolls you will need or simply download the **jumbo
roll** which has been created to contain a few general rolls for your
convenience.  *(jumbo roll contains: Boot, Base, Area51, Condor, Ganglia, HPC,
Java, Perl, Python, Bio, SGE, Web Server, KVM (on the x86_64 version), ZFS & OS
Rolls)*
- Burn the ISO to a disc or any other bootable media.

It is recommended that you install at least the following rolls: *Boot, Base,
Area51, Ganglia, HPC, Java, Perl, Python, Bio, and SGE*

!["Roll Selection"](images/2Roll_Selection_Cropped.png?raw=true "Roll Selection")

### Installing Rocks

Be aware that when the Rocks Installation boots, if you do not press any button
the ``build`` command will automatically run without clarification of any of the
options (you will be able to fill the options in during the installtion, but it
is easier to input them as options of ``build``).  Boot to the media and do the
``build`` command

```
   build IP=192.168.117.5 netmask=255.255.255.128 dns=198.202.75.26 gateway=192.168.117.1
```

   *The IP address is applied to the eth1 port*

Continue to follow the instructions presented to you as it asks for the name of
the machine and the password for the **root user**.  Installation may take up to
**20 minutes**.  Please note that if the system posts but does not boot after
installation, the node may be do to a hardware failure.

Return to the [Table of Contents](#table-of-contents)

## Using SSH Keys

SSH Keys allow an extra layer of security for your cluster and any other cluster
you access.  It is good practice to use SSH Keys to prevent your data from being
accessed or corrupted by infiltrating users.

### Setting Up SSH Keys

You can create your ssh keys using the following command on your local computer

```
	ssh-keygen -t dsa
```

The following text should appear ``Enter file in which to save the key``.  Be
sure to give the keys a name that will conflict with anyone else's ssh keys. 
Once you have entered in the name of your ssh keys it will ask for a
**passphrase** ``Enter passphrase (empty for no passphrase):``.

Create a **passphrase** to go with the ssh keys and be sure to remember it as it
will be the password asked from you when you ssh into the remote computers with
your ssh key.

This will create two files (a public key and a private key).  The files created
will be located in the *~/.ssh* directory.  Now you must ``scp`` the generated
keys onto the remote computer (typically your front end that you are accessing)

```
	scp ~/.ssh/gsiman_dsa.pub root@hpcdev-006:.ssh/gsiman_dsa.pub
```

Then ``ssh`` onto your front end and ``cd`` into the */.ssh* directory.  Append
the key you copied in to the *authorized_keys* file by doing

```
	cat gsiman_dsa.pub >> authorized_keys
```

Your ssh key is now on the remote compute.  Keep in mind that when you ssh into
the computer now it will ask you for the **passphrase** you entered in earlier.

Return to the [Table of Contents](#table-of-contents)
 
## Installing Your Development Appliance

After connecting all the hardware up through a switch on their *eth0* ports to
connect all the nodes up to the front end, make sure that all the nodes are off.
 Keep in mind that *eth0* is usually used for local purposes such as this, while
*eth1* is used for connecting to the WLAN.  Take note of the ``rocks help``
command for more information on rocks commands.

Now open up a terminal on your front end and do the following command

```
	insert-ethers --basename devel
```

The screen below will then pop up on your terminal:

!["insert-ethers interface"](images/01_insert-ethers_devel-server.png?raw=true "insert-ethers interface")

Select to install a Development Applaince.  Now turn on the desired node and
wait until it is detected.  If you are using a KVM connection to see the boot
of the node you should see the following next few screens.

!["devel-server pxe boot"](images/02_devel-server_pxe_boot_01.png?raw=true "devel-server pxe boot")

!["devel-server pxe boot"](images/03_devel-server_pxe_boot_02.png?raw=true "devel-server pxe boot")

You may encounter disk failures when attempting to reinstall the node.  You will see this screen if you are.

!["insert-ethers node discovered"](images/new_images/04_devel-server_disk_fail.png?raw=true "insert-ethers node discovered")

When the node is detected you will see the mac
address of the node in the *Inserted Appliances* window shown below.

!["insert-ethers node discovered"](images/05_insert-ethers_devel-server_discovered.png?raw=true "insert-ethers node discovered")

   *The node you turned on  will pop up with its mac address and host name*

In order to prevent risk of corrupted hardware, do **not** exit this terminal
until it is safe to do so (this is explained later in this tutorial).  When a
node is installing you can check its progress by using the command

```
	rocks console devel-0-0
```

If you have connected to your frontend from a machine with an X server you will
see the following window displayed...

!["rocks-console display"](images/5rocks-console_Cropped.png?raw=true "rocks-console display")

If you need to look up the **hostnames** of your nodes then use the command

```
	[gsiman@hpcdev-006 ~]$ rocks list host
	HOST              MEMBERSHIP   CPUS RACK RANK RUNACTION INSTALLACTION
	hpcdev-006:       Frontend     8    0    0    os        install
	devel-0-0:        Development  16   0    0    os        install
```
   *The hostnames are in the first column*

You will not be able to use the ``rocks console`` command once the installation
is done, but at that point you will be able to simply ``ssh`` into it.  When *s
appear between all of the *()s* you may press the *f8* key to quit the GUI
without interupting the installation.

!["Exit insert-ethers with <F8>"](images/07_insert-ethers_devel-server_kickstart_sent.png?raw=true "Exit insert-ethers with <F8>")

Once the installation of your node(s) is complete test if you can ``ping`` and
``ssh`` into all of your nodes

```
	ping devel-0-0
	ssh devel-0-0
```

Return to the [Table of Contents](#table-of-contents)
..	The content in this file/document is the primary content of the
	tutorial. Consider making *this* document the actual tutorial and
	pointing the README.rst file to it. Possibly it should go at/near the
	'top' of the Triton roll repository root.

## Installing Rocks Rolls

Throughout this tutorial bear in mind that being in **root** is potentially
dangerous to your system

In order to avoid unnecessary reinstallations of your frontend, please do all
``make`` commands for creating ISOs on the development appliance.  This is to
prevent any errors that may occur when creating the rolls from affecting your
frontend.  You may always reinstall your nodes if an error were to occur.

<!--
..	Rocks convention is to call the primary host the frontend not *front end*
-->

### How To Get The Triton Repo

The Triton Repo is located in GitHub.  A bash script has been supplied below in
order for you to use git clone to acquire your own copy:

https://raw.github.com/sdsc/cluster-guide/master/triton_repo_script.sh

```
	#/bin/bash
	#This script will use git clone to copy over the triton repo from GitHub

	#run a 'for loop' to grab each file using 'git clone'
	for i in R "amber" beast "biotools" chemistry "cilk" cmake "cp2k" cpmd "data-transfer" dataform "db2" ddt "envmodules" fftw "flexlm" fpmpi "fsa" gamess "hadoop" hdf "ib" idl "intel" lustre-client "moab" mpi "myri10Gbe" myrinet_mx "nagios" nwchem "ofed" pgi "scar" scipy "tau" thresher-config "triton-base" triton-config "valgrind"
	do
	   git clone "http://git.rocksclusters.org/git/triton/$i/.git" "/state/partition1/triton/$i"
	done
```

Use a text editor such as `emacs` to create a `.sh` file for the bash script. 
After you have made the file run is by doing

```
	sh triton_repo_script.sh
```

Keep in mind that the second part of the ``git clone`` command in the for loop
is the location which you are cloning the repo to.

<!-- 
..	The contents of the Triton repository will change when the repository
	is moved to GitHub. Best NOT to publish a script with repo names.
	Alternately, pull a list of repos belonging to the SDSC GitHub account
	and pattern match them. This needs a bit of thought and will be impacted
	by the specific implementation of the Triton rolls sources on GitHub once
	the cvs2git migration is complete.
-->

### Compiling the Roll

Typically the rolls that need to be installed manually are:

*scar* *cmake* *mpi* *R* *fftw* *hdf* *math* *dataform*

<!--
..	See previous comment about naming specific Triton repos.
-->

For more information read **triton/src/roll/bootstrap.sh**, which is located in
the code drop from the Triton Repository. ``scp`` the files onto your
*devel-server-0-0* into a place with enough space such as */state/partition1/*
and ``ssh`` onto your development server:

<!--
..	The mentioned bootstrap.sh script is NOT pulled from the Triton Repository.
-->

```
	scp $TRITONREPO root@devel-server-0-0:/state/partition1/
	ssh root@devel-server-0-0
```

First you must ``cd`` into the directory of the roll

```
	cd /state/partition1/triton/src/roll/intel
```

<!--
..	Mentioned before that specific rolls should not be mentioned. In
	particular, the intel roll is very specific to SDSC and should probably
	not be used as an example here. A more 'generic' roll might be a better
	choice (ie. intel).
-->

Once in the directory run the ``make`` command.  It is recommended that you
create a log file to keep track of the installation records.  This can be done
by using the following command

```
	make default 2>&1 | tee log
```

*This pipe will create a log file located in the roll's directory*

In the log files you may use this command to check for errors

```
	grep 'build err' log
```

If the ``make`` command created an ISO file successfully it should end off by
saying...

```
	Creating disk1 (x.xxMB)...
	Building ISO image for disk1...
```

You need to copy the *ISO* file from the development appliance over to your
frontend to set up the distribution.  Copy the ISOs to a direcory in your home
directory

```
	scp intel-6.1-0.x86_64.disk1.iso root@hpcdev-006:~/rolls_to_add/
```

<!--
..	Aside for the use of intel as an example roll this sequence is
	essentially fine.
-->

### Installing the Roll

Go back to your frontend and ``cd`` into the directory that you copied the ISO
over to.  Once there use the following commands

```
	rocks add roll intel-6.1-0.x86_64.disk1.iso
	rocks enable roll intel
```

In order to set up the distro you must ``cd`` over to the right directory

```
	cd /export/rocks/install
```

Once there you may create the distro by running

```
	rocks create distro
```

You may check to see if your roll has been properly added and enabled by using

```
	rocks list roll
```

The output for this command will be

```
	NAME          VERSION    ARCH   ENABLED
	ganglia:      6.1        x86_64 yes    
	os:           6.1        x86_64 yes    
	kvm:          6.1        x86_64 yes    
	web-server:   6.1        x86_64 yes    
	bio:          6.1        x86_64 yes 
```

   *Look for the name of the roll in the first column*

<!--
..	All essentially fine.
-->

Repeat these steps for each roll that needs to be installed.  When you run into
an error building an ISO on the development appliance it may be due to the
dependencies.  If this is the case you must reinstall the node by doing the
method described in `Reinstalling Your Development Appliance`_.

<!--
..	This is an interesting problem and should be expanded upon. Simply
	reinstalling the node will not necessarily resolve a dependency issue as
	the missing dependency may not be built. Perhaps we need to be careful to
	document any dependencies that exist in the Triton rolls. The rolls we
	release 'should' not be inter-dependent.
-->	


Return to the [Table of Contents](#table-of-contents)

<!--
..	Roll testing should be included as a primary step in the roll
	installation sequence. These are good tests and can be complimented by
	others. Roll tests with errors, if documented, should include explanation
	and/or solutions.
-->

## Debugging your Roll Installations

There are a few ways that you can test whether or not a roll has been
successfully installed on a cluster.  These debugging methods are discussed in
detail on the Rocks Clusters documentation site listed below.

`Rocks Cluster Debugging <http://www.rocksclusters.org/roll-documentation/developers-guide/5.4.3/testing-post.html>`_

Below are a few debugging tests that you may also use.

### The XML File Test

The roll should now be added.  One way to see that the rolls are working is to
run the following command::

```
	rocks list host xml compute-0-1 >& ~/xml_files/intel.xml
```

   *This will create an xml file that you can search for errors*

If the output does not contain errors than it should run fine.  Run a ``grep``
command to search for errors::

```
	grep 'err' ~/xml_files/intel.xml
```

If you do not grep any errors then this test has passed.

### The Perl Script Test

A Perl script is installed with each of the roll installations to test whether
or not the roll has been properly installed.  First you must change directory
into the directory that the scripts are installed into::

```
	cd /root/rolltests/
```

Once you are in this directory you should be able to use an ``ls`` command to
check which of the rolls you installed have perl scripts.  To run a Perl scripts
simply put in the following command::

```
	perl scar.t
```

This will automatically run a script which should create an output similar to
the following::

```
	[root@hpcdev-01 rolltests]# perl scar.t
	ok 1 - gfortran installed
	ok 2 - g++ installed
	ok 3 - ipmi installed
	ok 4 - gdb installed
	ok 5 - sysstat installed
	ok 6 - xterm installed
	ok 7 - php installed
	ok 8 - emacs installed
	ok 9 - gnu module installed
	ok 10 - gnu version module installed
	ok 11 - gnu version module link created
	ok 12 - module search path set up
	ok 13 - audit service created
	ok 14 - audit config created
	ok 15 - audit rules added
	/etc/init.d/audit: line 37: auditctl: command not found
	not ok 16 - audit running
	#   Failed test 'audit running'
	#   at scar.t line 38.
	#                   ''
	#     doesn't match '(?-xism:LIST_RULES)'
	ok 17 # skip not compute node
	ok 18 # skip not compute node
	ok 19 # skip not compute node
	ok 20 # skip not compute node
	ok 21 # skip not compute node
	ok 22 # skip not compute node
	ok 23 # skip not compute node
	ok 24 # skip not compute node
	ok 25 # skip not compute node
	ok 26 # skip not compute node
	ok 27 # skip not login node
	ok 28 # skip not login node
	ok 29 # skip not login node
	ok 30 # skip not login node
	ok 31 # skip not login node
	ok 32 # skip not login node
	ok 33 # skip not login node
	ok 34 # skip not login node
	ok 35 # skip not login node
	ok 36 # skip not login node
	ok 37 # skip not login node
	ok 38 # skip not login node
	ok 39 # skip not login node
	ok 40 # skip not login node
	ok 41 # skip not login node
	ok 42 # skip not login node
	ok 43 - scar library installed
	ok 44 - sphinx installed
	ok 45 - scar scripts installed
	ok 46 - sphinx installed
	ok 47 - gmond config modified
	ok 48 - login appliance defined
	ok 49 - PYTHONPATH modified
	ok 50 - install x11 on compute nodes
	1..50
	# Looks like you failed 1 test of 50.
```

From these outputs you should be able to find out whether or not your rolls have
been installed correctly.

Return to the [Table of Contents](#table-of-contents)

## Reinstalling Your Development Appliance

You will need to reinstall your Development Appliance as a Compute Node.  In
order to do so you must first remove it as an installed appliance on your Front
End.

First set the boot action to install on the Front End by inputing::

```
	rocks set host boot devel-0-0 action=install
```

``ssh`` into the appliance you are reinstalling and change its settings to
ensure its boot settings are set to pxe and reboot the node::

```
	ssh devel-0-0
	ipmitool chassis bootdev pxe options=persistent
	shutdown
```

*If you are reinstalling your Development Appliance due to dependencies then
perform a ``reboot`` instead of a ``shutdown``*

Return to your Front End and remove the host so that it will reinstall upon boot::

```
	rocks remove host devel-0-0
```

Finally you may reinstall the node and your remaining nodes as compute nodes
using the *insert ethers* method described in [Installing Your Development
Appliance](#installing-your-development-appliance).

Return to the [Table of Contents](#table-of-contents)