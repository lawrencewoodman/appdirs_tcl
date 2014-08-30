# Cross-platform handling of application directories
#
# Copyright (C) 2013 Lawrence Woodman <lwoodman@vlifesystems.com>
# Copyright (C) 2014 Steve Havelka <steve@arieslabs.com>
#
# Licensed under an MIT licence.  Please see LICENCE.md for details.
#
# Access the most suitable directories for an application on whatever
# platform the application is running.
package prefer latest
package require Itcl
package require xdgbasedir

::itcl::class AppDirs {
  variable appName
  variable brandName

  constructor {_brandName _appName} {
    set appName $_appName
    set brandName $_brandName
  }

  # Return location of user-specific data files
  method dataHome {} {
    if {$::tcl_platform(platform) eq "unix"} {
      if {$::tcl_platform(os) eq "Darwin"} {
        return [join [list "~/Library/Application Support" $brandName $appName] /]
      } else {
        return [XDG::DATA_HOME $appName]
      }
    } elseif {$::tcl_platform(platform) eq "windows"} {
      return [join [list $::env(APPDATA) $brandName $appName] \\]
    }
    return ""
  }

  # Return location of user-specific configuration files
  method configHome {} {
    if {$::tcl_platform(platform) eq "unix"} {
      if {$::tcl_platform(os) eq "Darwin"} {
        return [join [list "~/Library/Application Support" $brandName $appName] /]
      } else {
        return [XDG::DATA_HOME $appName]
      }
    } elseif {$::tcl_platform(platform) eq "windows"} {
      return [join [list $::env(APPDATA) $brandName $appName] \\]
    }
    return ""
  }

  # Return a list of locations for system-wide configuration files in
  # preference order
  method configDirs {} {
    if {$::tcl_platform(platform) eq "unix"} {
      if {$::tcl_platform(os) eq "Darwin"} {
        return "/Library/Application Support"
      } else {
        return [XDG::DATA_HOME $appName]
      }
    } elseif {$::tcl_platform(platform) eq "windows"} {
      set configDir [my WindowsConfigDataDir]
      if {[llength $configDir] != 0} {
        return [list $configDir]
      }
    }
    return ""
  }

  # Return a list of locations for system-wide data files in preference order
  method dataDirs {} {
    if {$::tcl_platform(platform) eq "unix"} {
      if {$::tcl_platform(os) eq "Darwin"} {
        return "/Library/Application Support"
      } else {
        return [XDG::DATA_HOME $appName]
      }
    } elseif {$::tcl_platform(platform) eq "windows"} {
      set configDir [my WindowsConfigDataDir]
      if {[llength $configDir] != 0} {
        return [list $configDir]
      }
    }
    return ""
  }

  method WindowsConfigDataDir {} {
    if {[info exists ::env(PROGRAMDATA)]} {
      return [join [list $::env(PROGRAMDATA) $brandName $appName] \\]
    } elseif {[info exists ::env(ALLUSERSPROFILE)]} {
      return [join [list $::env(ALLUSERSPROFILE) $brandName $appName] \\]
    }
    return ""
  }
}
