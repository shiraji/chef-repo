# move to .
_current_file=`readlink -f $0`
_current_dir=`dirname $_current_file`
cd $_current_dir

# intall cookbooks
berks install --path cookbooks

# run chef-solo
if [ "$?" = "0" ]; then
	chef-solo -c solo.rb -j nodes/jenkins.json
fi
