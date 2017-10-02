#!/usr/bin/env bash

NVM_DEV="traddr:0000:01:00.0"

select TASK in unbind build idf bbt_get bbt_set erase;
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
		sudo nvm_addr erase $NVM_DEV 0x0
		;;
	*)
		break
		;;
	esac
done

