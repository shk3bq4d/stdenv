
# https://www.system-rescue.org/manual/PXE_network_booting/

Requirements
Servers to provide PXE services including DHCP with SystemRescue files available to serve clients requests
A client computer with a PXE able network card on the same network and enough memory to fully store SystemRescue files
How the PXE boot process works
The PXE boot server
The PXE boot server is made of three stages:

stage0: the PXE-booting client sent an extended DHCPDISCOVER
stage1: the DHCP server send an IP address to the client and supplementing information such as the TFTP server
stage2: the PXE-booting client configures the network and requests the first boot files from the TFTP server (boot loader, kernel image and sysresccd.img)
stage3: the PXE-booted client requests the squashfs root file system image from the HTTP or NFS or NBD server
These three parts can be installed either on a single machine or on several computers.

The PXE boot process
You may need to understand what happens when you boot SystemRescue from the network. You will need this knowledge for troubleshooting in case of problems. Here are the most important steps of the PXE boot process:

When the client computer tries to boot with PXE, it first emits a DHCP request on the network to get an IP address.
Then a DHCP server replies with a DHCP offer that contains a new IP address that was not already allocated and some specific options (DNS, default route) and the IP address of the TFTP server
The client receives this DHCP offer and accepts it. It connects to the TFTP server (it received its IP address in the previous stage) to get the boot loader files.
The TFTP server sends the boot loader files (pxelinux) and the text files displayed on the screen by pxelinux.
The client displays the pxelinux prompt, and the user can choose the boot options. It then requests from the TFTP server the kernel and initramfs files necessary to boot the system
The TFTP server sends the kernel and initramfs files (eg: vmlinuz + sysresccd.img) to the client
The client boots this kernel and executes the init programs that come with the initramfs.
During its initialization the kernel makes a DHCP request again because of the ip=dhcp kernel boot parameters. Indeed the kernel does not know the IP address used by the computer at the pxelinux stage.
The client needs the airootfs.sfs file. If you use HTTP or TFTP for the third stage, then airootfs.sfs will be downloaded into RAM so the client has to have enough memory (estimated requirement: 1GB). If you use either NFS or NBD then you don’t have this memory requirement and the client will make permanent requests to the server each time it needs a file from the root filesystem.
The client mounts airootfs.sfs and it can now complete the boot process.
At this stage the client holds all the files in memory, if you used TFTP/HTTP for the third stage, so it does not require a boot server any more. If you are using NFS or NBD, the connection is still required.
Customization of the boot command line
The PXE server is made of several services. In the second stage, the server uses TFTP to send multiple things to the client: boot loader (pxelinux.0), kernel image (vmlinuz), initramfs (sysresccd.img). The boot loader is pxelinux.0 and it comes with a configuration file which is sent to the client. This configuration file contains the boot command line which will be used by the client to start the Linux kernel. This command line is important since it contains the SystemRescue boot options that are required to run the third stage. The boot command line can be used to specify the network settings and the method that the PXE client will use in the third stage of the PXE boot process. Here are two examples of valid command lines for PXE boot:
