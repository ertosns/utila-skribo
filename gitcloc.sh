#!/bin/bash

repo=/tmp/gitcloc_repo

git clone --depth 1 --shallow-submodule "$1" $(repo) && cloc $(repo)

if [ $1 == "1" ]; then
	mv $(repo) /opt
else
	rm -rf $(repo)
fi
