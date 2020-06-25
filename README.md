# iOS 14 Playground

Sample code and explorations of iOS 14.

## Pickers, Menus, and Actions

### UIMenus on UIButtons and UIBarButtonItems

Add menus to `UIButton`s and `UIBarButtonItem`s by assigning a `UIMenu` object to those controls' `menu` property. By default, menus will appear after a long press on the button. You can also immediately show a menu by setting the `UIButton` property `showsMenuAsPrimaryAction` to `true`, or by not setting a primary action on `UIBarButtonItem`.

<img src="screenshots/uimenu.png" width="375" alt="UIMenus on UIButtons">