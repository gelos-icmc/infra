{ pkgs, ... }:
{
  users = {
    mutableUsers = false;
    users = {
      misterio = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
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
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdOHcubB0bj8deVZ6P2KmuaqD9Le1mLykg1os69q5LLvmbBDtftVIcm7i/EROWU7/GyySW7rzTyGthhviHnKWbHJKyfgKcoOHc7Bxze4g2/72pxwi/bnG9xIf0GWeBx7Of+0JYGHEvEF1VcgIZKti22ENI+h3Oi/zTpY4Z+CSexU4Vz/T7uxZyd7TgLT3uxWdIAU26UfakEMUvewG1FKIPsYEHjNVTvHNx9kNq6KigNAUy1qClGKQybSSbr30KN/q82/kaYp2QjhUgGaPMs9mPriszVvxsCb5t6LXtPjTYTCcUYvLsZIVOhXqmKLD2Eku0kmU+26tVISjhmwVF2CwjB3EdLVlXEbvrBAxRQWa63ZMu85OZMCKQAgA43LYKX4pWgVcGVZQBqQyCR8sw5jrNn48ngJO1AKFQpHQjcEgKpbYdegm5vN/xq8M1a2rnklECb378pemXMi8sevjVwGkU0E+D8NO62zO3L98n8DDn3cF14aWObl3zqLF+bM3UPhM= gui@fedora"
        ];
        initialHashedPassword = "$6$ZYiq1thrnsCTy8P4$.flnn.d.Dg/VCno5Zwfhf/.WwNyBsv3e4PRGXDag4JwAMtFoKq6rLlDPxLuNWcMt4qLfMggfJWV.isLTDMwcY/;"
      };
      julio = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
        initialPassword = "";
      };
    };
  };

  security.pam.services.swaylock = { };
}
