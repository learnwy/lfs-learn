#!/bin/sh

# first uncompree binutils

mkdir -v build
cd build

../configure --prefix=$LFS/tools \
--with-sysroot=$LFS \
--target=$LFS_TGT \
--disable-nls \
--disable-werror

make
make install

# gcc pass1
# first uncompress self

tar -xf $LFS/sources/mpfr-4.1.0.tar.xz
mv mpfr-4.1.0 mpfr
tar -xf $LFS/sources/gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
# this is .tar.gz so need z flag
tar -zxf $LFS/sources/mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc

case $(uname -m) in
x86_64)
sed -e '/m64=/s/lib64/lib/' \
-i.orig gcc/config/i386/t-linux64
;;
esac

mkdir -v build
cd build

../configure \
--target=$LFS_TGT \
--prefix=$LFS/tools \
--with-glibc-version=2.11 \
--with-sysroot=$LFS \
--with-newlib \
--without-headers \
--enable-initfini-array \
--disable-nls \
--disable-shared \
--disable-multilib \
--disable-decimal-float \
--disable-threads \
--disable-libatomic \
--disable-libgomp \
--disable-libquadmath \
--disable-libssp \
--disable-libvtv \
--disable-libstdcxx \
--enable-languages=c,c++

make
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h

# linux api
make mrproper

make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

# glibc
## create slink for lsb compliance.
case $(uname -m) in
i?86)
ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
;;
x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
;;
esac

patch -Np1 -i $LFS/sources/glibc-2.33-fhs-1.patch

mkdir -v build
cd build

../configure \
--prefix=/usr \
--host=$LFS_TGT \
--build=$(../scripts/config.guess) \
--enable-kernel=3.2 \
--with-headers=$LFS/usr/include \
libc_cv_slibdir=/lib

make
make DESTDIR=$LFS install

# check glibc is ok
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep '/ld-linux'

## expect output:
## [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]

# clean test files
rm -v dummy.c a.out

# libstd++
## libstd++ is in package gcc-pass-1

mkdir -v build-libstd++
cd build-libstd++

../libstdc++-v3/configure \
--host=$LFS_TGT \
--build=$(../config.guess) \
--prefix=/usr \
--disable-multilib \
--disable-nls \
--disable-libstdcxx-pch \
--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0

make
make DESTDIR=$LFS install

