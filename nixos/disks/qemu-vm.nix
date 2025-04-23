{ lib, ... }:

{ disko.devices = {
  disk.main = {
    type = "disk";
    device = "/dev/vda";

    content = {
      type = "gpt";
      partitions = {
        boot = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot/efi";
          };
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
            extraArgs = [ "-L" "disk-main-root" ];
          };
        };
      };
    };
  };
}; 

# Zorg ervoor dat de EFI-partitie wordt gemount
fileSystems."/boot/efi".device = lib.mkForce "/dev/vda1";

}
