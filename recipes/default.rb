##
## Cookbook:: Cookbook-Wireless
## Recipe:: default
##
## Copyright:: 2018, The Authors, All Rights Reserved.
#

require "ohai"

if node["platform"] == "ubuntu"
    include_recipe '::ubuntu'
elsif node["platform"] == "kali"
    include_recipe '::kali'
end

if node[:general][:chipset][:enable]
    execute "[*] apt update do" do
        command "apt-get update -y"
        sensitive true
        action :run
    end

    node[:general][:chipset][:dependencies].each do |pkg|
        package "#{pkg}" do
            sensitive true
            action :install
        end
    end

    # Ensure headers for the current kernel are installed
    uname = Mixlib::ShellOut.new("uname -r")
    kernel = uname.run_command.stdout.chomp
    package "linux-headers-#{kernel}" do
        not_if { File.directory?("/usr/src/linux-headers-#{kernel}") }
        ignore_failure true
    end

    if node[:general][:chipset][:driver] == "apt"
        node[:general][:chipset][:apt][:realtek][:package].each do |pkg|
            package "#{pkg}" do
                sensitive true
                action :install
            end
        end

    elsif node[:general][:chipset][:driver] == "8814au"
    
        ## Install wireless adaptor chipset
        execute "[*] Downloading RealTek Driver" do
            cwd "#{node[:general][:directory]}"
            command "sudo git clone -b #{node[:general][:chipset][:branch]} #{node[:general][:chipset][:location]}"
            user "#{node[:general][:user]}"
            group "#{node[:general][:group]}"
            action :run
        end

        execute "[*] Install chipset" do
            cwd "#{node[:general][:directory]}#{node[:general][:chipset][:directory]}"
            command "sudo make; sudo make install"
            action :run
        end

    elsif node[:general][:chipset][:driver] == "8812au"
    
        ## Install wireless adaptor chipset
        execute "[*] Downloading RealTek Driver" do
            cwd "#{node[:general][:directory]}"
            command "sudo git clone -b #{node[:general][:chipset][:branch]} #{node[:general][:chipset][:location]}"
            user "#{node[:general][:user]}"
            group "#{node[:general][:group]}"
            action :run
        end

        execute "[*] Install chipset" do
            cwd "#{node[:general][:directory]}#{node[:general][:chipset][:directory]}"
            command "sudo make; sudo make install"
            action :run
        end
    end
end

## Install Desktop Environment
if node[:general][:gui][:enable]
    node[:general][:gui][:desktop].each do |pkg|
        package "#{pkg}" do
            action :install
        end
    end
end

## Install rogue toolkit
if node[:general][:tool][:rogue][:enable]
    execute "[*] Downloading rogue toolkit" do
        cwd "#{node[:general][:directory]}"
        command "sudo git clone #{node[:general][:tool][:rogue][:location]}"
        user "#{node[:general][:user]}"
        group "#{node[:general][:group]}"
        action :run
    end

    node[:general][:tool][:rogue][:dependencies].each do |pkg|
        package "#{pkg}" do
            sensitive true
            action :install
        end
    end

    execute "[*] Install rogue toolkit" do
        cwd "#{node[:general][:directory]}#{node[:general][:tool][:rogue][:directory]}"
        command "echo 'y' | sudo python3 install.py"
        user "#{node[:general][:user]}"
        group "#{node[:general][:group]}"
        action :run
    end
end


## Install aircrack-ng
if node[:general][:tool][:aircrack][:enable]
    execute "[*] Downloading aircrack-ng" do
        cwd "#{node[:general][:directory]}"
        command "sudo git clone #{node[:general][:tool][:aircrack][:location]}"
        user "#{node[:general][:user]}"
        group "#{node[:general][:group]}"
        action :run
    end

    node[:general][:tool][:aircrack][:dependencies].each do |pkg|
        package "#{pkg}" do
            sensitive true
            action :install
        end
    end

    execute "[*] Installing aircrack-ng" do
        cwd "#{node[:general][:directory]}#{node[:general][:tool][:aircrack][:directory]}"
        command "autoreconf -i; ./configure; make; make install; ldconfig"
        action :run
    end
end


## Install hcxtools
if node[:general][:tool][:hcxtools][:enable]
    execute "[*] Downloading hcxtools" do
        cwd "#{node[:general][:directory]}"
        command "sudo git clone #{node[:general][:tool][:hcxtools][:location]}"
        user "#{node[:general][:user]}"
        group "#{node[:general][:group]}"
        action :run
    end

    node[:general][:tool][:hcxtools][:dependencies].each do |pkg|
        package "#{pkg}" do
            sensitive true
            action :install
        end
    end

    execute "[*] Installing hcxtools" do
        cwd "#{node[:general][:directory]}#{node[:general][:tool][:hcxtools][:directory]}"
        command "make; make install"
        action :run
    end
end


## Install hcxdumptool
if node[:general][:tool][:hcxdumptool][:enable]
    execute "[*] Downloading hcxdumptool" do
        cwd "#{node[:general][:directory]}"
        command "sudo git clone #{node[:general][:tool][:hcxdumptool][:location]}"
        user "#{node[:general][:user]}"
        group "#{node[:general][:group]}"
        action :run
    end

    node[:general][:tool][:hcxdumptool][:dependencies].each do |pkg|
        package "#{pkg}" do
            sensitive true
            action :install
        end
    end

    execute "[*] Installing hcxdumptool" do
        cwd "#{node[:general][:directory]}#{node[:general][:tool][:hcxdumptool][:directory]}"
        command "make; make install"
        action :run
    end
end


## Install scapy
if node[:general][:tool][:scapy][:enable]
    node[:general][:tool][:scapy][:dependencies].each do |pkg|
        package "#{pkg}" do
            sensitive true
            action :install
        end
    end

    execute "[*] Installing scapy" do
        command "pip3 install #{node[:general][:tool][:scapy][:package]}"
        action :run
    end
end
