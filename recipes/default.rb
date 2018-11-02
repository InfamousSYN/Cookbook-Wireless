#
# Cookbook:: Cookbook-Wireless
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

cookbook_file 'ubuntu_beaver_sources.list' do
    path "/etc/apt/sources.list"
    action :create_if_missing
end

execute "[*] Downloading KALI repository signature file" do
    command "wget #{node[:general][:kali][:keyring][:href]}"
    action :nothing
end

execute "[*] Adding KALI repository signatures to local keyring" do
    command "dpkg -i #{node[:general][:kali][:keyring][:filename]}"

execute "[*] apt update" do
    command "apt-get update -y"
    ignore_failure true
    action :nothing
end

# Installs defined additional packages
node[:applications][:packages].each do |pkg|
    package "#{pkg}" do
        action :install
    end
end

# Install rogue toolkit
if node[:tool][:rogue][:enable]
    execute "[*] Downloading rogue toolkit" do
        cwd "#{node[:general][:location]}"
        command "git clone #{node[:tool][:rogue][:href]}"
    end
    
    execute "[*] Install rogue toolkit" do
        cwd "#{node[:general][:location]}#{node[:tool][:rogue][:location]}"
        command "python setup.py install"
        ignore_failure true
        action :nothing
    end
end

# Install wireless adaptor chipset
case node[:chipset]
when '8814au'
    execute "[*] Downloading RealTek 8814au Driver" do
        cwd "#{node[:general][:location]}"
        command "git clone #{node[:chipset][:rtl8814au][:href]}"
    end
when '8812au'
    execute "[*] Downloading RealTek 8812au Driver" do
        cwd "#{node[:general][:location]}"
        command "git clone #{node[:chipset][:rtl8812au][:href]}"
    end
end

node[:chipset][:dependencies].each do |pkg|
    package "#{pkg}" do
        action :install
    end
end

execute "[*] Compiling chipset" do
    cwd "#{node[:general][:location]}#{node[:chipset][:location]}"
    command "make"
end

execute "[*] Install chipset" do
    cwd "#{node[:general][:location]}#{node[:chipset][:location]}"
    command "make install"
end

# Install aircrack-ng
if node[:tool][:aircrack][:enable]
    node[:tool][:aircrack][:dependencies].each do |pkg|
        package "#{pkg}" do
            action :install
        end
    end

    execute "[*] Downloading aircrack-ng" do
        cwd "#{node[:general][:location]}"
        command "git clone #{node[:tool][:aircrack][:href]}"
    end

    execute "[*] Installing aircrack-ng" do
        cwd "#{node[:general][:location]}#{node[:tool][:aircrack][:location]}"
        command "autoreconf -i; ./configure; make; make install; ldconfig"
    end
end