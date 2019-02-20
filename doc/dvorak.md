$mod+Control+Return exec mrurxvt-dvorak.sh
setxkbmap -layout us -variant dvp -option -option caps:escape -option lv3:ralt_switch # dvorak programmer
setxkbmap -layout ch -variant fr

lv3:ralt_switch : keeps alt-gr for accentuated characters as simultaneous action
compose:ralt: uses right alt for successive keys accentuated


# lightweight print version
┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌─────────┐
│~  │ │%  │ │   │ │   │ │   │ │   │ │9  │ │   │ │   │ │   │ │   │ │   │ │`  │ │         │
│  $│ │  &│ │  [│ │  {│ │  }│ │  (│ │  =│ │  *│ │  )│ │  +│ │  ]│ │  !│ │  #│ │         │
└───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └─────────┘
┌──────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌──────┐
│      │ │:  │ │<  │ │>  │ │   │ │   │ │   │ │   │ │   │ │   │ │   │ │?  │ │^  │ │ |    │
│      │ │  ;│ │  ,│ │  .│ │   │ │   │ │   │ │   │ │   │ │   │ │ > │ │  /│ │  @│ │    \ │
└──────┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └──────┘
┌────────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌──────────┐
│        │ │   │ │   │ │   │ │ . │ │   │ │   │ │ . │ │   │ │   │ │   │ │_  │ │          │
│        │ │   │ │   │ │   │ │   │ │   │ │   │ │ < │ │   │ │   │ │   │ │  -│ │          │
└────────┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └──────────┘
┌───────────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌─────────────┐
│           │ │"  │ │   │ │   │ │ ^ │ │   │ │   │ │   │ │   │ │   │ │   │ │             │
│           │ │  '│ │   │ │ \/│ │   │ │   │ │   │ │   │ │   │ │   │ │   │ │             │
└───────────┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └─────────────┘

# programmer dvorak https://upload.wikimedia.org/wikipedia/en/a/a6/KB_Programmer_Dvorak.svg
┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌─────────┐
│~  │ │%  │ │7  │ │5  │ │3  │ │1  │ │9  │ │0  │ │2  │ │4  │ │6  │ │8  │ │`  │ │         │
│  $│ │  &│ │  [│ │  {│ │  }│ │  (│ │  =│ │  *│ │  )│ │  +│ │  ]│ │  !│ │  #│ │Backspace│
└───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └─────────┘
┌──────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌──────┐
│      │ │:  │ │<  │ │>  │ │P  │ │Y  │ │F  │ │G  │ │C  │ │R  │ │L  │ │?  │ │^  │ │ |    │
│  Tab │ │  ;│ │  ,│ │  .│ │  p│ │  y│ │  f│ │  g│ │  c│ │  r│ │  l│ │  /│ │  @│ │    \ │
└──────┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └──────┘
┌────────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌──────────┐
│        │ │A  │ │O  │ │E  │ │U  │ │I  │ │D  │ │H  │ │T  │ │N  │ │S  │ │_  │ │          │
│CapsLock│ │  a│ │  o│ │  e│ │  u│ │  i│ │  d│ │  h│ │  t│ │  n│ │  s│ │  -│ │  Enter   │
└────────┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └──────────┘
┌───────────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌─────────────┐
│           │ │"  │ │Q  │ │J  │ │K  │ │X  │ │B  │ │M  │ │W  │ │V  │ │Z  │ │             │
│   Shift   │ │  '│ │  q│ │  j│ │  k│ │  x│ │  b│ │  m│ │  w│ │  v│ │  z│ │    Shift    │
└───────────┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └─────────────┘

