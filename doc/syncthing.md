https://itunes.apple.com/us/app/fsync/id964427882?mt=8
https://docs.syncthing.net/users/config.html
https://play.google.com/store/apps/details?id=com.nutomic.syncthingandroid&hl=en
18:06:38 38  root jsyncthing /var/db/syncthing
$ vi config.xml

New packages to be INSTALLED:
	syncthing: 0.14.17

	Number of packages to be installed: 1

	The process will require 13 MiB more space.
	4 MiB to be downloaded.

	Proceed with this action? [y/N]: y
	[jsyncthing] Fetching syncthing-0.14.17.txz: 100%    4 MiB   1.3MB/s    00:03    
	Checking integrity... done (0 conflicting)
	[jsyncthing] [1/1] Installing syncthing-0.14.17...
	===> Creating groups.
	Creating group 'syncthing' with gid '983'.
	===> Creating users
	Creating user 'syncthing' with uid '983'.
	[jsyncthing] [1/1] Extracting syncthing-0.14.17: 100%
	Message from syncthing-0.14.17:
	WARNING: This version is not backwards compatible with 0.13.x, 0.12.x, 0.11.x
	nor 0.10.x releases!

	For more information, please read:

	https://forum.syncthing.net/t/syncthing-v0-14-0/7806
https://github.com/syncthing/syncthing/releases/tag/v0.13.0
https://forum.syncthing.net/t/syncthing-v0-11-0-release-notes/2426
https://forum.syncthing.net/t/syncthing-syncthing-v0-12-0-beryllium-bedbug/6026
