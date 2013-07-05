#!/bin/sh
bash install_cookbook.sh

# run chef-solo
if [ "$?" = "0" ]; then
	chef-solo -c solo.rb -j nodes/jenkins.json
fi
