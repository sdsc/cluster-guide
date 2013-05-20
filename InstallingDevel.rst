Installing Your Development Appliance
=====================================
After connecting all the hardware up through a switch on their *eth0* ports to connect all the nodes up to the front end, make sure that all the nodes are off.  Keep in mind that *eth0* is usually used for local purposes such as this, while *eth1* is used for connecting to the WLAN.  Take note of the ``rocks help`` command for more information on rocks commands.

Now open up a terminal on your front end and do the following command::

   insert-ethers

The screen below will then pop up on your terminal:

.. figure:: images/3insert-ethers_Cropped.png
   :align:  center

   *The interface for the insert-ethers command*

Select to install a Development Applaince.  Now turn on the desired node and wait until it is detected.  When the node is detected you will see the mac address of the node in the *Inserted Appliances* window shown below.

.. figure:: images/4node_discovered_Cropped.png
   :align:  center

   *The node you turned on  will pop up with its mac address and host name*

In order to prevent risk of corrupted hardware, do **not** exit this terminal until it is safe to do so (this is explained later in this tutorial).  When a node is installing you can check its progress by using the command::

   rocks console devel-0-0

   *This brings up the window in the picture below*

.. figure:: images/5rocks-console_Cropped.png
   :align:  center

   *This is the process of the installation of the nodes shown through rocks console*

If you need to look up the **hostnames** of your nodes then use the command::

   [gsiman@hpcdev-006 ~]$ rocks list host
   HOST              MEMBERSHIP   CPUS RACK RANK RUNACTION INSTALLACTION
   hpcdev-006:       Frontend     8    0    0    os        install
   devel-0-0:        Development  16   0    0    os        install

   *The hostnames are in the first column*

You will not be able to use the ``rocks console`` command once the installation is done, but at that point you will be able to simply ``ssh`` into it.  When *s appear between all of the *()s* you may press the *f8* key to quit the GUI without interupting the installation.

.. figure:: images/6f8_okay_Cropped.png
   :align:  center

   *Notice the appearance of the **

Once the installation of your node(s) is complete test if you can ``ping`` and ``ssh`` into all of your nodes::

   ping devel-0-0
   ssh devel-0-0