┌───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───────┐
│~ $│% &│[ 7│{ 5│} 3│( 1│= 9│   │* 0│) 2│+ 4│] 6│! 8│` #│ Bkspc │
├───┼───┼───┼───┼───┼───┼───┤   ├───┼───┼───┼───┼───┼───┼───────┤
│Tab│\ :│, <│. >│ P │ Y │ F │   │ G │ C │ R │ L │/ ?│@ ^│  \ |  │
├───┴───┼───┼───┼───┼───┼───┤   ├───┼───┼───┼───┼───┼───┼───────┤
│Cap/Esc│ A │ O │ E │ U │ I │   │ D │ H │ T │ N │ S │- _│ Enter │
├───────┼───┼───┼───┼───┼───┤   ├───┼───┼───┼───┼───┼───┴───────┤
│ Shift │' "│ Q │ J │ K │ X │   │ B │ M │ W │ V │ Z │   Shift   │
├───┬───┼───┼───┼───┴───┴───┴───┴───┴───┴───┼───┴───┼───────────┤
│fn │Crl│Alt│Cmd│         Space Bar         │  Cmd  │    Alt    │
└───┴───┴───┴───┴───────────────────────────┴───────┴───────────┘

# US dvorak https://commons.wikimedia.org/wiki/File:KB_United_States_Dvorak.svg
┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐
│~  │ │!  │ │@  │ │#  │ │$  │ │%  │ │^  │ │&  │ │*  │ │(  │ │)  │ │{  │ │}  │
│  `│ │  1│ │  2│ │  3│ │  4│ │  5│ │  6│ │  7│ │  8│ │  9│ │  0│ │  [│ │  ]│
└───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘
   ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐
   │"  │ │?  │ │?  │ │P  │ │Y  │ │F  │ │G  │ │C  │ │R  │ │L  │ │?  │ │+  │
   │  '│ │  ,│ │  .│ │  p│ │  y│ │  f│ │  g│ │  c│ │  r│ │  l│ │  /│ │  =│
   └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘
     ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐
     │A  │ │O  │ │E  │ │U  │ │I  │ │D  │ │H  │ │T  │ │N  │ │S  │ │_  │ │|  │
     │  a│ │  o│ │  e│ │  u│ │  i│ │  d│ │  h│ │  t│ │  n│ │  s│ │  -│ │  \│
     └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘
  ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐
  │>  │ │:  │ │Q  │ │J  │ │K  │ │X  │ │B  │ │M  │ │W  │ │V  │ │Z  │
  │  <│ │  ;│ │  q│ │  j│ │  k│ │  x│ │  b│ │  m│ │  w│ │  v│ │  z│
  └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ └───┘

# tools
* https://github.com/jayliu50/windows-programmer-dvorak
* apt install dvorak7min && dvorak7min
* npm install dvorak-programmers-tutorial && nodejs ~/node_modules/dvorak-programmers-tutorial/index.js -k 01
* http://play.typeracer.com/
 * http://play.typeracer.com/?universe=code
 * http://play.typeracer.com/?universe=easytexts
 * http://play.typeracer.com/?universe=indonesian2
 * http://play.typeracer.com/?universe=worthless_impossible_stupid
 * http://play.typeracer.com/?universe=championship
