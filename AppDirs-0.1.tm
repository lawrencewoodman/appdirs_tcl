# Cross-platform handling of application directories
#
# Copyright (C) 2013 Lawrence Woodman <lwoodman@vlifesystems.com>
#
# Licensed under an MIT licence.  Please see LICENCE.md for details.
#
# Access the most suitable directories for an application on whatever
# platform the application is running.
package require Tcl 8.6
package require xdgbasedir

::oo::class create AppDirs {
  variable appName brandName

  constructor {_brandName _appName} {
    set appName $_appName
    set brandName $_brandName
  }

  # Return location of user-specific data files
  method dataHome {} {
    switch $::tcl_platform(os) {
      Linux {
        return [XDG::DATA_HOME $appName]
      }
      "Windows 2000" -
      "Windows Vista" -
      "Windows XP"  {
        return [join [list $::env(APPDATA) $brandName $appName] \\]
      }
      default {
        return ""
      }
    }
  }

  # Return location of user-specific configuration files
  method configHome {} {
    switch $::tcl_platform(os) {
      Linux {
        return [XDG::CONFIG_HOME $appName]
      }
      "Windows 2000" -
      "Windows Vista" -
      "Windows XP" {
        return [join [list $::env(APPDATA) $brandName $appName] \\]
      }
      default {
        return ""
      }
    }
  }

  # Return a list of locations for system-wide configuration files in
  # preference order
  method configDirs {} {
    switch $::tcl_platform(os) {
      Linux {
        return [XDG::CONFIG_DIRS $appName]
      }
      "Windows 2000" -
      "Windows Vista" {
        return [join [list $::env(PROGRAMDATA) $brandName $appName] \\]
      }
      "Windows XP" {
        return [join [list $::env(ALLUSERSPROFILE) $brandName $appName] \\]
      }
      default {
        return ""
      }
    }
  }

  # Return a list of locations for system-wide data files in preference order
  method dataDirs {} {
    switch $::tcl_platform(os) {
      Linux {
        return [XDG::DATA_DIRS $appName]
      }
      "Windows 2000" -
      "Windows Vista" {
        return [join [list $::env(PROGRAMDATA) $brandName $appName] \\]
      }
      "Windows XP" {
        return [join [list $::env(ALLUSERSPROFILE) $brandName $appName] \\]
      }
      default {
        return ""
      }
    }
  }
}
