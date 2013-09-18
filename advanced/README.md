# Welcome to the Advanced Cluster Guide!

<!--
.. Insert 'brief' description of this document.
-->

This guide will teach you how to safely build and deploy software on your
Rocks(r) Cluster using Triton Rolls. The techniques described can be used once
during initial installation but we recommend their use during the entire life of
your Rocks cluster.


## Table of Contents

<!--
.. This is a manual TOC since I don't want the embedded title and I want to link   
   back to the TOC after each section.
-->

- [Overview](#overview)
- [Installing Your Rocks Development Appliance](#installing-your-rocks-development-appliance)
- [Installing Triton Rolls](#installing-triton-rolls)
	- [Download Triton Rolls to Development Server](#download-triton-rolls-to-development-server)
	- [Build Triton Rolls on Development Server](#build-triton-rolls-on-development-server)
	- [Copy Triton Rolls to Frontend](#copy-triton-rolls-to-frontend)
	- [Install Triton Rolls on Frontend](#install-triton-rolls-on-frontend)
	- [Test Triton Rolls Installation on Frontend](#test-triton-rolls-installation-on-frontend)
	- [Install or Reinstall Nodes](#install-or-reinstall-nodes)


## Overview

<!--
.. This guide 'should' be a guide to get/build/use SDSC Triton software rolls   
   to customize an already installed cluster. It is NOT a basic cluster 
   installation guide.
   That topic is covered completely in the standard Rocks documentation and 
   those steps should only be referenced in this guide.
-->

In this guide you will learn how to download, build and deploy software to your
running Rocks cluster using a Rocks Development Appliance. Ideally, you will
begin using this guide during your initial cluster install, however it is
possible to use this guide after you have begun using your cluster as long as
you can meet a few basic requirements.

This guide describes the use of publicly available rolls developed for the UC
San Diego Triton cluster. The Triton cluster was in production at UC San Diego
from October, 2009 through June 2013 and ran Rocks 5.4. As a result, the rolls
we will be building are named 'Triton Rolls'.

Recently, the Triton cluster was decommissioned and replaced by the UC San Diego
Triton Shared Compute Cluster (TSCC) which went into production in May, 2013.
The UC San Diego TSCC cluster is currently running Rocks 6.1 and has many of the
Triton rolls built and installed using the steps described in this guide. 

This guide assumes the following...

- Rocks 6.1 (or later) is installed on your cluster frontend 
- You are able to login to your cluster frontend as root 
- The cluster private network is correctly cabled and configured 
- The cluster frontend can access the public Internet 
- You have a node that you can install as a Rocks Development Appliance 
- There is sufficient disk capacity on your Rocks Development Appliance to hold
the roll sources, compiled binaries (if/when necessary) and Triton rolls you
wish to build.

Go back to the [Table of Contents](#table-of-contents)

## Installing Your Rocks Development Appliance

This guide uses a Rocks Development Appliance to build Triton rolls from roll
source. The Rocks Development Appliance definition was added to Rocks in version
6 so you must be using Rocks 6.x or newer to follow this guide.

Installation of a Rocks Development Appliance follows the [standard node
installation
sequence](http://central6.rocksclusters.org/roll-documentation/base/6.1/install-
compute-nodes.html) described in the [Rocks User Guide][rug] with the exception
that in step 2 you will NOT select 'Compute' as your appliance type but you will
instead select 'Development Appliance' as your appliance type.

[rug]: http://central6.rocksclusters.org/roll-documentation/base/6.1/ "Rocks Users Guide"

!["Adding a 'Development Server' appliance with insert-ethers](../images/01_insert-ethers_devel-server.png?raw=true "Adding a 'Development Server' appliance with insert-ethers")

Once devel-server-0-0 has completed installation you should verify that you can
login to the node as root.

```
[root@frontend ~]# ssh devel-server-0-0
Last login: Tue Aug 20 10:31:51 2013 from frontend.local
Rocks 6.1 Development Server
Rocks 6.1 (Emerald Boa)
Profile built 10:23 20-Aug-2013

Kickstarted 10:29 20-Aug-2013
[root@devel-server-0-0 ~]#
```

**NOTE: The definition of the Rocks Development Appliance is contained in the following file(s)...**

```
	[root@frontend ~]# ls -l /export/rocks/install/rocks-dist/x86_64/build/nodes/devel*
	-rw-r--r-- 1 root root 2840 Mar  6 22:39 /export/rocks/install/rocks-dist/x86_64/build/nodes/devel-appliance.xml
	-rw-r--r-- 1 root root  687 Mar  6 22:39 /export/rocks/install/rocks-dist/x86_64/build/nodes/devel-server.xml
	-rw-r--r-- 1 root root 1039 Mar  6 22:39 /export/rocks/install/rocks-dist/x86_64/build/nodes/devel.xml
```	

To modify the configuration of the Rocks Development Appliance you should follow
the [customization
sequences](http://central6.rocksclusters.org/roll-documentation/base/6.1/
customization.html) described in the [Rocks User Guide][rug] with the following
exceptions...

- Where applicable you will copy skeleton.xml to extend-devel.xml
- Rocks Development Appliances explicitly have autofs disabled so they will NOT
  have access to /share/apps

Go back to the [Table of Contents](#table-of-contents)

## Installing Triton Rolls

A copy of the Rocks source code, including the source code for the Triton rolls,
is currently hosted on a [public Gitweb server](http://git.rocksclusters.org/cgi-bin/gitweb.cgi).

Included in this repository is the historic source for the entire Rocks software
stack, a mirror of the current Rocks software stack now published to GitHub and
all of the published Triton rolls.

><strong>Tip:</strong> Eventually the Triton rolls will also be published to GitHub and this repository will remain for archival purposes only.

The basic workflow for installing software using the Triton rolls is as follows...

- [Download Triton Rolls to Development Server](#download-triton-rolls-to-development-server)
- [Build Triton Rolls on Development Server](#build-triton-rolls-on-development-server)
- [Copy Triton Rolls to Frontend](#copy-triton-rolls-to-frontend)
- [Install Triton Rolls on Frontend](#install-triton-rolls-on-frontend)
- [Test Triton Rolls Installation on Frontend](#test-triton-rolls-installation-on-frontend)
- [Install or Reinstall Nodes](#install-or-reinstall-nodes)


Go back to the [Table of Contents](#table-of-contents)

### Download Triton Rolls to Development Server

In order to download Triton rolls directly to your Development Server
(devel-0-0) your frontend needs to have access to the public Internet*.

A script is being provided with this documentation that can be used to download
all of the Triton rolls to devel-0-0...

```
	#!/bin/bash
	# This script will use 'git clone' to create a local copy of the Triton roll
	# source(s) on git.rocksclusters.org on your Rocks Development Appliance.
	#

	# TODO: Source is currently the git.rocksclusters.org Gitweb repository. It
	#       needs to be changed to the GitHub repository once the Triton rolls
	#       have been place into GitHub.

	# NOTE: When pulling the Triton roll source(s) from the git repository on
	#       a cluster without access to the public Internet (ie. a dev cluster
	#       in a virtual environment or private network) you can create an SSH
	#       tunnel to the repository host through another host that has access
	#       to the public Internet (ie. your virtualization host) and the
	#       cluster frontend. Then you can tunnel the git clone traffic through
	#       the SSH tunnel to put the Triton roll source(s) directly on your
	#       Development Server without first copying them somewhere else.
	# 	 
	#       For example, create a tunnel to port 80 of git.rocksclusters.org
	#       using <user>@<public_access_host>...
	# 	 
	#       ssh <user>@<public_access_host> -L 8888:git.rocksclusters.org:80
	# 	
	#       Then, change the Triton roll source(s) SRC to point to the tunnel
	#       you just defined.
	# 	
	#       SRC="http://localhost:8888/git/triton"
	# 	

	SRC="http://git.rocksclusters.org/git/triton"
	DST="/state/partition1/triton"

	# Make sure destination exists...
	mkdir -p $DST

	# Pull a list of all the repos in the SRC...
	wget $SRC -O index.html -o wget.log

	# Parse the list SRC repos...
	REPO_LIST=`cat index.html | grep DIR | grep -v git | cut -d\> -f6 | cut -d\" -f2 | cut -d\/ -f1`

	# Git clone all the triton repos into destination
	for repo in $REPO_LIST
	do
	  git clone $SRC"/"$repo"/.git" $DST"/"$repo
	done
```

Create a file on devel-0-0 and copy the above script into it. Make it executable
and then run the script to pull the Triton roll source(s) onto your devel-0-0
node. Here is sample output from running triton_repo_script.sh

```
	[root@devel-0-0 partition1]# ./triton_repo_script.sh
	Cloning into '/state/partition1/triton/R'...
	Cloning into '/state/partition1/triton/amber'...
	Cloning into '/state/partition1/triton/beast'...
	Cloning into '/state/partition1/triton/biotools'...
	Cloning into '/state/partition1/triton/chemistry'...
	Cloning into '/state/partition1/triton/cilk'...
	Cloning into '/state/partition1/triton/cmake'...
	Cloning into '/state/partition1/triton/cp2k'...
	Cloning into '/state/partition1/triton/cpmd'...
	Cloning into '/state/partition1/triton/data-transfer'...
	Cloning into '/state/partition1/triton/dataform'...
	Cloning into '/state/partition1/triton/db2'...
	Cloning into '/state/partition1/triton/ddt'...
	Cloning into '/state/partition1/triton/envmodules'...
	Cloning into '/state/partition1/triton/fftw'...
	Cloning into '/state/partition1/triton/flexlm'...
	Cloning into '/state/partition1/triton/fpmpi'...
	Cloning into '/state/partition1/triton/fsa'...
	Cloning into '/state/partition1/triton/gamess'...
	Cloning into '/state/partition1/triton/hadoop'...
	Cloning into '/state/partition1/triton/hdf'...
	Cloning into '/state/partition1/triton/ib'...
	Cloning into '/state/partition1/triton/idl'...
	Cloning into '/state/partition1/triton/intel'...
	Checking out files: 100% (69/69), done.
	Cloning into '/state/partition1/triton/lustre-client'...
	Cloning into '/state/partition1/triton/moab'...
	Cloning into '/state/partition1/triton/mpi'...
	Cloning into '/state/partition1/triton/myri10Gbe'...
	Cloning into '/state/partition1/triton/myrinet_mx'...
	Cloning into '/state/partition1/triton/nagios'...
	Cloning into '/state/partition1/triton/nwchem'...
	Cloning into '/state/partition1/triton/ofed'...
	Cloning into '/state/partition1/triton/pgi'...
	Cloning into '/state/partition1/triton/scar'...
	Cloning into '/state/partition1/triton/scipy'...
	Cloning into '/state/partition1/triton/tau'...
	Cloning into '/state/partition1/triton/thresher-config'...
	Cloning into '/state/partition1/triton/triton-base'...
	Cloning into '/state/partition1/triton/triton-config'...
	Cloning into '/state/partition1/triton/valgrind'...
```

When triton_repo_script.sh finishes running you should have a complete copy of
the published Triton roll source(s) in /state/partition1/triton and you can move
on to the next step of this documentation.

For example...

```
	[root@devel-0-0 ~]# tree /state/partition1/triton

	/state/partition1/triton
	|-- amber
	|   |-- DESCRIPTION
	|   |-- graphs
	|   |   `-- default
	|   |       `-- amber.xml
	|   |-- INSTALL
	|   |-- Makefile
	|   |-- nodes
	|   |   `-- amber-common.xml.in
	|   |-- PROTECTED
	|   |-- src
	|   |   |-- amber
	|   |   |   |-- ambertools-12.tar.gz
	|   |   |   |-- Makefile
	|   |   |   |-- patch-files
	|   |   |   |   |-- configure
	|   |   |   |   `-- README
	|   |   |   `-- version.mk
	|   |   |-- amber-modules
	|   |   |   |-- amber.module
	|   |   |   |-- amber.version
	|   |   |   |-- Makefile
	|   |   |   `-- version.mk
	|   |   |-- linux.mk
	|   |   |-- Makefile
	|   |   `-- roll-test
	|   |       |-- amber.t
	|   |       |-- Makefile
	|   |       `-- version.mk
	|   `-- version.mk
	|
	...edited for brevity...
	|
	|   |   `-- triton-server-scheduler
	|   |       |-- Makefile
	|   |       |-- maui.cfg.triton
	|   |       |-- maui-private.cfg
	|   |       `-- version.mk
	|   `-- version.mk
	`-- valgrind
```

Some of the Triton rolls are created for software with restricted
re-distribution policies. The content of these rolls is not complete
unless/until the software vendor is contacted and the missing pieces are
obtained directly.

The Triton rolls that are affected by this contain a file named PROTECTED in the
roll source directory.

For example, the Triton roll for the Intel C++ and Fortran Compilers and related
development tools does not include the binaries or a license file since this
software requires an contract/agreement with Intel to obtain the installer
packages and a valid software license.

```
	[root@devel-0-0 triton]# cat intel/PROTECTED
	src/intel-compilers/l_*intel64*

	[root@devel-0-0 triton]# ls intel/src/intel-compilers
	Makefile  version.mk
```

The Intel C++ and Fortan compiler packages must be obtained directly from Intel
and added to the Triton roll source for the intel roll before the roll can be
built. The Intel compiler binaries can be obtained from the [Intel Developer
Zone](http://software.intel.com/en-us/) website.

Once the Intel compiler binaries have been obtained and the required file(s)
placed into the Triton roll source directory then the intel roll can be built.

The Triton roll is expecting Intel C++/Fortran Compilers found in the following
Intel downloads...

```
	[root@devel-0-0 triton]# grep "^VERSION" intel/src/intel-compilers/version.mk && grep "^SOURCE" intel/src/intel-compilers/Makefile
	VERSION = 2013.1.117
	SOURCEC		= l_ccompxe_$(VERSION)
	SOURCEF		= l_fcompxe_$(VERSION)
```

On the Intel Developer Zone website these compilers are part of the Intel
Composer XE Suite, Update 1 from 10-Oct-2012.

A list of Intel compiler packages expected by the Triton intel roll can be found
in the file, intel/nodes/intel-compilers-common.xml.

```
	<package>intel-compilerproc-117</package>
	<package>intel-compilerproc-devel-117</package>
	<package>intel-compilerpro-devel-117</package>
	<package>intel-compilerprof-117</package>
	<package>intel-compilerprof-devel-117</package>
	* <package>intel-compilers-2013.1.117</package>
	<package>intel-idb-117</package>
	<package>intel-ipp-117</package>
	<package>intel-ipp-devel-117</package>
	<package>intel-mkl-117</package>
	<package>intel-mkl-devel-117</package>
	<package>intel-openmp-117</package>
	<package>intel-openmp-devel-117</package>
	<package>intel-sourcechecker-devel-117</package>

	<package>intel-compilerproc-common-117</package>
	<package>intel-compilerpro-common-117</package>
	<package>intel-compilerprof-common-117</package>
	<package>intel-compilerpro-vars-117</package>
	<package>intel-idbcdt-117</package>
	<package>intel-idb-common-117</package>
	<package>intel-ipp-common-117</package>
	<package>intel-mkl-common-117</package>
	<package>intel-sourcechecker-common-117</package>
	<package>intel-tbb-117</package>
	<package>intel-tbb-devel-117</package> 
```

The latest Intel C++/Fortran Compilers as of the date of this document are...

```
	l_ccompxe_2013.5.192.tgz  Update 5  07 Jun 2013
	l_fcompxe_2013.5.192.tgz  Update 5  07 Jun 2013
```

The Intel compiler packages contain the following RPM's which will be extracted
and copied into the SRC directory during the roll build process...

```
	intel-compilerpro-devel-192-13.1-5.x86_64.rpm
	intel-compilerproc-192-13.1-5.x86_64.rpm
	intel-compilerproc-devel-192-13.1-5.x86_64.rpm
	intel-compilerprof-192-13.1-5.x86_64.rpm
	intel-compilerprof-devel-192-13.1-5.x86_64.rpm
	intel-idb-192-13.0-5.x86_64.rpm
	intel-ipp-192-7.1-1.x86_64.rpm
	intel-ipp-devel-192-7.1-1.x86_64.rpm
	intel-mkl-192-11.0-5.x86_64.rpm
	intel-mkl-devel-192-11.0-5.x86_64.rpm
	intel-openmp-192-13.1-5.x86_64.rpm
	intel-openmp-devel-192-13.1-5.x86_64.rpm
	intel-sourcechecker-devel-192-13.1-5.x86_64.rpm

	intel-compilerpro-common-192-13.1-5.noarch.rpm
	intel-compilerpro-vars-192-13.1-5.noarch.rpm
	intel-compilerproc-common-192-13.1-5.noarch.rpm
	intel-compilerprof-common-192-13.1-5.noarch.rpm
	intel-idb-common-192-13.0-5.noarch.rpm
	intel-idbcdt-192-13.0-5.noarch.rpm
	intel-ipp-common-192-7.1-1.noarch.rpm
	intel-mkl-common-192-11.0-5.noarch.rpm
	intel-sourcechecker-common-192-13.1-5.noarch.rpm
	intel-tbb-192-4.1-4.noarch.rpm
	intel-tbb-devel-192-4.1-4.noarch.rpm
```
	
Go back to the [Table of Contents](#table-of-contents)

### Build Triton Rolls on Development Server

Enter the roll source directory and make the Rocks distribution...

```
	[root@devel-0-0 ~]# cd /state/partition1/triton/intel

	[root@devel-0-0 intel]# make default 2>&1 | tee build.log ; clear; ls -l *.iso && grep "build err" build.log
	/opt/rocks/share/devel/src/roll/../../etc/rocks-version.mk:286: rocks-version-common.mk: No such file or directory
	/opt/rocks/share/devel/src/roll/../../etc/python.mk:14: rocks-version-common.mk: No such file or directory
	/opt/rocks/share/devel/src/roll/../../etc/Rules.mk:707: Rules-install.mk: No such file or directory
	/opt/rocks/share/devel/src/roll/../../etc/Rules.mk:782: Rules-scripts.mk: No such file or directory
	/opt/rocks/share/devel/src/roll/../../etc/Rules.mk:813: Rules-rcfiles.mk: No such file or directory
	/opt/rocks/share/devel/src/roll/etc/Rolls.mk:280: Rules.mk: No such file or directory
	/opt/rocks/share/devel/src/roll/etc/Rolls.mk:283: roll-profile.mk: No such file or directory
	cp /opt/rocks/share/devel/src/roll/etc/roll-profile.mk roll-profile.mk
	cp /opt/rocks/share/devel/src/roll/../../etc/Rules.mk Rules.mk
	cp /opt/rocks/share/devel/src/roll/../../etc/Rules-linux.mk Rules-linux.mk
	.
	.
	.
	<edited for brevity>
	.
	.
	.
			Rocks create roll roll-intel.xml
	intel-roll-test-1-8: 0fb2b149e7c51bedfc91d01f134eb780
	roll-intel-kickstart-6.1-8: fdf87c4fdd22ba4dd8c10c7ac9c9664f
	intel-compilers-2013.1.117-8: 5fe6c0a2354c13fc6c27bf49cfb9eeb3
	intel-modules-2013.1.117-8: 62a8f0243557505b0eb5970533e050f1
	Creating disk1 (528.92MB)...
	Building ISO image for disk1 ...
	Creating disk2 (474.44MB)...  This disk is optional (extra rpms)
	Building ISO image for disk2 ...
```

Verify build completed without errors and produce one (or more) roll ISO files...

```
	[root@devel-0-0 intel]# ls -l *.iso && grep "build err" build.log
	-rw-r--r-- 1 root root 555038720 Aug 22 10:34 intel-6.1-8.x86_64.disk1.iso
	-rw-r--r-- 1 root root 497879040 Aug 22 10:34 intel-6.1-8.x86_64.disk2.iso
```

Go back to the [Table of Contents](#table-of-contents)

### Copy Triton Rolls to Frontend

You will need to copy the `*.iso` files you just created for the Triton intel
roll onto your Rocks cluster frontend. The easiest way to do this is to use
`scp` on your frontend...

```
	[root@frontend ~]# cd /export/apps/devel/rolls/
	[root@frontend rolls]# scp "devel-0-0:/state/partition1/triton/intel/*.iso" .
	intel-6.1-8.x86_64.disk1.iso                        100%  529MB  52.9MB/s   00:10
	intel-6.1-8.x86_64.disk2.iso                        100%  475MB  47.5MB/s   00:10
```

Go back to the [Table of Contents](#table-of-contents)

### Install Triton Rolls on Frontend

Install the intel roll...

```
	[root@frontend rolls]# Rocks add roll intel-6.1-8.x86_64.disk1.iso intel-6.1-8.x86_64.disk2.iso
	Copying intel to Rolls.....1083229 blocks
	Copying intel to Rolls.....971659 blocks
```

Enable the intel roll...

```
	[root@frontend rolls]# Rocks enable roll intel
```

Verify the intel roll...

```
	[root@frontend rolls]# Rocks list roll intel
	NAME   VERSION ARCH   ENABLED
	intel: 6.1     x86_64 yes
```

Re-build the Rocks distribution...

```
	[root@frontend ~]# cd /export/rocks/install
	Cleaning distribution
	Resolving versions (base files)
		including "kernel" (6.1,x86_64) roll...
		including "area51" (6.1,x86_64) roll...
		including "intel" (6.1,x86_64) roll...
		including "CentOS" (6.3,x86_64) roll...
		including "python" (6.1,x86_64) roll...
		including "service-pack" (6.1,x86_64) roll...
		including "web-server" (6.1,x86_64) roll...
		including "base" (6.1,x86_64) roll...
		including "torque-roll" (6.0.0,x86_64) roll...
		including "ganglia" (6.1,x86_64) roll...
		including "scar" (6.1,x86_64) roll...
		including "os" (6.1,x86_64) roll...
	Including critical RPMS
	Resolving versions (RPMs)
		including "kernel" (6.1,x86_64) roll...
		including "area51" (6.1,x86_64) roll...
		including "intel" (6.1,x86_64) roll...
		including "CentOS" (6.3,x86_64) roll...
		including "python" (6.1,x86_64) roll...
		including "service-pack" (6.1,x86_64) roll...
		including "web-server" (6.1,x86_64) roll...
		including "base" (6.1,x86_64) roll...
		including "torque-roll" (6.0.0,x86_64) roll...
		including "ganglia" (6.1,x86_64) roll...
		including "scar" (6.1,x86_64) roll...
		including "os" (6.1,x86_64) roll...
	Creating files (symbolic links - fast)
	Applying stage2.img
	Applying updates.img
	Installing XML Kickstart profiles
		installing "condor" profiles...
		installing "ganglia" profiles...
		installing "scar" profiles...
		installing "service-pack" profiles...
		installing "torque-roll" profiles...
		installing "web-server" profiles...
		installing "base" profiles...
		installing "intel" profiles...
		installing "python" profiles...
		installing "area51" profiles...
		installing "kernel" profiles...
		installing "os" profiles...
		installing "site" profiles...
		 Calling Yum genpkgmetadata.py
	Creating repository

	iso-8859-1 encoding on Ville Skytt <ville.skytta@iki.fi> - 2.8.2-2

		 Rebuilding Product Image including md5 sums
		 Creating Directory Listing
```

Verify package availability in Rocks distribution...

```
	[root@frontend install]# yum clean all
	Cleaning repos: Rocks-6.1
	Cleaning up Everything
```

```
	[root@frontend install]# yum info intel-compilerproc-devel-117-13.0
	Rocks-6.1                                                | 1.9 kB     00:00
	Rocks-6.1/primary                                        | 2.6 MB     00:00
	Rocks-6.1                                                             6634/6634
	Available Packages
	Name        : intel-compilerproc-devel-117
	Arch        : x86_64
	Version     : 13.0
	Release     : 1
	Size        : 40 M
	Repo        : Rocks-6.1
	Summary     : Intel(R) C++ Compiler XE 13.0 Update 1 for Linux*
	License     : Intel Copyright 1999-2012
	Description : Intel(R) C++ Compiler XE 13.0 Update 1 for Linux*
```

```
	[root@frontend install]# yum info intel-compilerprof-devel-117-13.0
	Available Packages
	Name        : intel-compilerprof-devel-117
	Arch        : x86_64
	Version     : 13.0
	Release     : 1
	Size        : 39 M
	Repo        : Rocks-6.1
	Summary     : Intel(R) Fortran Compiler XE 13.0 Update 1 for Linux*
	License     : Intel Copyright 1999-2012
	Description : Intel(R) Fortran Compiler XE 13.0 Update 1 for Linux*
```
Go back to the [Table of Contents](#table-of-contents)


### Test Triton Rolls Installation on Frontend

Install Triton intel roll on frontend...

```
	[root@frontend ~]# Rocks run roll intel > rocks_run_roll_intel.sh
	[root@frontend ~]# chmod +x rocks_run_roll_intel.sh
	[root@frontend ~]# ./rocks_run_roll_intel.sh 2>&1 | tee rocks_run_roll_intel.sh.log
	[root@frontend ~]# grep "[F|f]ailed" rocks_run_roll_intel.sh.log
```

Verify installation of Intel compiler packages on frontend...

```
	[root@frontend ~]# yum info intel-compilerproc-117-13.0 intel-compilerprof-117-13.0
	Installed Packages
	Name        : intel-compilerproc-117
	Arch        : x86_64
	Version     : 13.0
	Release     : 1
	Size        : 332 k
	Repo        : installed
	From repo   : Rocks-6.1
	Summary     : Intel(R) C++ Compiler XE 13.0 Update 1 for Linux*
	License     : Intel Copyright 1999-2012
	Description : Intel(R) C++ Compiler XE 13.0 Update 1 for Linux*

	Name        : intel-compilerprof-117
	Arch        : x86_64
	Version     : 13.0
	Release     : 1
	Size        : 20 M
	Repo        : installed
	From repo   : Rocks-6.1
	Summary     : Intel(R) Fortran Compiler XE 13.0 Update 1 for Linux*
	License     : Intel Copyright 1999-2012
	Description : Intel(R) Fortran Compiler XE 13.0 Update 1 for Linux*
```

Run the intel roll test script...

```
	[root@frontend ~]# /root/rolltests/intel.t
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

Go back to the [Table of Contents](#table-of-contents)

### Install or Reinstall Nodes

Now that the Triton intel roll has been installed and tested on your Rocks
cluster frontend you will need to install/re-install your cluster nodes that
should have access to the Intel compilers which are part of the newly added
Triton intel roll.

See the Rocks documentation for examples of how to re-install your cluster
nodes...

- [Forcing a Re-install at Next PXE Boot](http://central6.rocksclusters.org/roll-documentation/base/6.1/x1817.html)
- [Reinstall All Compute Nodes with SGE](http://central6.rocksclusters.org/roll-documentation/base/6.1/sge-cluster-reinstall.html)

Go back to the [Table of Contents](#table-of-contents)
