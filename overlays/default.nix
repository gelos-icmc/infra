{ pkgs, input, output, ... }:

{
  modifications = final: prev: {
    mtprotoproxy = prev.mtprotoproxy.overrideAttrs (oldAttrs: {
      src = final.fetchFromGitHub {
        owner = "alexbers";
        repo = "mtprotoproxy";
        rev = "v1.1.1";
        sha256 = "";
      };
    });
  };

}
