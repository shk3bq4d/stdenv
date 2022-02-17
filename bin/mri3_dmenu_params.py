#!/usr/bin/env python3

def get(width=True, colors=True):
#   fontH = dict(
#       acer2011=11,
#       dec17=14
#       )
#   small = socket.gethostname() in fontH.keys()
#   monitor1 = socket.gethostname() in ['ru'+'mo-pc']

#   col_nb = '#222222'
#   col_nf = '#999999'
#   if 1:
#       col_nb = '#FFFFFF'
#       col_nf = '#000000'
#   if os.environ.get('HOSTNAMEF') == 'dec17.ly.lan':
#       try:
#           pgrep('compton')
#       except:
#           col_nb = '#FFFFFF'
#           col_nf = '#000000'
#   # set default menu args for supported menus

#   menu_args += ['--class', 'mrdmenu', '-i', '-f', '-b', '-fn']
#   menu_args += ['DejaVuSansMono-{}'.format(fontH.get(socket.gethostname(), 28))]
#   if monitor1:
#       menu_args += ['-m', '1']
#   menu_args += [ '-nb', col_nb, '-nf', col_nf]


#   if 0:
#       try:
#           from sh import rofi
#           #dmenu = rofi.bake('-dmenu').bake('-normal-window')
#           dmenu = rofi.bake('-dmenu')
#       except:
#           from sh import dmenu
#   else:
#       from sh import dmenu
    import socket
    fontH = dict(
        acer2011=11,
        dec17=14,
        feb22=14,
        )
    widthH = dict(
        feb22='-x 1700 -w 1720',
        )
    colorsH = dict(
        feb22='-nb #FFBBFF -nf #000000',
        )
    hostname = socket.gethostname()
    widthA  = widthH.get(hostname, '').split() if width else []
    colorsA = colorsH.get(hostname, '').split() if colors else []
    monitor1 = hostname in ['ru'+'mo-pc']

    # set default menu args for supported menus
    menu_args = []
    #menu_args += ['-i', '-p', prompt, '-f', '-b', '-fn']
    menu_args += ['--class', 'mrdmenu', '-i', '-f', '-b', '-fn']
    menu_args += ['DejaVuSansMono-{}'.format(fontH.get(hostname, 28))]
    if len(widthA) > 0:
        menu_args = menu_args + widthA
    if len(colorsA) > 0:
        menu_args = menu_args + colorsA
    if monitor1:
        menu_args += ['-m', '1']
    return menu_args
#

if __name__ == '__main__':
    print(" ".join(get()))
