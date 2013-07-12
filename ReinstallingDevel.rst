Reinstalling Your Development Appliance
=======================================
You will need to reinstall your Development Appliance as a Compute Node.  In order to do so you must first remove it as an installed appliance on your Front End.

First set the boot action to install on the Front End by inputing::

   rocks set host boot devel-0-0 action=install

``ssh`` into the appliance you are reinstalling and change its settings to ensure its boot settings are set to pxe and reboot the node::

   ssh devel-0-0
   ipmitool chassis bootdev pxe options=persistent
   shutdown

*If you are reinstalling your Development Appliance due to dependencies then perform a ``reboot`` instead of a ``shutdown``*

Return to your Front End and remove the host so that it will reinstall upon boot::

   rocks remove host devel-0-0

Finally you may reinstall the node and yoru remaining nodes as compute nodes using the *insert ethers* method described in `Installing Your Development Appliance <https://github.com/sdsc/cluster-guide/blob/master/InstallingDevel.rst>`_.