{ pkgs, ... }:
{
  users = {
    mutableUsers = false;
    groups = {
      cicd = { };
    };
    users = {
      cicd = {
        isNormalUser = true;
        group = "cicd";
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [
          # Chave usada pelo CI/CD do repositório
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDc+1szMFxfrqA99yx50tlqjzWFe4Em+gF+0A+u5VKZXJWdDTtd46KyU4oGmqDoz6Cvq2dHaY6yGrlX/5/glAsfJKcPWpjuBCaSjDyQ750TeQTrXGJ992x+LHaJtP59XCYfpVWF/aRsRroyxyl/3cNwTiB1MareHYEWPzVA2F1XOR+vzaxTMUJisdQ9LBKp4moG9gsyvXvrNvjL1A/mwASqpzbrpK9UVwH1F2KSv3Pj7qMsnDJ3ZWcprUgCst/7kcQm70HXbAE2GbGvguXIA+IIx6ML8A1WYdyzyZXbqQJLRIoegJkkFebVUw0laSVfEd2rHZHDXtu5SBWuKBzoO57cyaLjkIx5OoIepsZ5c0imhyTnyJHuQv79xDpil5bxHH/eiG8YiLrccRV776YTudu/IbAyHxdAM986KyqteyWgjatQHnAcOuEl6qSi3Y4u6qGJMSZ229sux4VmEGZaJqxGLlhsw76+7Ra2sZXhZzozj+rbgfYVLt6GffHiXKUKq1s= (none)"
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
      tomieiro = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQ8oHI3sHlnQbcqX8JcEL79N5TbPRbPesBGYaDYU+an+ZkHIoYzy7aTWM/26NY8jdCNE72xMRkVhgD1sVMR0UL/E9EiFOefekd/Kbml1QHWEdnQAoLBWz9UgA378e3udI914rPltuzlhddr4gHruTcm4c94cpkmPjnMPpHC9be/NjjevUetV5z8aKKGJeC56BX0+2sbSG82kdlTr8SrEaqdevP5oB+j6BiHMdQe4L9S+X2VhjdOWOOIl3gw3n82XwAXzDgWmQFTMrZiU8PNV3lT5TClLh3dz1UU70YwJinapllb12/lA5HFC/sXBgwGaKMM4qQhQ4O+4LFc/XSiRQ0nt4WtnVocBpJtL0X0aQGtIPQ8hCkUKN6IaownCnD9lEA6y3DCjHalTEogpAd+z2wD1Uc1rDxJ4jJPSEDErz+5d/ELT8XQkf6uhmsMt6BHAG2TnphicDCD9e4LrIkf17Jg7iI6fx3Q/iAslt6Ytphpb981YEREx0coToBqzQGewjJ51xsheoLchxndVrAD/2kBiWwcDZME0kI0nR+qsXmFb4ueysqojVqdtumKG+FyfWnYtR3EAzKwxHtpG+mf2693uNcq983RNzdQ1fq5arMQHrpnRDKSS3zdTba7NaavpP4z657ZQnHvlBTx1xVbPKI9BuHEUIF4T905XHXgKiaEw== tomieiro@tars"
        ];
        initialHashedPassword = "$6$3N3DlmrWd377yPfN$bsAA1hdAFhjeWVrtdRvG8c55Y2TVLjWzv2UaNZAB2owMjRV2wb8iVAJmPBnnGrA8QbFRz.R.PoYapDF3B3Z931";
      };
      trents = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
        ];
        initialHashedPassword = "$6$2EcxpAdz$RBdfvHZSOFQ8La5cjH2IrYGWqHamx8yWTZfRUPRM/nYe/JWNIlwFzTyr09MMqNDitN.8eiPjM/XieiSWxld951";
      };

    };
  };

  security.pam.services.swaylock = { };
}
