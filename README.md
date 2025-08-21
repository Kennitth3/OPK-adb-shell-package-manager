# What is opk?
Opk is a package manager designed for adb shell, it is a community driven package manager so anyone can make their own packages that work on the adb shell

# Why does opk exist?
Opk exists because there has been barely anything that can run on the adb shell as it requires a static binary and it requires the architecture for the android device, and even if you do find a static binary there is a good chance that its against the glibc which android nor adb support

# What can I do?
You can make packages for the adb shell that supports the architecture, isn't against glibc, and can actually be ran

# Does opk require root?
No! it does not require root, because most devices or most newer ones doesnt give you access to root your device making it unrootable, heck, even my Samsung Galaxy A16 5G phone cant be rooted, so i want to make this package manager not require root so everyone can use this package manager!

# Where will this package manager be in if you dont need root?
The package manager will be stored in the /data/local/tmp directory with its own directory so you can easily manage the opk file if you want to make any changes to it!

# What is required | Packages:
You will be needing to make or get source code and make static binaries(as dynamic binaries are harder to work as almost everything breaks) and they must be able to run on all architectures, so you must make your packages compatible with other architectures or make seperate packages for the architectures, and pls if you can and unless you know how, **DONT MAKE THE PACKAGES REQUIRE GLIBC** it will be easier to use a different one or use the bionic libc(native to android devices) or a musl.

# What is required | Installing opk:
Its simple, all you need to do is install the package manager, put it in your /data/local/tmp directory and then just do /data/local/tmp/opk/pkgmgr.sh to install or you can make an alias so all you have to do is type in opk or any other alias you want!

# How do i make a package for opk?
You simply go to the cache, put in your package, then edit the repos.txt to put in your package!
