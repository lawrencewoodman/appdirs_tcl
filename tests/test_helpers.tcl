# Helper functions for the tests
package require struct::list

namespace eval TestHelpers {
  variable storedOS ""
  variable storedPlatform ""
  variable storedEnvVars {}
}

rename file oldFile
proc file {cmd args} {
  if {$cmd eq "join"} {
    if {$::tcl_platform(platform) eq "unix"} {
      if {[lindex $args 0] eq "/"} {
        lset args 0 {}
      }
      return [join $args /]
    } elseif {$::tcl_platform(platform) eq "windows"} {
      return [join $args \\]
    }
  }
  return [oldFile $cmd {*}$args]
}


proc TestHelpers::RestoreEnvVars {} {
  variable storedEnvVars
  if {$storedEnvVars ne {}} {
    dict for {var value} $storedEnvVars {
      if {$value ne ""} {
        set ::env($var) $value
      } else {
        unset -nocomplain ::env($var)
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

proc TestHelpers::UnSetEnvVar {var} {
  variable storedEnvVars
  if {![dict exists $storedEnvVars $var]} {
    if {[info exists ::env($var)]} {
      dict set storedEnvVars $var $::env($var)
    } else {
      dict set storedEnvVars $var ""
    }
  }
  unset -nocomplain ::env($var)
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

proc TestHelpers::RestorePlatform {} {
  variable storedPlatform
  if {$storedPlatform ne ""} {
    set ::tcl_platform(platform) $storedPlatform
    set storedPlatform ""
  }
}

proc TestHelpers::SetPlatform {platform} {
  variable storedPlatform
  if {$storedPlatform eq ""} {set storedPlatform $::tcl_platform(platform)}
  set ::tcl_platform(platform) $platform

}

proc TestHelpers::setEnvironment {os user} {
  switch $os {
    "Linux" {
      SetOS Linux
      SetPlatform unix
      SetEnvVar HOME "/home/$user"
    }
    "Windows 2000" {
      SetOS "Windows NT"
      SetPlatform windows
      SetEnvVar ALLUSERSPROFILE "C:\\ProgramData"
      SetEnvVar APPDATA "C:\\Documents and Settings\\$user\\Application Data"
      SetEnvVar PROGRAMDATA "C:\\ProgramData"
    }
    "Windows Vista" {
      SetOS "Windows NT"
      SetPlatform windows
      SetEnvVar ALLUSERSPROFILE "C:\\ProgramData"
      SetEnvVar APPDATA "C:\\Documents and Settings\\$user\\Application Data"
      SetEnvVar PROGRAMDATA "C:\\ProgramData"
    }
    "Windows XP" {
      SetOS "Windows NT"
      SetPlatform windows
      SetEnvVar ALLUSERSPROFILE "C:\\Documents and Settings\\All Users"
      SetEnvVar APPDATA "C:\\Documents and Settings\\$user\\Application Data"
      UnSetEnvVar PROGRAMDATA
    }
  }
}

proc TestHelpers::restoreEnvironment {} {
  RestoreOS
  RestorePlatform
  RestoreEnvVars
}

proc TestHelpers::countMatches {sequence lambda} {
  llength [struct::list filter $sequence [list apply $lambda]]
}
