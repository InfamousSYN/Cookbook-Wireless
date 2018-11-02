# Cookbook-Wireless
A CHEF cookbook used to provision my Vagrant boxes for wireless penetration. This cookbook's target OS is Ubuntu 18.04 (Bionic Beaver) x86_64 due to personal experience with testing wireless networks using Realtek 88XXau devices.

## Usage
The example Vagrantfile has an override json command to configure the `default["general"]["chipset"]` attribute variable at runtime. The user can change this value from `8814au` to `8812au` as required by their hardware needs.
```
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ["../../Development/Repositories/"]
    chef.add_recipe "Cookbook-Wireless"
    chef.json = {
      "general" => {
        "chipset" => "8814au"
      }
    }
  end
```