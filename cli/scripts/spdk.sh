#!/usr/bin/env bash

NVM_DEV="traddr:0000:01:00.0"

select TASK in unbind build idf bbt_get bbt_set erase wr rd blk_e blk_w blk_r line_e line_w line_r;
do
	case $TASK in
	unbind)
		echo "## Unbinding NVMe devices"
		sudo /opt/spdk/scripts/setup.sh
		;;
	build)
		echo "## Building liblightnvm"
		make debug spdk
		;;
	idf)
		echo "## Running nvm_dev info $NVM_DEV"
		sudo nvm_dev info $NVM_DEV
		;;
	bbt_get)
		echo "## Running nvm_bbt get $NVM_DEV"
		sudo valgrind nvm_bbt get $NVM_DEV 0 0
		;;
	bbt_set)
		echo "## Running nvm_bbt set $NVM_DEV"
		sudo nvm_bbt mark_b $NVM_DEV 0x0
		;;
	erase)
		echo "## Running nvm_addr erase $NVM_DEV"
		sudo valgrind nvm_vblk line_erase $NVM_DEV 0 0 0 0 0
		;;
	wr)
		echo "## Running nvm_addr write $NVM_DEV"
		sudo nvm_vblk line_write $NVM_DEV 0 0 0 0 0
		;;

	rd)
		echo "## Running nvm_addr read $NVM_DEV 0x0"
		sudo nvm_addr read $NVM_DEV 0x0 -o /tmp/addr.bin
		;;

	blk_e)
		echo "## Running nvm_vblk erase $NVM_DEV 0x0"
		sudo nvm_vblk erase $NVM_DEV 0x0
		;;

	blk_w)
		echo "## Running nvm_vblk write $NVM_DEV 0x0"
		sudo nvm_vblk write $NVM_DEV 0x0
		;;

	blk_r)
		echo "## Running nvm_vblk read $NVM_DEV 0x0"
		sudo nvm_vblk read $NVM_DEV 0x0 -o /tmp/vblk.bin
		;;

	line_e)
		echo "## Running nvm_vblk line_erase $NVM_DEV 0 15 0 7 0"
		sudo nvm_vblk line_erase $NVM_DEV 0 15 0 7 0
		;;

	line_w)
		echo "## Running nvm_vblk line_write $NVM_DEV 0 15 0 7 0"
		sudo nvm_vblk line_write $NVM_DEV 0 15 0 7 0
		;;

	line_r)
		echo "## Running nvm_vblk line_read $NVM_DEV 0 15 0 7 0"
		sudo nvm_vblk line_read $NVM_DEV 0 15 0 7 0
		;;

	*)
		break
		;;
	esac
done

