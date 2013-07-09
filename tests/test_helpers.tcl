# Helper functions for the tests
package require struct::list

namespace eval TestHelpers {
  variable storedOS ""
  variable storedEnvVars {}
}

proc TestHelpers::RestoreEnvVars {} {
  variable storedEnvVars
  if {$storedEnvVars ne {}} {
    dict for {var value} $storedEnvVars {
      if {$value ne ""} {
        set ::env($var) $value
      } else {
        unset ::env($var)
      }
    }
    set storedEnvVars {}
  }
}

proc TestHelpers::SetEnvVar {var value} {
  variable storedEnvVars
  if {![dict exists $storedEnvVars $var]} {
    if {[info exists ::env($var)]} {
      dict set storedEnvVars $var $::env($var)
    } else {
      dict set storedEnvVars $var ""
    }
  }
  set ::env($var) $value
}

proc TestHelpers::RestoreOS {} {
  variable storedOS
  if {$storedOS ne ""} {
    set ::tcl_platform(os) $storedOS
    set storedOS ""
  }
}

proc TestHelpers::SetOS {os} {
  variable storedOS
  if {$storedOS eq ""} {set storedOS $::tcl_platform(os)}
  set ::tcl_platform(os) $os

}

proc TestHelpers::setEnvironment {os user} {
  SetOS $os
  switch $os {
    "Linux" {
      SetEnvVar HOME "/home/$user"
    }
    "Windows 2000" {
      SetEnvVar ALLUSERSPROFILE "C:\\ProgramData"
      SetEnvVar APPDATA "C:\\Cocuments and Settings\\$user\\Application Data"
      SetEnvVar PROGRAMDATA "C:\\ProgramData"
    }
    "Windows Vista" {
      SetEnvVar ALLUSERSPROFILE "C:\\ProgramData"
      SetEnvVar APPDATA "C:\\Documents and Settings\\$user\\Application Data"
      SetEnvVar PROGRAMDATA "C:\\ProgramData"
    }
    "Windows XP" {
      SetEnvVar ALLUSERSPROFILE "C:\\Documents and Settings\All Users"
      SetEnvVar APPDATA "C:\\Documents and Settings\\$user\\Application Data"
    }
  }
}

proc TestHelpers::restoreEnvironment {} {
  RestoreOS
  RestoreEnvVars
}

proc TestHelpers::countMatches {sequence lambda} {
  llength [struct::list filter $sequence [list apply $lambda]]
}
