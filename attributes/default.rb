#
## 
##
#

## General Attributes
default["general"]["cookbook"]["name"] = "Cookbook-Wireless"
default["general"]["user"] = "vagrant"
default["general"]["group"] = "vagrant"
default["general"]["directory"] = "/opt"
default["general"]["ubuntu"]["beaver"]["sources"] = "ubuntu_beaver_sources.list"
default["general"]["kali"]["keyring"]["location"] = "https://archive.kali.org/archive-key.asc"
default["general"]["kali"]["keyring"]["filename"] = "archive-key.asc"
default["general"]["applications"] = ["ubuntu-desktop", "git", "wireshark", "python", "python-pip","wireless-tools"]

## Adaptor Chipset Attributes
default["general"]["chipset"]["enable"] = true
default["general"]["chipset"]["driver"] = "apt"
default["general"]["chipset"]["dependencies"] = ["dkms", "build-essential", "bc", "libelf-dev"]
case node["general"]["chipset"]["driver"]
when "8814au"
    default["general"]["chipset"]["location"] = "https://github.com/aircrack-ng/rtl8814au.git"
    default["general"]["chipset"]["branch"] = "v5.8.5.1"
    default["general"]["chipset"]["directory"] = "/rtl8814au"
when "8812au"
    default["general"]["chipset"]["location"] = "https://github.com/aircrack-ng/rtl8812au.git"
    default["general"]["chipset"]["branch"] = "v5.3.4"
    default["general"]["chipset"]["directory"] = "/rtl8812au"
when "apt"
    default["general"]["chipset"]["apt"]["realtek"]["package"] = "realtek-rtl88xxau-dkms"
end

## Tool Attributes
default["general"]["tool"]["rogue"]["enable"] = true
default["general"]["tool"]["rogue"]["location"] = "https://github.com/InfamousSYN/rogue.git"
default["general"]["tool"]["rogue"]["directory"] = "/rogue"

default["general"]["tool"]["eapeak"]["enable"] = false
default["general"]["tool"]["eapeak"]["location"] = "https://github.com/securestate/eapeak.git"
default["general"]["tool"]["eapeak"]["dependencies"] = []
default["general"]["tool"]["eapeak"]["directory"] = "/eapeak"

default["general"]["tool"]["aircrack"]["enable"] = true
default["general"]["tool"]["aircrack"]["location"] = "https://github.com/aircrack-ng/aircrack-ng.git"
default["general"]["tool"]["aircrack"]["dependencies"] = ["build-essential", "autoconf", "automake", "libtool", "pkg-config", "libnl-3-dev", "libnl-genl-3-dev", "libssl-dev", "ethtool", "shtool", "rfkill", "zlib1g-dev", "libpcap-dev", "libsqlite3-dev", "libpcre3-dev", "libhwloc-dev", "libcmocka-dev", "hostapd", "wpasupplicant", "tcpdump", "screen", "iw", "usbutils"]
default["general"]["tool"]["aircrack"]["directory"] = "/aircrack-ng"

default['general']['tool']['hcxtools']["enable"] = true
default['general']['tool']['hcxtools']["location"] = "https://github.com/ZerBea/hcxtools.git"
default['general']['tool']['hcxtools']["dependencies"] = ["libcurl4-openssl-dev", "libssl-dev", "zlib1g-dev", "libpcap-dev"]
default['general']['tool']['hcxtools']["directory"] = "/hcxtools"

default['general']['tool']['hcxdumptool']["enable"] = true
default['general']['tool']['hcxdumptool']["location"] = "https://github.com/ZerBea/hcxdumptool.git"
default['general']['tool']['hcxdumptool']["directory"] = "/hcxdumptool"
default['general']['tool']['hcxdumptool']["dependencies"] = ["libcurl4-openssl-dev", "libssl-dev", "pkg-config"]

default['general']['tool']['scapy']['enable'] = true
default['general']['tool']['scapy']['package'] = "scapy-python3"
default["general"]["tool"]["scapy"]["dependencies"] = ["python3-pip"]