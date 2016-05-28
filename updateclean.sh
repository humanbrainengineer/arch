#!/bin/bash
Cleaning the package cache

pacman stores its downloaded packages in /var/cache/pacman/pkg/ and does not remove the old or uninstalled versions automatically, therefore it is necessary to deliberately clean up that folder periodically to prevent such folder to grow indefinitely in size.

The built-in option to remove all the cached packages that are not currently installed is:

# pacman -Sc

   

Warning:

    Only do this when certain that previous package versions are not required, for example for a later downgrade. pacman -Sc only leaves the versions of packages which are currently installed available, older versions would have to be retrieved through other means, such as the Archive.
    It is possible to empty the cache folder fully with pacman -Scc. In addition to the above, this also also prevents from reinstalling a package directly from the cache folder in case of need, thus requiring a new download. It should be avoided unless there is an immediate need for disk space.






