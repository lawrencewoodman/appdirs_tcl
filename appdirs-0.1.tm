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
  variable appName brandName method

  constructor {_brandName _appName} {
    set appName $_appName
    set brandName $_brandName
    my SetMethod
  }

  method SetMethod {} {
    switch $::tcl_platform(os) {
      Linux {
        set method "XDG"
      }
      "Windows 2000" -
      "Windows Vista" -
      "Windows XP" {
        set method "APPDATA"
      }
      default {
        set method "NONE"
      }
    }
  }

  method dataHome {} {
    switch $method {
      XDG {
        return [XDG::DATA_HOME $appName]
      }
      APPDATA {
        return [join [list $::env(APPDATA) $brandName $appName] \\]
      }
      default {
        return ""
      }
    }
  }
}
