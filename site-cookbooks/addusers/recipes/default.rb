#
# Cookbook Name:: addusers
# Recipe:: default
#
# Copyright 21., YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#ユーザを設定する。
group node[:adduser][:group][:name] do
	append true
	gid node[:adduser][:group][:gid]
	:create
end

user node[:adduser][:name] do
	comment node[:adduser][:comment]
	uid node[:adduser][:uid]
	gid node[:adduser][:name]
	home "/home/" + node[:adduser][:name]
	shell node[:adduser][:shell]
	username node[:adduser][:name]
end

if node[:adduser][:addToWheel]
	group "wheel" do
		append true
		members node[:adduser][:name]
		system true
		:modify
	end
end

directory "/home/" + node[:adduser][:name] + "/.ssh/" do
	owner node[:adduser][:name]
	group node[:adduser][:group][:name]
	mode "00755"
	action :create
end

# authorized_keysの中身を作成する
begin
	c = File.read("/home/" + node[:adduser][:name] + "/.ssh/authorized_keys")
	c += "\n"
rescue
	c = ""
end

node[:adduser][:user1][:ssh_rsa].each do |ssh_key|
	c += ssh_key
	c += "\n"
end

file "/home/" + node[:adduser][:name] + "/.ssh/authorized_keys" do
		owner node[:adduser][:name]
		group node[:adduser][:group][:name]
		mode "0600"
		content c
		action :create_if_missing
end
}
