# Cookbook-Wireless
A CHEF cookbook used to provision my Vagrant boxes for wireless penetration. This cookbook's target OS is Ubuntu 18.04 (Bionic Beaver) x86_64, this is due to personal experience with testing wireless networks using Realtek 88XXau devices and issues with rolling Kali support.

## Usage
Download the repository into target directory.

```git clone https://github.com/InfamousSYN/Cookbook-Wireless.git```

Copy the example Vagrantfile file from the Cookbook's examples directory into the target directory.

```cp Cookbook-Wireless/examples/Vagrantfile .```

The example Vagrantfile has an override json command to configure the `["general"]["chipset"]["driver"]` attribute variable at runtime. The user can change this value from `8814au` to `8812au` as required by their hardware needs.
```
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ["../../Development/Repositories/"]
    chef.add_recipe "Cookbook-Wireless"
    chef.json = {
      "general" => {
        "chipset" => {
          "driver" => "apt"
        },
        "tool" => {
          "eapeak" => {
            "enable" => false
          },
          "rogue" => {
            "enable" => true
          },
          "aircrack" => {
            "enable" => false
          },
          "hcxtools" => {
            "enable" => false
          },
          "hcxdumptool" => {
            "enable" => false
          },
          "scapy" => {
            "enable" => false
          }
        }
      }
    }
  end
```

Launch the Vagrant box

```vagrant up```
