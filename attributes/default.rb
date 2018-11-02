#
## 
##
#

## General Attributes
default['general']['user'] = 'vagrant'
default['general']['group'] = 'vagrant'
default['general']['location'] = '/opt'
default['general']['ubuntu']['beaver']['sources'] = 'ubuntu_beaver_sources.list'
default['general']['kali']['keyring']['href'] = 'https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2018.1_all.deb'
default['general']['kali']['keyring']['filename'] = 'kali-archive-keyring_2018.1_all.deb'
default['general']['applications'] = ['git', 'wireshark']

## Adaptor Chipset Attributes
default['chipset'] = '8814au'
default['chipset']['rtl8814au']['href'] = 'https://github.com/aircrack-ng/rtl8812au/tree/v5.3.4'
default['chipset']['rtl8812au']['href'] = 'https://github.com/aircrack-ng/rtl8812au/tree/v5.1.5'
default['chipset']['dependencies'] = ['dkms', 'build-essential', 'bc', 'libelf-dev']
default['chipset']['location'] = '/rtl8812au'


## Tool Attributes
default['tool']['rogue']['enable'] = true
default['tool']['rogue']['href'] = 'https://github.com/InfamousSYN/rogue'
default['tool']['rogue']['location'] = '/rogue'

default['tool']['eapeak']['enable'] = false
default['tool']['eapeak']['href'] = 'https://github.com/securestate/eapeak'
default['tool']['eapeak']['dependencies'] = []
default['tool']['eapeak']['location'] = '/eapeak'

default['tool']['aircrack']['enable'] = true
default['tool']['aircrack']['href'] = 'https://github.com/aircrack-ng/aircrack-ng'
default['tool']['aircrack']['dependencies'] = ['build-essential', 'autoconf', 'automake', 'libtool', 'pkg-config', 'libnl-3-dev', 'libnl-genl-3-dev', 'libssl-dev', 'ethtool', 'shtool', 'rfkill', 'zlib1g-dev', 'libpcap-dev', 'libsqlite3-dev', 'libpcre3-dev', 'libhwloc-dev', 'libcmocka-dev']
default['tool']['aircrack']['location'] = '/aircrack-ng'