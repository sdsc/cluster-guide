Reinstalling Your Development Appliance
=======================================
You will need to reinstall your Development Appliance as a Compute Node.  In order to do so you must first remove it as an installed appliance on your Front End.

First set the boot action to install on the front end by inputing::

   rocks set host boot devel-0-0 action=install

``ssh`` into the appliance you are reinstalling and change its settings to ensure its boot settings are set to pxe and reboot the node::

   ssh devel-0-0
   ipmitool chassis bootdev pxe options=persistent
   shutdown

Return to your Front End and remove the host so that it will reinstall upon boot::

   rocks remove host devel-0-0

Finally you may reinstall the computer using the *insert ethers* method.
