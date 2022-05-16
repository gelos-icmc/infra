{ pkgs, ... }:
{
  users = {
    mutableUsers = false;
    groups = {
      cicd = {};
    };
    users = {
      cicd = {
        isSystemUser = true;
        group = "cicd";
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
          # Chave usada pelo CI/CD do repositório
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCY29GorzWKT0KdtQfxdCd9Ceq72TTiJgJwsYHdHDARwZOs5P5/OqKuMYakNaPW2Hsl+KUtOzcaBIp+OiMQwLDFgyhAZdlXnk7bXAC6H/q9lzem25zSMTtjAyxm5XBLbcNbJ4IVntcAl8vWGuPBPCZVoDPgfQcKEILCMef+lJcIq7AIuqdl/hK4DXG79ufKtudsEwUFG9xuLDzhfjt8syJX+A+RJ1D4zLj4L8gBjeGC/l3R3GLg8/QWj4epMD6y6n4c+e0rxhDrkF6Rrl1xLsEs66TLaRoLt4Xz7dgbrXQ+DU8KbmPUF9UTe2nQQNHa7cpUhdODNM+cKcgDxNi9DTWK/8Nnyyl10w+wAr7mz0fwYo+jHKgU7FUzJktbCEUIcqaj9kYTKDObBJLev4IiOCRkc2rxZsQHUH9fetnC7rS+s+HF3tW0nQW08+9j1u6uMZVRC6K9f30YTVjYr9KZpNwNJNybVCXZMyuJjfY9jhNisW/W5J3YDYP5CQlKgx2NX3s= (none)"
        ];
      };
      misterio = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDci4wJghnRRSqQuX1z2xeaUR+p/muKzac0jw0mgpXE2T/3iVlMJJ3UXJ+tIbySP6ezt0GVmzejNOvUarPAm0tOcW6W0Ejys2Tj+HBRU19rcnUtf4vsKk8r5PW5MnwS8DqZonP5eEbhW2OrX5ZsVyDT+Bqrf39p3kOyWYLXT2wA7y928g8FcXOZjwjTaWGWtA+BxAvbJgXhU9cl/y45kF69rfmc3uOQmeXpKNyOlTk6ipSrOfJkcHgNFFeLnxhJ7rYxpoXnxbObGhaNqn7gc5mt+ek+fwFzZ8j6QSKFsPr0NzwTFG80IbyiyrnC/MeRNh7SQFPAESIEP8LK3PoNx2l1M+MjCQXsb4oIG2oYYMRa2yx8qZ3npUOzMYOkJFY1uI/UEE/j/PlQSzMHfpmWus4o2sijfr8OmVPGeoU/UnVPyINqHhyAd1d3Iji3y3LMVemHtp5wVcuswABC7IRVVKZYrMCXMiycY5n00ch6XTaXBwCY00y8B3Mzkd7Ofq98YHc= (none)"
        ];
        initialHashedPassword = "$6$fnbBbCL/wekkRmDT$1nuI5INngjusDL5aAn4hqcmBXIbtEhi35J9FpI05AH4eTON9cOVZu8AgpPJJ/69uYICF.CQBkjcU/4Hi64v0E/";
      };
      gui = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdOHcubB0bj8deVZ6P2KmuaqD9Le1mLykg1os69q5LLvmbBDtftVIcm7i/EROWU7/GyySW7rzTyGthhviHnKWbHJKyfgKcoOHc7Bxze4g2/72pxwi/bnG9xIf0GWeBx7Of+0JYGHEvEF1VcgIZKti22ENI+h3Oi/zTpY4Z+CSexU4Vz/T7uxZyd7TgLT3uxWdIAU26UfakEMUvewG1FKIPsYEHjNVTvHNx9kNq6KigNAUy1qClGKQybSSbr30KN/q82/kaYp2QjhUgGaPMs9mPriszVvxsCb5t6LXtPjTYTCcUYvLsZIVOhXqmKLD2Eku0kmU+26tVISjhmwVF2CwjB3EdLVlXEbvrBAxRQWa63ZMu85OZMCKQAgA43LYKX4pWgVcGVZQBqQyCR8sw5jrNn48ngJO1AKFQpHQjcEgKpbYdegm5vN/xq8M1a2rnklECb378pemXMi8sevjVwGkU0E+D8NO62zO3L98n8DDn3cF14aWObl3zqLF+bM3UPhM= gui@fedora"
        ];
        initialHashedPassword = "$6$ZYiq1thrnsCTy8P4$.flnn.d.Dg/VCno5Zwfhf/.WwNyBsv3e4PRGXDag4JwAMtFoKq6rLlDPxLuNWcMt4qLfMggfJWV.isLTDMwcY/";
      };
      julio = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        initialHashedPassword = "$6$qROdxayoF6BexsPV$asDqTdzuqIoKXE6GPGb9tBqB7F8gV8TCwPP3KdXitnj9GfIE0gx24zi7ZR064eikj.TT/47R/Vg5s6I55zQ8V/";
      };
      setembru = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
        initialHashedPassword = "$y$j9T$xLjyGIL9uXlnEvmrf8kJa/$82VTere29qcOesmuTFVbw0efNVpK0xMc9a30gCjW9l8";
      };
    };
  };

  security.pam.services.swaylock = { };
}
