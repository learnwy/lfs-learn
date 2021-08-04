#!/bin/sh

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

> not found https://mirror-hk.koddos.net/lfs/lfs-packages/10.1/expat-2.2.10.tar.xz
>> so need download at before

pushd $LFS/sources
md5sum -c md5sums
popd

