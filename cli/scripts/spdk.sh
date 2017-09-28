#!/usr/bin/env bash

select TASK in build debug info vgrnd;
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
	vgrnd)
		echo "## Running nvm_dev info (with algrind)"
		NVM_CLI_BE_ID="0x8" sudo valgrind nvm_dev info "traddr:0000:01:00.0"
		;;

	info)
		echo "## Running nvm_dev info"
		NVM_CLI_BE_ID="0x8" sudo nvm_dev info "traddr:0000:01:00.0"
		#NVM_CLI_BE_ID="0x8" sudo nvm_dev info "traddr:0000:02:00.0"
		#NVM_CLI_BE_ID="0x8" sudo nvm_dev info FOO
		;;
	*)
		break
		;;
	esac
done

