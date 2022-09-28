{
  description = "Dream2nix auto-generated php packages";

  inputs = {
    dream2nix.url = "github:tinybeachthor/dream2nix/main";
  };

  outputs = { self, dream2nix }:
    dream2nix.lib.makeFlakeOutputsForIndexes {
      systems = ["x86_64-linux"];
      source = ./.;
      indexes = {
        libraries-io = {
          platform = "packagist";
          number = 2500;
        };
      };
    };
}
