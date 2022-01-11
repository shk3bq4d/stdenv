```sh
nm-applet
sudo iwlist scan
sudo iwlist scan | grep -Ei 'address|channel|quality|essid|quality'

sudo wpa_cli scan
sudo wpa_cli scan_results
~/bin/wifi-networks.sh

https://askubuntu.com/questions/967355/wifi-unstable-after-17-10-update


sudo cat "/etc/NetworkManager/system-connections/*"
          Cell 01 - Address: F2:F2:6D:B6:B6:08
                    Channel:36
                    Frequency:5.18 GHz (Channel 36)
                    Quality=61/70  Signal level=-49 dBm
                    ESSID:"Olivia151"
          Cell 02 - Address: F4:F2:6D:B6:B6:09
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=70/70  Signal level=-32 dBm
                    ESSID:"njsfjlk FDS354"
          Cell 03 - Address: F6:F2:6D:B6:B6:09
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=70/70  Signal level=-33 dBm
                    ESSID:"Olivia"
          Cell 04 - Address: F2:F2:6D:B6:B6:09
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=70/70  Signal level=-33 dBm
                    ESSID:"Olivia-124"
          Cell 05 - Address: 00:0C:F6:AE:B4:94
                    Channel:6
                    Frequency:2.437 GHz (Channel 6)
                    Quality=58/70  Signal level=-52 dBm
                    ESSID:"njsfjlk FDS354"
          Cell 06 - Address: 00:0C:F6:AE:B4:95
                    Channel:6
                    Frequency:2.437 GHz (Channel 6)
                    Quality=52/70  Signal level=-58 dBm
                    ESSID:"Olivia"
          Cell 07 - Address: 00:0C:F6:AE:B4:96
                    Channel:6
                    Frequency:2.437 GHz (Channel 6)
                    Quality=57/70  Signal level=-53 dBm
                    ESSID:"Olivia-224"
          Cell 08 - Address: F4:F2:6D:B6:B6:08
                    Channel:36
                    Frequency:5.18 GHz (Channel 36)
                    Quality=61/70  Signal level=-49 dBm
                    ESSID:"njsfjlk FDS354"
          Cell 09 - Address: F6:F2:6D:B6:B6:08
                    Channel:36
                    Frequency:5.18 GHz (Channel 36)
                    Quality=61/70  Signal level=-49 dBm
                    ESSID:"Olivia"
          Cell 10 - Address: 00:22:64:DD:21:73
                    Channel:1
                    Frequency:2.412 GHz (Channel 1)
                    Quality=21/70  Signal level=-89 dBm
                    ESSID:"HP-Print-73-Officejet Pro 8610"
```

# IW
Usage:  iw [options] command
Options:
    --debug     enable netlink debugging
    --version   show version (5.9-8fab0c9e)
