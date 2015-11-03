#!/bin/bash
set -x
ACTION=$1
TOP_DIR=${PWD}
ISO=ubuntu-14.04.2-desktop-i386.iso
NEW_ISO_NAME=MyUbuntu.iso
LIVETEMP=livecdtmp

extract_iso() {
	if [ -d "${LIVETEMP}" ]
	then
		echo "${LIVETEMP} is exist"
		exit 1
	fi
	mkdir ${LIVETEMP}
	mv ${ISO} ${LIVETEMP}
	cd ${LIVETEMP}

	# mount ISO
	mkdir mnt
	sudo mount -o loop ${ISO} mnt

	# extract squashfs
	mkdir extract-cd
	sudo rsync --exclude=/casper/filesystem.squashfs -a mnt/ extract-cd
	sudo unsquashfs mnt/casper/filesystem.squashfs
	sudo mv squashfs-root edit

	sudo mkdir backup
	sudo cp -a extract-cd/casper backup
	sudo cp -a edit edit_bak
}

pack_iso() {
	cd ${LIVETEMP}
	rm -f extract-cd/casper/filesystem.squashfs
	mksquashfs edit/ extract-cd/casper/filesystem.squashfs
	printf $(du -sx --block-size=1 edit | cut -f1) > extract-cd/casper/filesystem.size

	rm -f ${NEW_ISO_NAME}
	cd extract-cd/
	rm -f md5sum.txt
	find . -type f -print0 | xargs -0 md5sum | grep -v "isolinux" > md5sum.txt
	mkisofs -D -r -V "${NEW_ISO_NAME}" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../${NEW_ISO_NAME} .
	cd ${TOP_DIR}
}

case "$ACTION" in 
	extract)
		extract_iso
		;;
	pack)
		pack_iso
		;;
	*)
		echo "enter extract or pack"
		;;
esac
