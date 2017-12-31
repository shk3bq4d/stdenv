sudo vi /etc/default/grub && sudo update-grub

#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash int>
GRUB_CMDLINE_LINUX_DEFAULT="intel_iommu=on"
GRUB_CMDLINE_LINUX=""


# ubuntu bash
select Ubuntu option
e
goto almost last line (one that starts with linux) and add init=/bin/bash
<F10>

# CentOS 7
Click [View Console] to access the console and click the send CTRL+ALT+DEL button on the top right. Alternatively, you can also click [RESTART] to restart the server.
As soon as the boot process starts, press ESC to bring up the GRUB boot prompt. You may need to turn the system off from the control panel and then back on to reach the GRUB boot prompt.
You will see a GRUB boot prompt - press "e" to edit the first boot option. (If you do not see the GRUB prompt, you may need to press any key to bring it up before the machine boots)
Find the kernel line (starts with "linux16"), change ro to rw init=/sysroot/bin/sh.
Press CTRL-X or F10 to boot single user mode.
Access the system with the command: chroot /sysroot.
Run passwd to change the root password.
Reboot the system: reboot -f.

(MR: or add 1 if to the same line instead of the rest to enter real user mode)
