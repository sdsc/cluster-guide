Installing Rocks Rolls
======================
*Throughout this tutorial bare in mind that being in **root** is potentially dangerous to your system and that you may create additional users to avoid this danger.

In order to avoid unnecessary reinstallations of your front end, please do all ``make`` commands for creating ISOs on the development appliance that you were asked to create.  This is to prevent any errors that may occur when creating the rolls from affecting your front end.  You may always reinstall your nodes if an error were to occur.

**HOW TO GET TRITON REPO**

Typically the rolls that need to be installed manually are:

*scar* *cmake* *mpi* *R* *fftw* *hdf* *math* *dataform*

For more information read **triton/src/roll/bootstrap.sh**, which is located in the code drop from the Triton Repository.  ``scp`` the files onto your *devel-server-0-0* into a place with enough space such as */state/partition1/* and ``ssh`` onto your development server::

   scp $TRITONREPO root@devel-server-0-0:/state/partition1/
   ssh root@devel-server-0-0

First you must ``cd`` into the directory of the roll::

   cd /state/partition1/triton/src/roll/scar

Once in the directory run the ``make`` command.  It is recommended that you create a log file to keep track of the installation records.  This can be done by using the following command::

   make default 2>&1 | tee log

If the ``make`` command created an ISO file successfully it should end off by saying::

   Creating disk1 (x.xxMB)...
   Building ISO image for disk1...

This option will allow you to search through the log file for any errors::

   grep 'build err' log

You need to copy the *ISO* file from the development appliance over to your front end to set up the distrobution.  You may place the ISO files anywhere, but it is recommended that you place them in a direcory in your home directory::

   scp $NAMEOFISO root@hpcdev-006:~/$ROLLSTOADD/

Go back to your front end and ``cd`` into the directory that you copied the ISO over to.  Once there use the following commands::

   rocks add roll $NAMEOFISO
   rocks enable roll scar

In order to set up the distrobution you must ``cd`` over to the right directory::

   cd /export/rocks/install

Once there you may create the distrobution by running::

   rocks create distro
   rocks run roll scar | bash

The roll should now be installed.  The primary way to see that the rolls are working is to run the following command::

   rocks list host xml compute-0-1 >& scar.xml

If the output does not contain errors than it should run fine.  You may check to see if you roll has been properly added and enabled by using::

   rocks list roll

Repeat these steps for each roll that needs to be installed.  When you run into an error building an ISO on the development appliance it may be due to the dependencies.  If this is the case you must reinstall the node by doing the method described in the `Reinstalling Your Nodes`_ section.
