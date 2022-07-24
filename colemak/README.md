This is a custom keyboard I created to better suit programming and to be more comfortable for me to type. The latin letters are positioned as Colemak, with the [Colemak Mod-DH + Angle Mod](https://colemakmods.github.io/mod-dh/) applied. The numbers are positioned in a numpad fashion, accesed via AltGr, which makes it incredibly easy to type! Extra characters were positioned as I saw fit.

This is a live project, and I will be doing further modifications to suit my needs.

## Configuration
### Linux
The [colemak-xkb](./colemak-xkb) should be concatenated to `/usr/share/X11/xkb/symbols/us`. Other xkb configuration files located in `/usr/share/X11/xkb/rules`, need to be edited, but it may differ from distro to distro. My to-go files are `evdev.xml`, `base.lst`, `base.xml`. I'm not sure if all of them are necessary, but it works.
**These files will reset when the package xkeyboard-config gets updated.** 

The [colemakp.map.gz](./colemakp.map.gz) should be copied to `/usr/local/share/kbd/keymaps/`. For more information, check the [Arch Linux Wiki article](https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration#Creating_a_custom_keymap) about it.

### Windows
I also have Windows files, but those have not been updated in a while (I stopped using Windows), so the layout may slightly differ from what I currently have. The majority should be the same.

The keyboard was created using the [Microsoft Keyboard Layout Creator (MSKLC)](https://www.microsoft.com/en-us/download/details.aspx?id=102134). The configuration file containing the custom keyboard is [colemakwp.klc](./windows/colemakwp.klc).

To install the keyboard, click on the [setup.exe](./windows/colemakw/setup.exe) and follow the steps.

## Other Resources
- [List of keysyms](https://wiki.linuxquestions.org/wiki/List_of_keysyms)
- [How to get a list of valid X11 names of characters – superuser](https://superuser.com/questions/1460984/how-to-get-a-list-of-valid-x11-names-for-characters)
	- view `/usr/include/X11/keysymdef.h`

