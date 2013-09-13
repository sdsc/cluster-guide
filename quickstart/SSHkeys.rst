..	This file/document is beyond the scope of this tutorial and should be
	removed.

Using SSH Keys
**************
SSH Keys allow an extra layer of security for your cluster and any other cluster you access.  It is good practice to use SSH Keys to prevent your data from being accessed or corrupted by infiltrating users.

Setting Up SSH Keys
===================
You can create your ssh keys using the following command on your local computer::

   ssh-keygen -t dsa

The following text should appear ``Enter file in which to save the key``.  Be sure to give the keys a name that will conflict with anyone else's ssh keys.  Once you have entered in the name of your ssh keys it will ask for a **passphrase** ``Enter passphrase (empty for no passphrase):``.

Create a **passphrase** to go with the ssh keys and be sure to remember it as it will be the password asked from you when you ssh into the remote computers with your ssh key.  

This will create two files (a public key and a private key).  The files created will be located in the */.ssh* directory.  Now you must ``scp`` the generated keys onto the remote computer (typically your front end that you are accessing)::

   scp ~/.ssh/gsiman_dsa.pub root@hpcdev-006:.ssh/gsiman_dsa.pub

Then ``ssh`` onto your front end and ``cd`` into the */.ssh* directory.  Append the key you copied in to the *authorized_keys* file by doing::

   cat gsiman_dsa.pub >> authorized_keys

Your ssh key is now on the remote compute.  Keep in mind that when you ssh into the computer now it will ask you for the **passphrase** you entered in earlier.
