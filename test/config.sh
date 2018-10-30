#!/bin/bash
set -e

testAlias+=(
	[hatchd:trusty]='hatchd'
)

imageTests+=(
	[hatchd]='
		rpcpassword
	'
)
