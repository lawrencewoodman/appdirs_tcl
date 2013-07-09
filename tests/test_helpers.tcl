# Helper functions for the tests

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
    "Windows 2000" -
    "Windows Vista" -
    "Windows XP" {
      SetEnvVar APPDATA "c:\\documents and settings\\$user\\application data"
    }
  }
}

proc TestHelpers::restoreEnvironment {} {
  RestoreOS
  RestoreEnvVars
}
