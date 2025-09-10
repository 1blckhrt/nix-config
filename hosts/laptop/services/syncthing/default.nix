{
  services.syncthing = {
    tray.enable = true;
    enable = true;
    guiAddress = "0.0.0.0:8384";
    settings = {
      devices = {
        "raspberrypi" = {
          id = "ZGRMODU-GERM4MG-43OA7BQ-SDOSCBT-BWH56PC-VMNOACR-HEXNXYE-3OMHCAM";
        };
        "pc-windows" = {
          id = "E7IROJ2-MTLKCQZ-762BVEP-RX2RW2V-TAMCH5D-H46FETR-FLIUCOK-WNWVMQI";
        };
      };

      folders = {
        "notes" = {
          path = "~/Documents/Notes/";
          devices = ["raspberrypi" "pc-windows"];
          versioning = {
            type = "simple";
          };
          type = "sendonly";
        };

        "ebooks" = {
          path = "~/Documents/syncthing_dir/ebooks/";
          devices = ["raspberrypi" "pc-windows"];
          versioning = {
            type = "simple";
          };
          type = "receiveonly";
        };

        "school" = {
          path = "~/Documents/syncthing_dir/school/";
          devices = ["raspberrypi" "pc-windows"];
          versioning = {
            type = "simple";
          };
          type = "sendreceive";
        };
      };
    };
  };
}
