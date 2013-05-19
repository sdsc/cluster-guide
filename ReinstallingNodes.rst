Reinstalling Your Appliance Node
================================
If for any reason you would like to reinstall a node first find the name of the host using::

   rocks list host

Now set the boot action to install on the front end by inputing::

   rocks set host boot devel-0-0 action=install

ssh into the appliance you are reinstalling and change its settings to ensure it boot settings are set to pxe and reboot the node::

   ssh devel-0-0
   ipmitool chassis bootdev pxe options=persistent
   reboot

Your node should now be reinstalling.  If you would like to reinstall the node as a different appliance then instead of rebooting the it, shut it down and continue with the following instructions::

   shutdown

Return to your front end and remove the host so that it will reinstall upon boot::

   rocks remove host devel-0-0

Finally you may reinstall the computer using the *insert ethers* method.