Commands:
    dev <devname> station set <MAC address> txpwr <auto|limit> [<tx power dBm>]
        Set Tx power for this station.

    dev <devname> station set <MAC address> airtime_weight <weight>
        Set airtime weight for this station.

    dev <devname> station set <MAC address> vlan <ifindex>
        Set an AP VLAN for this station.

    dev <devname> station get <MAC address>
        Get information for a specific station.

    dev <devname> station del <MAC address> [subtype <subtype>] [reason-code <code>]
        Remove the given station entry (use with caution!)
        Example subtype values: 0xA (disassociation), 0xC (deauthentication)

    dev <devname> station dump [-v]
        List all stations known, e.g. the AP on managed interfaces

    dev <devname> disconnect
        Disconnect from the current network.

    dev <devname> connect [-w] <SSID> [<freq in MHz>] [<bssid>] [key 0:abcde d:1:6162636465] [mfp:req/opt/no]
        Join the network with the given SSID (and frequency, BSSID).
        With -w, wait for the connect to finish or fail.

    dev <devname> auth <SSID> <bssid> <type:open|shared> <freq in MHz> [key 0:abcde d:1:6162636465]
        Authenticate with the given network.


    event [-t|-r] [-f]
        Monitor events from the kernel.
        -t - print timestamp
        -T - print absolute, human-readable timestamp
        -r - print relative timestamp
        -f - print full frame for auth/assoc etc.

    phy <phyname> hwsim getps


    phy <phyname> hwsim setps <value>


    phy <phyname> hwsim stopqueues


    phy <phyname> hwsim wakequeues


    dev <devname> ibss leave
        Leave the current IBSS cell.

    dev <devname> ibss join <SSID> <freq in MHz> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz] [fixed-freq] [<fixed bssid>] [beacon-interval <TU>] [basic-rates <rate in Mbps,rate2,...>] [mcast-rate <rate in Mbps>] [key d:0:abcde]
        Join the IBSS cell with the given SSID, if it doesn't exist create
        it on the given frequency. When fixed frequency is requested, don't
        join/create a cell on a different frequency. When a fixed BSSID is
        requested use that BSSID and do not adopt another cell's BSSID even
        if it has higher TSF and the same SSID. If an IBSS is created, create
        it with the specified basic-rates, multicast-rate and beacon-interval.

    phy <phyname> info
        Show capabilities for the specified wireless device.

    list
        List all wireless devices and their capabilities.

    phy
    features


    phy <phyname> interface add <name> type <type> [mesh_id <meshid>] [4addr on|off] [flags <flag>*] [addr <mac-addr>]
        Add a new virtual interface with the given configuration.
        Valid interface types are: managed, ibss, monitor, mesh, wds.

        The flags are only used for monitor interfaces, valid flags are:
        none:     no special flags
        fcsfail:  show frames with FCS errors
        control:  show control frames
        otherbss: show frames from other BSSes
        cook:     use cooked mode
        active:   use active mode (ACK incoming unicast packets)
        mumimo-groupid <GROUP_ID>: use MUMIMO according to a group id
        mumimo-follow-mac <MAC_ADDRESS>: use MUMIMO according to a MAC address

        The mesh_id is used only for mesh mode.

    dev <devname> interface add <name> type <type> [mesh_id <meshid>] [4addr on|off] [flags <flag>*] [addr <mac-addr>]
    dev <devname> del
        Remove this virtual interface

    dev <devname> info
        Show information for this interface.

    dev
        List all network interfaces for wireless hardware.

    help [command]
        Print usage for all or a specific command, e.g.
        "help wowlan" or "help wowlan enable".

    dev <devname> link
        Print information about the current link, if any.

    dev <devname> mesh join <mesh ID> [[freq <freq in MHz> <NOHT|HT20|HT40+|HT40-|80MHz>] [basic-rates <rate in Mbps,rate2,...>]], [mcast-rate <rate in Mbps>] [beacon-interval <time in TUs>] [dtim-period <value>] [vendor_sync on|off] [<param>=<value>]*
        Join a mesh with the given mesh ID with frequency, basic-rates,
        mcast-rate and mesh parameters. Basic-rates are applied only if
        frequency is provided.

    dev <devname> mesh leave
        Leave a mesh.

    dev <devname> mpath probe <destination MAC address> frame <frame>
        Inject ethernet frame to given peer overriding the next hop
        lookup from mpath table.
        .Example: iw dev wlan0 mpath probe xx:xx:xx:xx:xx:xx frame 01:xx:xx:00


    dev <devname> mpath get <MAC address>
        Get information on mesh path to the given node.

    dev <devname> mpath del <MAC address>
        Remove the mesh path to the given node.

    dev <devname> mpath new <destination MAC address> next_hop <next hop MAC address>
        Create a new mesh path (instead of relying on automatic discovery).

    dev <devname> mpath set <destination MAC address> next_hop <next hop MAC address>
        Set an existing mesh path's next hop.

    dev <devname> mpath dump
        List known mesh paths.

    dev <devname> mpp get <MAC address>
        Get information on mesh proxy path to the given node.

    dev <devname> mpp dump
        List known mesh proxy paths.

    phy <phyname> channels
        Show available channels.

    reg set <ISO/IEC 3166-1 alpha2>
        Notify the kernel about the current regulatory domain.

    reg get
        Print out the kernel's current regulatory domain information.

    phy <phyname> reg get
        Print out the devices' current regulatory domain information.

    reg reload
        Reload the kernel's regulatory database.

    dev <devname> scan [-u] [freq <freq>*] [duration <dur>] [ies <hex as 00:11:..>] [meshid <meshid>] [lowpri,flush,ap-force,duration-mandatory] [randomise[=<addr>/<mask>]] [ssid <ssid>*|passive]
        Scan on the given frequencies and probe for the given SSIDs
        (or wildcard if not given) unless passive scanning is requested.
        If -u is specified print unknown data in the scan results.
        Specified (vendor) IEs must be well-formed.

    dev <devname> scan dump [-u]
        Dump the current scan results. If -u is specified, print unknown
        data in scan results.

    dev <devname> scan trigger [freq <freq>*] [duration <dur>] [ies <hex as 00:11:..>] [meshid <meshid>] [lowpri,flush,ap-force,duration-mandatory,coloc] [randomise[=<addr>/<mask>]] [ssid <ssid>*|passive]
        Trigger a scan on the given frequencies with probing for the given
        SSIDs (or wildcard if not given) unless passive scanning is requested.
        Duration(in TUs), if specified, will be used to set dwell times.


    dev <devname> scan abort
        Abort ongoing scan

    dev <devname> get mesh_param [<param>]
        Retrieve mesh parameter (run command without any to see available ones).

    phy <phyname> get txq
        Get TXQ parameters.

    dev <devname> get power_save <param>
        Retrieve power save state.

    dev <devname> set bitrates [legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>] [he-ltf-<2.4|5|6> <1|2|4>]
        Sets up the specified rate masks.
        Not passing any arguments would clear the existing mask (if any).

    dev <devname> set monitor <flag>*
        Set monitor flags. Valid flags are:
        none:     no special flags
        fcsfail:  show frames with FCS errors
        control:  show control frames
        otherbss: show frames from other BSSes
        cook:     use cooked mode
        active:   use active mode (ACK incoming unicast packets)
        mumimo-groupid <GROUP_ID>: use MUMIMO according to a group id
        mumimo-follow-mac <MAC_ADDRESS>: use MUMIMO according to a MAC address

    dev <devname> set meshid <meshid>
    dev <devname> set type <type>
        Set interface type/mode.
        Valid interface types are: managed, ibss, monitor, mesh, wds.

    dev <devname> set 4addr <on|off>
        Set interface 4addr (WDS) mode.

    dev <devname> set noack_map <map>
        Set the NoAck map for the TIDs. (0x0009 = BE, 0x0006 = BK, 0x0030 = VI, 0x00C0 = VO)

    dev <devname> set mcast_rate <rate in Mbps>
        Set the multicast bitrate.

    dev <devname> set mesh_param <param>=<value> [<param>=<value>]*
        Set mesh parameter (run command without any to see available ones).

    phy <phyname> set name <new name>
        Rename this wireless device.

    phy <phyname> set freq <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
    phy <phyname> set freq <control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]
        Set frequency/channel the hardware is using, including HT
        configuration.

    dev <devname> set freq <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
    dev <devname> set freq <control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]
    phy <phyname> set channel <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
    dev <devname> set channel <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
    phy <phyname> set frag <fragmentation threshold|off>
        Set fragmentation threshold.

    phy <phyname> set rts <rts threshold|off>
        Set rts threshold.

    phy <phyname> set retry [short <limit>] [long <limit>]
        Set retry limit.

    phy <phyname> set netns { <pid> | name <nsname> }
        Put this wireless device into a different network namespace:
            <pid>    - change network namespace by process id
            <nsname> - change network namespace by name from /var/run/netns
                       or by absolute path (man ip-netns)


    phy <phyname> set coverage <coverage class>
        Set coverage class (1 for every 3 usec of air propagation time).
        Valid values: 0 - 255.

    phy <phyname> set distance <auto|distance>
        Enable ACK timeout estimation algorithm (dynack) or set appropriate
        coverage class for given link distance in meters.
        To disable dynack set valid value for coverage class.
        Valid values: 0 - 114750

    phy <phyname> set txpower <auto|fixed|limit> [<tx power in mBm>]
        Specify transmit power level and setting type.

    dev <devname> set txpower <auto|fixed|limit> [<tx power in mBm>]
        Specify transmit power level and setting type.

    phy <phyname> set antenna <bitmap> | all | <tx bitmap> <rx bitmap>
        Set a bitmap of allowed antennas to use for TX and RX.
        The driver may reject antenna configurations it cannot support.

    phy <phyname> set txq limit <packets> | memory_limit <bytes> | quantum <bytes>
        Set TXQ parameters. The limit and memory_limit are global queue limits
        for the whole phy. The quantum is the DRR scheduler quantum setting.
        Valid values: 1 - 2**32

    phy <phyname> set antenna_gain <antenna gain in dBm>
        Specify antenna gain.

    dev <devname> set power_save <on|off>
        Set power save state to on or off.

    dev <devname> survey dump
        List all gathered channel survey data


Commands that use the netdev ('dev') can also be given the
'wdev' instead to identify the device.

You can omit the 'phy' or 'dev' if the identification is unique,
e.g. "iw wlan0 info" or "iw phy0 info". (Don't when scripting.)

Do NOT screenscrape this tool, we don't consider its output stable.

