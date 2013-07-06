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

#	user "#{node.adduser.user1.name}" do
	user user[:name] do
		comment user[:comment]
		uid user[:uid]
		gid user[:name]
		home "/home/" + user[:name]
		shell user[:shell]
		username user[:name]
	end

	if user[:addToWheel]
		group "wheel" do
			append true
			members user[:name]
			system true
			:modify
		end
	end

	directory "/home/" + user[:name] + "/.ssh/" do
		owner user[:name]
		group user[:group][:name]
		mode "00755"
		action :create
	end

	# authorized_keysの中身を作成する
	begin
		c = File.read("/home/" + user[:name] + "/.ssh/authorized_keys")
		c += "\n"
	rescue
		c = ""
	end

	node[:adduser][:user1][:ssh_rsa].each do |ssh_key|
		c += ssh_key[1]
		c += "\n"
	end

	file "/home/" + user[:name] + "/.ssh/authorized_keys" do
			owner user[:name]
			group user[:group][:name]
			mode "0600"
			content c
			action :create_if_missing
	end
}
