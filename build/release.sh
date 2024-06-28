#!/bin/bash

git clean -xfdi
git submodule foreach --recursive git clean -xfdi

VERSION=`git describe --tags`
DIR_NAME="modsecurity-$VERSION"
TAR_NAME="modsecurity-$VERSION.tar.gz"

MY_DIR=${PWD##*/}
./build.sh

cd ..
tar --transform "s/^$MY_DIR/$DIR_NAME/" -cvzf $TAR_NAME --exclude .git $MY_DIR

sha256sum $TAR_NAME > $TAR_NAME.sha256
gpg -u 0B2BA1924065B44691202A2AD286E022149F0F6E --detach-sign -a $TAR_NAME 

cd -
echo $TAR_NAME ": done."

