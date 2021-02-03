##
## Cookbook:: Cookbook-Wireless
## Recipe:: ubuntu
##
## Copyright:: 2018, The Authors, All Rights Reserved.
#

cookbook_file 'ubuntu_focal_sources.list' do
    path "/etc/apt/sources.list"
    action :create
end

execute "[*] Downloading KALI repository signature file" do
    command "wget #{node[:general][:kali][:keyring][:location]}"
    action :run
end

execute "[*] Adding KALI repository signatures to local keyring" do
    command "sudo apt-key add #{node[:general][:kali][:keyring][:filename]}"
    action :run
end

apt_update

# Installs defined additional packages
node[:general][:applications].each do |pkg|
    package "#{pkg}" do
        action :install
    end
end