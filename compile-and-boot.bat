del boot.bin
del boot.flp
del boot.iso
del cdiso\boot.flp
nasm -f bin -o boot.bin boot.asm
copy /b boot.bin boot.flp
copy boot.flp cdiso\
mkisofs -no-emul-boot -boot-load-size 4 -o boot.iso -b boot.flp cdiso/
qemu-system-x86_64 boot.bin -L "C:\Program Files\qemu"