{
  users = {
    groups = {
      cicd = { };
    };
    users.cicd = {
      isNormalUser = true;
      group = "cicd";
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        # Chave usada pelo CI/CD do repositório
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDc+1szMFxfrqA99yx50tlqjzWFe4Em+gF+0A+u5VKZXJWdDTtd46KyU4oGmqDoz6Cvq2dHaY6yGrlX/5/glAsfJKcPWpjuBCaSjDyQ750TeQTrXGJ992x+LHaJtP59XCYfpVWF/aRsRroyxyl/3cNwTiB1MareHYEWPzVA2F1XOR+vzaxTMUJisdQ9LBKp4moG9gsyvXvrNvjL1A/mwASqpzbrpK9UVwH1F2KSv3Pj7qMsnDJ3ZWcprUgCst/7kcQm70HXbAE2GbGvguXIA+IIx6ML8A1WYdyzyZXbqQJLRIoegJkkFebVUw0laSVfEd2rHZHDXtu5SBWuKBzoO57cyaLjkIx5OoIepsZ5c0imhyTnyJHuQv79xDpil5bxHH/eiG8YiLrccRV776YTudu/IbAyHxdAM986KyqteyWgjatQHnAcOuEl6qSi3Y4u6qGJMSZ229sux4VmEGZaJqxGLlhsw76+7Ra2sZXhZzozj+rbgfYVLt6GffHiXKUKq1s= (none)"
      ];
    };
  };
}

