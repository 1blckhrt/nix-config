{pkgs, ...}: {
  programs.autorandr = {
    enable = true;

    profiles = {
      "usb-adapter" = {
        fingerprint = {
          "DVI-I-1-1" = "00ffffffffffff000469a420d67f00000e140103682c19782aee91a3544c99260f5054bfee00714fa9c0010101010101010101010101302a40c86084643018501300bbf91000001e000000ff0041344c4d54463033323732360a000000fd00374b1e5510000a202020202020000000fc00415355532056483230320a20200039";
          "DVI-I-2-2" = "00ffffffffffff004e14ab09010000002a1f0103b4351d7828ee91a3544c99260f505421090031404540614081c081809500b300454f023a801871382d40582c450012222100001e000000fd00304b1e5514000a202020202020000000ff0030303030303030303030303031000000fc0053636570747265204632340a2001c1020325f147901f0413030105230907078301000067030c0010001828681a00000101304be6504480a0703829403020350000000000001e7f2156aa51001e30468f330000000000001ed12640a0608429303020350000000000001e100e20e0305819201848120000000000001e78132018315829203020350000000000001e3b";
          "eDP-1" = "00ffffffffffff0030e4c70600000000001f0104a52213780338d5975e598e271c505400000001010101010101010101010101010101293680a070381f403020350058c21000001a1b2480a070381f403020350058c21000001a00000000000000000000000000000000000000000002000c3dff0a3c7d1514297d0000000072";
        };

        config = {
          "DVI-I-2-2" = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            position = "0x0";
          };
          "DVI-I-1-1" = {
            enable = true;
            mode = "1600x900";
            position = "1920x0"; # right of primary
          };
          "eDP-1" = {
            enable = false;
          };
        };
      };

      "laptop" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0030e4c70600000000001f0104a52213780338d5975e598e271c505400000001010101010101010101010101010101293680a070381f403020350058c21000001a1b2480a070381f403020350058c21000001a00000000000000000000000000000000000000000002000c3dff0a3c7d1514297d0000000072";
        };

        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            position = "0x0";
          };
          "DVI-I-2-2" = {
            enable = false;
          };
          "DVI-I-1-1" = {
            enable = false;
          };
        };
      };
    };

    hooks = {
      preswitch = {
        notify = ''
          ${pkgs.libnotify}/bin/notify-send "Changing monitor layout in 5 seconds..."
          sleep 5
        '';
      };
      postswitch = {
        notify = ''
          ${pkgs.libnotify}/bin/notify-send "Monitor layout changed"
        '';
        restart-i3 = ''
          ${pkgs.i3}/bin/i3-msg restart
        '';
      };
    };
  };
}
