#!/bin/sh
{
srcDir="/usr/local/src"
installDir="/usr/local"

yamlFileExt=".tar.gz"
yaml="yaml-0.1.4"
yamlFileName=$yaml$yamlFileExt
yamlHTML="http://pyyaml.org/download/libyaml/$yamlFileName"

rubyFileExt=".tar.gz"
rubyMajorVersion="1.9"
ruby="ruby-${rubyMajorVersion}.3-p392"
rubyFileName=$ruby$rubyFileExt
rubyPATH="ftp://ftp.ruby-lang.org/pub/ruby/$rubyMajorVersion/$rubyFileName"

echo "*** yaml ***"
#yamlのdownload
cd $srcDir
wget -O $yamlFileName $yamlHTML
if [ "$?" != "0" ]; then
        echo "Cannot find yaml module. URL: $yamlHTML"
        exit 1
fi

#yamlのコンパイル
tar zxvf $yamlFileName
cd $yaml
./configure --prefix=$installDir
make
make install
if [ "$?" != "0" ]; then
        echo "Could not compile yaml. Error code: $?"
        exit 1
fi

echo "*** yum libraries ***"
#gccなどのインストール
yum -y install gcc gcc-c++ make curl-devel openssl-devel zlib-devel httpd-devel libxml2-devel libxslt-devel

# rubyをdownload
echo "*** ruby ***"
cd $srcDir
wget -O $rubyFileName $rubyPATH
if [ "$?" != "0" ]; then
        echo "Cannot find ruby module. URL: $rubyPATH"
        exit 1
fi

#rubyのコンパイル
tar xvzf $rubyFileName
cd $ruby
./configure --prefix=$installDir
make
make install
if [ "$?" != "0" ]; then
        echo "Could not compile ruby. Error code: $?"
        exit 1
fi

echo "*** gem update ***"
#gemの更新
gem update --system

#chef,rake,knife,berkshelfのインストール
echo "*** rake ***"
gem uninstall rake -x -a --force
gem install rake --no-rdoc --no-ri -f

echo "*** chef ***"
gem uninstall chef -x -a --force
gem install chef --no-rdoc --no-ri -f

echo "*** knife-solo ***"
gem uninstall knife-solo -x -a --force
gem install knife-solo --no-rdoc --no-ri -f

echo "*** berkshelf ***"
gem uninstall berkshelf -x -a --force
gem install berkshelf --no-rdoc --no-ri -f

#check version
echo "*** rube -v ***"
ruby -v

echo "*** gem -v ***"
gem -v

echo "*** chef-solo -v ***"
chef-solo -v

echo "*** knife-solo -v ***"
knife -v

echo "*** berks -v ***"
berks -v

} > setup.log
