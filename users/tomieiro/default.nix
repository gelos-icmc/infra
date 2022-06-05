{ pkgs, ... }:
{
  users.users.tomieiro = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQ8oHI3sHlnQbcqX8JcEL79N5TbPRbPesBGYaDYU+an+ZkHIoYzy7aTWM/26NY8jdCNE72xMRkVhgD1sVMR0UL/E9EiFOefekd/Kbml1QHWEdnQAoLBWz9UgA378e3udI914rPltuzlhddr4gHruTcm4c94cpkmPjnMPpHC9be/NjjevUetV5z8aKKGJeC56BX0+2sbSG82kdlTr8SrEaqdevP5oB+j6BiHMdQe4L9S+X2VhjdOWOOIl3gw3n82XwAXzDgWmQFTMrZiU8PNV3lT5TClLh3dz1UU70YwJinapllb12/lA5HFC/sXBgwGaKMM4qQhQ4O+4LFc/XSiRQ0nt4WtnVocBpJtL0X0aQGtIPQ8hCkUKN6IaownCnD9lEA6y3DCjHalTEogpAd+z2wD1Uc1rDxJ4jJPSEDErz+5d/ELT8XQkf6uhmsMt6BHAG2TnphicDCD9e4LrIkf17Jg7iI6fx3Q/iAslt6Ytphpb981YEREx0coToBqzQGewjJ51xsheoLchxndVrAD/2kBiWwcDZME0kI0nR+qsXmFb4ueysqojVqdtumKG+FyfWnYtR3EAzKwxHtpG+mf2693uNcq983RNzdQ1fq5arMQHrpnRDKSS3zdTba7NaavpP4z657ZQnHvlBTx1xVbPKI9BuHEUIF4T905XHXgKiaEw== tomieiro@tars"
    ];
    initialHashedPassword = "$6$3N3DlmrWd377yPfN$bsAA1hdAFhjeWVrtdRvG8c55Y2TVLjWzv2UaNZAB2owMjRV2wb8iVAJmPBnnGrA8QbFRz.R.PoYapDF3B3Z931";
  };
}
