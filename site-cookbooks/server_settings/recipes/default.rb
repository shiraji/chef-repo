#
# Cookbook Name:: server_settings
# Recipe:: default
#
# Copyright 21., YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# テンプレートからi18nの設定をする
template "/etc/sysconfig/i18n" do
	path "/etc/sysconfig/i18n"
	source "i18n.erb"
	mode "0644"
	:create
end

# テンプレートからsudoersの設定する
template "/etc/sudoers" do
	path "/etc/sudoers"
	source "sudoers.erb"
	mode "0440"
	:create
end

#テンプレートからsshの設定をする
template "/etc/ssh/sshd_config" do
	path "/etc/ssh/sshd_config"
	source "sshd_config.erb"
	mode "0600"
	:create
end

#テンプレートからsuの設定をする
template "/etc/pam.d/su" do
	path "/etc/pam.d/su"
	source "su.erb"
	mode "0644"
	:create
end

# sshdをリスタート
service "sshd" do
	action :restart
end

#yumでパッケージのインストール
%w( screen zsh iptables tmux ).each do |name|
	package name do
		action :install
	end
end

#テンプレートからiptablesの設定を作成する
template "/etc/sysconfig/iptables" do
	path "/etc/sysconfig/iptables"
	source "iptables.erb"
	mode "0644"
	:create
end
