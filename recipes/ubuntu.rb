##
## Cookbook:: Cookbook-Wireless
## Recipe:: ubuntu
##
## Copyright:: 2018, The Authors, All Rights Reserved.
#

cookbook_file 'ubuntu_beaver_sources.list' do
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

execute "[*] apt update" do
    command "apt-get update -y"
    ignore_failure true
    action :run
end