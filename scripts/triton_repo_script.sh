#/bin/bash
#This script will use git clone to copy over the triton repo from GitHub

#run a 'for loop' to grab each file using 'git clone'
for i in R "amber" beast "biotools" chemistry "cilk" cmake "cp2k" cpmd "data-transfer" dataform "db2" ddt "envmodules" fftw "flexlm" fpmpi "fsa" gamess "hadoop" hdf "ib" idl "intel" lustre-client "moab" mpi "myri10Gbe" myrinet_mx "nagios" nwchem "ofed" pgi "scar" scipy "tau" thresher-config "triton-base" triton-config "valgrind"
do
    git clone "http://git.rocksclusters.org/git/triton/$i/.git" "/state/partition1/triton/$i"
done