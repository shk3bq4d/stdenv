rclone config file # print configuration file that would be used
RCLONE_CONFIG=/root/rclonecustom.cfg rclone config file
       • rclone  config create (https://rclone.org/commands/rclone_config_create/) - Create a new re‐ mote with name, type and options.
       • rclone config delete (https://rclone.org/commands/rclone_config_delete/) - Delete an  exist‐ ing remote.
       • rclone  config  disconnect (https://rclone.org/commands/rclone_config_disconnect/) - Discon‐ nects user from remote
       • rclone config dump (https://rclone.org/commands/rclone_config_dump/) - Dump the config  file as JSON.
       • rclone config file (https://rclone.org/commands/rclone_config_file/) - Show path of configu‐ ration file in use.
       • rclone config password (https://rclone.org/commands/rclone_config_password/) - Update  pass‐ word in an existing remote.
       • rclone config paths (https://rclone.org/commands/rclone_config_paths/) - Show paths used for configuration, cache, temp etc.
       • rclone config providers  (https://rclone.org/commands/rclone_config_providers/)  -  List  in JSON format all the providers and options.
       • rclone  config reconnect (https://rclone.org/commands/rclone_config_reconnect/) - Re-authen‐ ticates user with remote.
       • rclone config show  (https://rclone.org/commands/rclone_config_show/)  -  Print  (decrypted) config file, or the config for a single remote.
       • rclone  config  touch (https://rclone.org/commands/rclone_config_touch/) - Ensure configura‐ tion file exists.
       • rclone config update (https://rclone.org/commands/rclone_config_update/) - Update options in an existing remote.
       • rclone  config  userinfo (https://rclone.org/commands/rclone_config_userinfo/) - Prints info about logged in user of remote.

rclone --config "$rclone_cfg_file" --progress delete --rmdirs --files-from - "$RCLONE_PROFILE_NAME:$bucketname" < "$bucketfile"
rclone --config "$rclone_cfg_file" --progress purge "$RCLONE_PROFILE_NAME:$line"

* https://rclone.org/commands/rclone_check/
rclone check source:path dest:path [flags]

* https://rclone.org/commands/rclone_sync/:w
rclone sync source:path dest:path --ignore-existing
  -n, --dry-run         Do a trial run with no permanent changes
  -i, --interactive     Enable interactive mode
  -v, --verbose count   Print lots more stuff (repeat for more)

      --backup-dir string               Make backups into hierarchy based in DIR
      --delete-after                    When synchronizing, delete files on destination after transferring (default)
      --delete-before                   When synchronizing, delete files on destination before transferring
      --delete-during                   When synchronizing, delete files during transfer
      --fix-case                        Force rename of case insensitive dest to match source
      --ignore-errors                   Delete even if there are I/O errors
      --list-cutoff int                 To save memory, sort directory listings on disk above this threshold (default 1000000)
      --max-delete int                  When synchronizing, limit the number of deletes (default -1)
      --max-delete-size SizeSuffix      When synchronizing, limit the total size of deletes (default off)
      --suffix string                   Suffix to add to changed files
      --suffix-keep-extension           Preserve the extension when using --suffix
      --track-renames                   When synchronizing, track file renames and do a server-side move if possible
      --track-renames-strategy string   Strategies to use when synchronizing using track-renames hash|modtime|leaf (default "hash")


[myconnection]
access_key_id = XXXXXXXXXXXXXXXXXXXX
secret_access_key = YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
endpoint = https://myparadise.broadway.local
type = s3
provider = Other
env_auth = true
