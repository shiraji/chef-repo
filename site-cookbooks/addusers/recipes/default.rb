#
# Cookbook Name:: addusers
# Recipe:: default
#
# Copyright 21., YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

users = node[:adduser]

#それぞれのユーザを設定する。
users.each { |username,user|
	group user[:group][:name] do
			append true
			gid user[:group][:gid]
			:create
	end

	user "#{node.adduser.user1.name}" do
			comment "#{node.adduser.user1.comment}"
			uid #{node.adduser.user1.uid}
			gid "#{node.adduser.user1.name}"
			home "/home/#{node.adduser.user1.name}"
			shell "#{node.adduser.user1.shell}"
			username "#{node.adduser.user1.name}"
	end

	if #{node.adduser.user1.addToWheel}
		group "wheel" do
				append true
				members "#{node.adduser.user1.name}"
				system true
				:modify
		end
	end

	directory "/home/#{node.adduser.user1.name}/.ssh/" do
		owner "#{node.adduser.user1.name}"
		group "#{node.adduser.user1.group.name}"
		mode "00755"
		action :create
	end

	# authorized_keysの中身を作成する
	begin
		c = File.read("/home/#{node.adduser.user1.name}/.ssh/authorized_keys")
		c += "\n"
	rescue
		c = ""
	end

	node[:adduser][:user1][:ssh_rsa].each do |ssh_key|
		c += ssh_key[1]
		c += "\n"
	end

	file "/home/#{node.adduser.user1.name}/.ssh/authorized_keys" do
			owner "#{node.adduser.user1.name}"
			group "#{node.adduser.user1.group.name}"
			mode "0600"
			content c
			action :create_if_missing
	end
}
