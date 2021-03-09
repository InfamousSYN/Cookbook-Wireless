##
## Cookbook:: Cookbook-Wireless
## Recipe:: ubuntu
##
## Copyright:: 2018, The Authors, All Rights Reserved.
#

if node[:general][:ubuntu][:version] == "focal"
    cookbook_file "#{node[:general][:ubuntu][:focal][:sources]}" do
        path "/etc/apt/sources.list"
        sensitive true
        action :create
    end
elsif node[:general][:ubuntu][:version] == "bionic"
    cookbook_file "#{node[:general][:ubuntu][:bionic][:sources]}" do
        path "/etc/apt/sources.list"
        sensitive true
        action :create
    end
elsif node[:general][:ubuntu][:version] == "trusty"
    cookbook_file "#{node[:general][:ubuntu][:trusty][:sources]}" do
        path "/etc/apt/sources.list"
        sensitive true
        action :create
    end
end

execute "[*] Downloading KALI repository signature file" do
    command "wget #{node[:general][:kali][:keyring][:location]}"
    sensitive true
    action :run
end

execute "[*] Adding KALI repository signatures to local keyring" do
    command "sudo apt-key add #{node[:general][:kali][:keyring][:filename]}"
    sensitive true
    action :run
end

execute "[*] apt update do" do
    command "apt-get update -y --fix-broken --fix-missing"
    sensitive true
    action :run
end

# Installs defined additional packages
node[:general][:applications].each do |pkg|
    package "#{pkg}" do
        sensitive true
        action :install
    end
end