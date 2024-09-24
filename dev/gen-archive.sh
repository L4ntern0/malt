#!/bin/bash
######################################################
#            PROJECT  : MATT                         #
#            VERSION  : 1.2.2                        #
#            DATE     : 06/2023                      #
#            AUTHOR   : Valat Sébastien              #
#            LICENSE  : CeCILL-C                     #
######################################################

######################################################
#This script aimed at generating archive to distribute
#the project. Simply call it from root directory without
#any agruments.

######################################################
#extract version
version=1.2.2
prefix=malt-${version}

######################################################
if [ ! -z "$(echo $version | grep dev)" ]; then
	prefix=${prefix}-$(git rev-parse --short HEAD)
fi

######################################################
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
