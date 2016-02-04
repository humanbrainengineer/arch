#!/bin/bash
Cleaning the package cache

pacman stores its downloaded packages in /var/cache/pacman/pkg/ and does not remove the old or uninstalled versions automatically, therefore it is necessary to deliberately clean up that folder periodically to prevent such folder to grow indefinitely in size.

The built-in option to remove all the cached packages that are not currently installed is:

# pacman -Sc
