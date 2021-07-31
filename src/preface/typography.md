# Typography

To make things easier to follow, there are a few typographical conventions used throughout this book. This section contains some examples of the typographical format found throughout Linux From Scratch.

```bash
./configure --prefix=/usr
```
This form of text is designed to be typed exactly as seen unless otherwise noted in the surrounding text. It is also used in the explanation sections to identify which of the commands is being referenced.
```bash
CC="gcc -B/usr/bin/" ../binutils-2.18/configure \
  --prefix=/tools --disable-nls --disable-werror
```
Note that the backslash must be followed by an immediate return.  Other whitespace characters like spaces or tab characters will create incorrect results.

```text
install-info: unknown option '--dir-file=/mnt/lfs/usr/info/dir'
```

This form of text (fixed-width text) shows screen output, usually as the result of commands issued.  This format is also used to show filenames, such as `/etc/ld.so.conf`.

*Emphasis*

This form of text is used for several purposes in the book. Its main purpose is to emphasize important points or items.

[http://www.linuxfromscratch.org/]()

This format is used for hyperlinks both within the LFS community and to external pages. It includes HOWTOs, download locations, and websites.

```bash
cat > $LFS/etc/group << "EOF"
root:x:0:
bin:x:1:
......
EOF
```
This format is used when creating configuration files. The first command tells the system to create the file `$LFS/etc/group` from whatever is typed on the following lines until the sequence End Of File (EOF) is encountered. Therefore, this entire section is generally typed as seen.

`<REPLACED TEXT>`

This format is used to encapsulate text that is not to be typed as seen or for copy-and-paste operations.

`[OPTIONAL TEXT]`

This format is used to encapsulate text that is optional.

`passwd(5)`

This format is used to refer to a specific manual (man) page. The number inside parentheses indicates a specific section inside the manuals. For example, `passwd` has two man pages. Per LFS installation instructions, those two man pages will be located at `/usr/share/man/man1/passwd.1` and `/usr/share/man/man5/passwd.5`. When the book uses file`passwd(5)` it is specifically referring to `/usr/share/man/man5/passwd.5`. `man passwd` will print the first man page it finds that matches "passwd", which will be `/usr/share/man/man1/passwd.1`. For this example, you will need to run `man 5 passwd` in order to read the page being specified. Note that most man pages do not have duplicate page names in different sections. Therefore, `man <program name>` is generally sufficient.