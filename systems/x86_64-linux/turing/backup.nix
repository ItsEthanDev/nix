{
  services.restic.backups.r2 = {
    repository = "s3:https://7be572932f308ef922603015d775fdd2.r2.cloudflarestorage.com/backup/turing";
    environmentFile = "/etc/restic/r2.env";
    passwordFile = "/etc/restic/password";

    paths = [
      "/home/ethan/Pictures/Screenshots"
      "/home/ethan/Documents"
    ];
    exclude = [];

    extraOptions = [
      "s3.bucket-lookup=path"
    ];

    timerConfig = {
      OnCalendar = "*-*-* 03:00:00";
      RandomizedDelaySec = "1h";
      Persistent = true;
    };

    pruneOpts = [
      "--keep-daily 14"
      "--keep-weekly 8"
      "--keep-monthly 12"
      "--keep-yearly 3"
    ];

    inhibitsSleep = true;
    initialize = true;
  };
}
