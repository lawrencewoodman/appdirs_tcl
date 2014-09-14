AppDirs
=======
A Tcl module to simplify cross-platform application file locations

An application that is installed on a variety of platforms will use different locations on each platform to access files.  This module aims to provide access to these locations through a common interface.  For each operating system the module aims to use an appropriate standard for the locations, for example on Linux the [XDG Base Directory Specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) is used and on Microsoft Windows the most common locations for each version of the operating system is used.

Requirements
------------
*  [TclOO](http://core.tcl.tk/tcloo/wiki?name=TclOO+Package) (Included as part of the core distribution from Tcl 8.6)
*  [xdgbasedir](https://github.com/LawrenceWoodman/xdgbasedir_tcl) module

Installation
------------
To install the module you can use the [installmodule.tcl](https://github.com/LawrenceWoodman/installmodule_tcl) script or if you want to manually copy the file `AppDirs-*.tm` to a specific location that tcl expects to find modules.  This would typically be something like:

    /usr/share/tcltk/tcl8.6/tcl8/

To find out what directories are searched for modules, start `tclsh` and enter:

    foreach dir [split [::tcl::tm::path list]] {puts $dir}

or from the command line:

    $ echo "foreach dir [split [::tcl::tm::path list]] {puts \$dir}" | tclsh

Module Usage
------------
First create an instance of the `AppDirs` class by instantiating it with a _brand_ and _applicationName_.  The _brand_ may be ignored depending on the platform that is being used.  You can then call the methods on this instance as follows:

    package require AppDirs

    set myAppDirs [AppDirs new myBrand myApp]

    # Return location of user-specific data files
    puts "data home: [$myAppDirs dataHome]"

    # Return location of user-specific configuration files
    puts "config home: [$myAppDirs configHome]"

    # Return a list of locations for system-wide configuration files in preference order
    puts "data dirs: [$myAppDirs dataDirs]"

    # Return a list of locations for system-wide data files in preference order
    puts "config dirs: [$myAppDirs configDirs]"

Default Directories
-------------------
To list the default directories for various platforms and to see the directories being used for the current system run:

    $ tclsh bin/listdirs.tcl

Testing
-------
There is a testsuite in `tests/`.  To run it:

    $ tclsh tests/appdirs.test.tcl

Contributions
-------------
If you want to improve this module make a pull request to the [repo](https://github.com/LawrenceWoodman/appdirs_tcl) on github.  Please put any pull requests in a separate branch to ease integration and add a test to prove that it works.

Licence
-------
Copyright (C) 2013, Lawrence Woodman <lwoodman@vlifesystems.com>

This software is licensed under an MIT Licence.  Please see the file, LICENCE.md, for details.