* https://learn.dvorak.nl/?lesson=5
* sudo apt install florence

    state 0x0, keycode 49 (keysym 0x60, grave), same_screen YES,
    state 0x0, keycode 10 (keysym 0x31, 1), same_screen YES,
    state 0x0, keycode 11 (keysym 0x32, 2), same_screen YES,
    state 0x0, keycode 12 (keysym 0x33, 3), same_screen YES,
    state 0x0, keycode 13 (keysym 0x34, 4), same_screen YES,
    state 0x0, keycode 14 (keysym 0x35, 5), same_screen YES,
    state 0x0, keycode 15 (keysym 0x36, 6), same_screen YES,
    state 0x0, keycode 16 (keysym 0x37, 7), same_screen YES,
    state 0x0, keycode 17 (keysym 0x38, 8), same_screen YES,
    state 0x0, keycode 18 (keysym 0x39, 9), same_screen YES,
    state 0x0, keycode 19 (keysym 0x30, 0), same_screen YES,
    state 0x0, keycode 20 (keysym 0x2d, minus), same_screen YES,
    state 0x0, keycode 21 (keysym 0x3d, equal), same_screen YES,
    state 0x0, keycode 22 (keysym 0xff08, BackSpace), same_screen YES,
    state 0x0, keycode 23 (keysym 0xff09, Tab), same_screen YES,
    state 0x0, keycode 24 (keysym 0x71, q), same_screen YES,
    state 0x0, keycode 25 (keysym 0x77, w), same_screen YES,
    state 0x0, keycode 26 (keysym 0x65, e), same_screen YES,
    state 0x0, keycode 27 (keysym 0x72, r), same_screen YES,
    state 0x0, keycode 28 (keysym 0x74, t), same_screen YES,
    state 0x0, keycode 29 (keysym 0x79, y), same_screen YES,
    state 0x0, keycode 30 (keysym 0x75, u), same_screen YES,
    state 0x0, keycode 31 (keysym 0x69, i), same_screen YES,
    state 0x0, keycode 32 (keysym 0x6f, o), same_screen YES,
    state 0x0, keycode 33 (keysym 0x70, p), same_screen YES,
    state 0x0, keycode 34 (keysym 0x5b, bracketleft), same_screen YES,
    state 0x0, keycode 35 (keysym 0x5d, bracketright), same_screen YES,
    state 0x0, keycode 51 (keysym 0x5c, backslash), same_screen YES,
    state 0x0, keycode 66 (keysym 0xff1b, Escape), same_screen YES,
    XKeysymToKeycode returns keycode: 9
    state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
    state 0x0, keycode 39 (keysym 0x73, s), same_screen YES,
    state 0x0, keycode 40 (keysym 0x64, d), same_screen YES,
    state 0x0, keycode 41 (keysym 0x66, f), same_screen YES,
    state 0x0, keycode 42 (keysym 0x67, g), same_screen YES,
    state 0x0, keycode 43 (keysym 0x68, h), same_screen YES,
    state 0x0, keycode 44 (keysym 0x6a, j), same_screen YES,
    state 0x0, keycode 45 (keysym 0x6b, k), same_screen YES,
    state 0x0, keycode 46 (keysym 0x6c, l), same_screen YES,
    state 0x0, keycode 47 (keysym 0x3b, semicolon), same_screen YES,
    state 0x0, keycode 48 (keysym 0x27, apostrophe), same_screen YES,
    state 0x0, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    state 0x0, keycode 52 (keysym 0x7a, z), same_screen YES,
    state 0x0, keycode 53 (keysym 0x78, x), same_screen YES,
    state 0x0, keycode 54 (keysym 0x63, c), same_screen YES,
    state 0x0, keycode 55 (keysym 0x76, v), same_screen YES,
    state 0x0, keycode 56 (keysym 0x62, b), same_screen YES,
    state 0x0, keycode 57 (keysym 0x6e, n), same_screen YES,
    state 0x0, keycode 58 (keysym 0x6d, m), same_screen YES,
    state 0x0, keycode 59 (keysym 0x2c, comma), same_screen YES,
    state 0x0, keycode 60 (keysym 0x2e, period), same_screen YES,
    state 0x0, keycode 61 (keysym 0x2f, slash), same_screen YES,
    state 0x0, keycode 62 (keysym 0xffe2, Shift_R), same_screen YES,


# accent simultaneous mode
é altgr-u                            # aigu cute
é altgr-' e                          # aigu cute
è altgr-` e  or altgr-# e            # grave
ê altgr-^ e  or altgr-@ e            # 
ë altgr-: e  or altgr-; e
ẽ altgr-~ e  or altgr-$ e
ç altgr-c
« altgr-<
»
¶ p
ü y
® r
¿ /
å a
ø o
æ e
é u
ð d
ñ n
ß s
­-
¤ [
¢ {
¥ }
€ (
£ =
½ )
¡ !

á AltGr ' a áé
é AltGr ' e eacute aigu
à AltGr # a (# is lowercase `) grave
â AltGr @ a (@ is lowercase ^) circonflexe
ç AltGr c cedille cedile
Ç AltGr Shift C
êôâûîûŷ
ëøöäëüï AltGr ; letter (; is lowercase :) trema points deux umlaut


accepted
It is called 'keyboard auto repeat rate' and you can set it with kbdrate Mine is set to:

$ sudo kbdrate
Typematic Rate set to 10.9 cps (delay = 250 ms)
	You can set same with:

sudo kbdrate -r 10.9 -d 250
xset r rate 250 60


https://www.kaufmann.no/downloads/linux/ckbcomp.gz # scripts
https://www.kaufmann.no/roland/dvorak/linux.html
