#!/bin/sh
# get cookbooks using berkshelf
berks install --path cookbooks

# run chef-solo
if [ "$?" = "0" ]; then
	chef-solo -c solo.rb -j nodes/chef.json
fi
