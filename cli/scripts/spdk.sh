#!/usr/bin/env bash

NVM_DEV="traddr:0000:01:00.0"

select TASK in build debug idf bbt_get bbt_set erase;
do
	case $TASK in
	build)
		echo "## Building liblightnvm"
		make spdk
		;;
	debug)
		echo "## Building liblightnvm"
		make debug spdk
		;;
	idf)
		echo "## Running nvm_dev info $NVM_DEV"
		sudo nvm_dev info $NVM_DEV
		;;
	bbt_get)
		echo "## Running nvm_bbt get $NVM_DEV"
		sudo nvm_bbt get $NVM_DEV
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

