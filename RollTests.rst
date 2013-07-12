Debugging your Roll Installations
*********************************
There are a few ways that you can test whether or not a roll has been successfully installed on a cluster.  These debugging methods are discussed in detail on the Rocks Clusters documentation site listed below.

`Rocks Cluster Debugging <http://www.rocksclusters.org/roll-documentation/developers-guide/5.4.3/testing-post.html>`_

Below are a few debugging tests that you may also use.

The XML File Test
=================
The roll should now be added.  One way to see that the rolls are working is to run the following command::

   rocks list host xml compute-0-1 >& ~/xml_files/scar.xml

   *This will create an xml file that you can search for errors*

If the output does not contain errors than it should run fine.  Run a ``grep`` command to search for errors::

   grep 'err' ~/xml_files/scar.xml

If you do not grep any errors then this test has passed.

The Perl Script Test
====================
A Perl script is installed with each of the roll installations to test whether or not the roll has been properly installed.  First you must change directory into the directory that the scripts are installed into::

   cd /root/rolltests/

Once you are in this directory you should be able to use an ``ls`` command to check which of the rolls you installed have perl scripts.  To run a Perl scripts simply put in the following command::

   perl scar.t

This will automatically run a script which should create an output similar to the following::

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

From these outputs you should be able to find out whether or not your rolls have been installed correctly.