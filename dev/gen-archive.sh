#!/bin/bash
############################################################
#    PROJECT  : MALT (MALoc Tracker)
#    VERSION  : 1.2.3
#    DATE     : 10/2024
#    LICENSE  : CeCILL-C
#    FILE     : dev/gen-archive.sh
#-----------------------------------------------------------
#    AUTHOR   : Sébastien Valat - 2015 - 2024
#    AUTHOR   : Antoine Bernard (crans.org) - 2024
############################################################

############################################################
#This script aimed at generating archive to distribute
#the project. Simply call it from root directory without
#any agruments.

############################################################
#extract version
version=1.2.3
prefix=malt-${version}

############################################################
if [ ! -z "$(echo $version | grep dev)" ]; then
	prefix=${prefix}-$(git rev-parse --short HEAD)
fi

############################################################
echo "Generate ${prefix}.tar.gz..."
set -e
git archive --format=tar --prefix=${prefix}/ HEAD | bzip2 > /tmp/${prefix}.tar.bz2
pushd /tmp
tar -xf ${prefix}.tar.bz2
pushd ${prefix}/src/webview
./prepare.sh
popd
tar -cjf ${prefix}.tar.bz2 ${prefix}
popd
mv /tmp/${prefix}.tar.bz2 ./
rm -rfvd /tmp/${prefix}
echo "Finished"
