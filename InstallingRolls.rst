..	The content in this file/document is the primary content of the
	tutorial. Consider making *this* document the actual tutorial and
	pointing the README.rst file to it. Possibly it should go at/near the
	'top' of the Triton roll repository root.

Installing Rocks Rolls
**********************
Throughout this tutorial bear in mind that being in **root** is potentially dangerous to your system

In order to avoid unnecessary reinstallations of your frontend, please do all ``make`` commands for creating ISOs on the development appliance.  This is to prevent any errors that may occur when creating the rolls from affecting your frontend.  You may always reinstall your nodes if an error were to occur.

..	Rocks convention is to call the primary host the frontend not *front end*

How To Get The Triton Repo
==========================
The Triton Repo is located in GitHub.  A bash script has been supplied below in order for you to use git clone to acquire your own copy:

https://raw.github.com/sdsc/cluster-guide/master/triton_repo_script.sh::

   #/bin/bash
   #This script will use git clone to copy over the triton repo from GitHub

   #run a 'for loop' to grab each file using 'git clone'
   for i in R "amber" beast "biotools" chemistry "cilk" cmake "cp2k" cpmd "data-transfer" dataform "db2" ddt "envmodules" fftw "flexlm" fpmpi "fsa" gamess "hadoop" hdf "ib" idl "intel" lustre-client "moab" mpi "myri10Gbe" myrinet_mx "nagios" nwchem "ofed" pgi "scar" scipy "tau" thresher-config "triton-base" triton-config "valgrind"
   do
       git clone "http://git.rocksclusters.org/git/triton/$i/.git" "/state/partition1/triton/$i"
   done

Use a text editor such as `emacs` to create a `.sh` file for the bash script.  After you have made the file run is by doing::

   sh triton_repo_script.sh

Keep in mind that the second part of the ``git clone`` command in the for loop is the location which you are cloning the repo to.

..	The contents of the Triton repository will change when the repository
	is moved to GitHub. Best NOT to publish a script with repo names.
	Alternately, pull a list of repos belonging to the SDSC GitHub account
	and pattern match them. This needs a bit of thought and will be impacted
	by the specific implementation of the Triton rolls sources on GitHub once
	the cvs2git migration is complete.


Compiling the Roll
==================
Typically the rolls that need to be installed manually are:

*scar* *cmake* *mpi* *R* *fftw* *hdf* *math* *dataform*

..	See previous comment about naming specific Triton repos.

For more information read **triton/src/roll/bootstrap.sh**, which is located in the code drop from the Triton Repository. ``scp`` the files onto your *devel-server-0-0* into a place with enough space such as */state/partition1/* and ``ssh`` onto your development server:

..	The mentioned bootstrap.sh script is NOT pulled from the Triton Repository.

::

   scp $TRITONREPO root@devel-server-0-0:/state/partition1/
   ssh root@devel-server-0-0

First you must ``cd`` into the directory of the roll::

   cd /state/partition1/triton/src/roll/scar

..	Mentioned before that specific rolls should not be mentioned. In
	particular, the scar roll is very specific to SDSC and should probably
	not be used as an example here. A more 'generic' roll might be a better
	choice (ie. intel).

Once in the directory run the ``make`` command.  It is recommended that you create a log file to keep track of the installation records.  This can be done by using the following command::

   make default 2>&1 | tee log

*This pipe will create a log file located in the roll's directory*

In the log files you may use this command to check for errors::

   grep 'build err' log

If the ``make`` command created an ISO file successfully it should end off by saying::

   Creating disk1 (x.xxMB)...
   Building ISO image for disk1...

You need to copy the *ISO* file from the development appliance over to your frontend to set up the distribution.  Copy the ISOs to a direcory in your home directory::

   scp scar-6.1-0.x86_64.disk1.iso root@hpcdev-006:~/rolls_to_add/
   
..	Aside for the use of scar as an example roll this sequence is
	essentially fine.


Installing the Roll
===================

Go back to your frontend and ``cd`` into the directory that you copied the ISO over to.  Once there use the following commands::

   rocks add roll scar-6.1-0.x86_64.disk1.iso
   rocks enable roll scar

In order to set up the distro you must ``cd`` over to the right directory::

   cd /export/rocks/install

Once there you may create the distro by running::

   rocks create distro

You may check to see if your roll has been properly added and enabled by using::

   rocks list roll

The output for this command will be::

NAME          VERSION    ARCH   ENABLED
ganglia:      6.1        x86_64 yes    
os:           6.1        x86_64 yes    
kvm:          6.1        x86_64 yes    
web-server:   6.1        x86_64 yes    
bio:          6.1        x86_64 yes 

   *Look for the name of the roll in the first column*

..	All essentially fine.

Repeat these steps for each roll that needs to be installed.  When you run into an error building an ISO on the development appliance it may be due to the dependencies.  If this is the case you must reinstall the node by doing the method described in `Reinstalling Your Development Appliance`_.

..	This is an interesting problem and should be expanded upon. Simply
	reinstalling the node will not necessarily resolve a dependency issue as
	the missing dependency may not be built. Perhaps we need to be careful to
	document any dependencies that exist in the Triton rolls. The rolls we
	release 'should' not be inter-dependent.