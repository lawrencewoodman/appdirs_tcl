package require tcltest
namespace import tcltest::*

# Add module dir to tm paths
set ThisScriptDir [file dirname [info script]]
set ModuleDir [file normalize [file join $ThisScriptDir ..]]
::tcl::tm::path add $ModuleDir

source [file join $ThisScriptDir test_helpers.tcl]

package require AppDirs

test dataHome-1 {Checks that sensible Linux dataHome directory returned} \
-setup {
  TestHelpers::setEnvironment Linux myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  $myAppDirs dataHome
} -cleanup {
  TestHelpers::restoreEnvironment
} -match regexp -result "$::env(HOME).*?myApp"

test dataHome-2 {Checks that sensible Windows 2000 dataHome directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows 2000" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  $myAppDirs dataHome
} -cleanup {
  TestHelpers::restoreEnvironment
} -match regexp -result {^.*?myUser.*?myBrand\\myApp$}

test dataHome-3 {Checks that sensible Windows Vista dataHome directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows Vista" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  $myAppDirs dataHome
} -cleanup {
  TestHelpers::restoreEnvironment
} -match regexp -result {^.*?myUser.*?myBrand\\myApp$}

test dataHome-4 {Checks that sensible Windows XP dataHome directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows XP" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  $myAppDirs dataHome
} -cleanup {
  TestHelpers::restoreEnvironment
} -match regexp -result {^.*?myUser.*?myBrand\\myApp$}

test configHome-1 {Checks that sensible Linux configHome directory returned} \
-setup {
  TestHelpers::setEnvironment Linux myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  $myAppDirs configHome
} -cleanup {
  TestHelpers::restoreEnvironment
} -match regexp -result "$::env(HOME).*?myApp"

test configHome-2 {Checks that sensible Windows 2000 configHome directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows 2000" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  $myAppDirs configHome
} -cleanup {
  TestHelpers::restoreEnvironment
} -match regexp -result {^.*?myUser.*?myBrand\\myApp$}

test configHome-3 {Checks that sensible Windows Vista configHome directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows Vista" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  $myAppDirs configHome
} -cleanup {
  TestHelpers::restoreEnvironment
} -match regexp -result {^.*?myUser.*?myBrand\\myApp$}

test configHome-4 {Checks that sensible Windows XP configHome directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows XP" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  $myAppDirs configHome
} -cleanup {
  TestHelpers::restoreEnvironment
} -match regexp -result {^.*?myUser.*?myBrand\\myApp$}

test configDirs-1 {Checks that sensible Linux configDirs directory returned} \
-setup {
  TestHelpers::setEnvironment Linux myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  set configDirs [$myAppDirs configDirs]
  TestHelpers::countMatches $configDirs {{configDir} {
    expr {![regexp {^.*myApp$} $configDir]}
  }}
} -cleanup {
  TestHelpers::restoreEnvironment
} -result 0

test configDirs-2 {Checks that sensible Windows 2000 configDirs directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows 2000" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  set configDirs [$myAppDirs configDirs]
  TestHelpers::countMatches $configDirs {{configDir} {
    expr {"$::env(PROGRAMDATA)\\myBrand\\myApp\$" eq $configDir}
  }}
} -cleanup {
  TestHelpers::restoreEnvironment
} -result 0

test configDirs-3 {Checks that sensible Windows Vista configDirs directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows Vista" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  set configDirs [$myAppDirs configDirs]
  TestHelpers::countMatches $configDirs {{configDir} {
    expr {"$::env(PROGRAMDATA)\\myBrand\\myApp\$" eq $configDir}
  }}
} -cleanup {
  TestHelpers::restoreEnvironment
} -result 0

test configDirs-4 {Checks that sensible Windows XP configDirs directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows XP" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  set configDirs [$myAppDirs configDirs]
  TestHelpers::countMatches $configDirs {{configDir} {
    expr {"$::env(ALLUSERSPROFILE)\\myBrand\\myApp\$" eq $configDir}
  }}
} -cleanup {
  TestHelpers::restoreEnvironment
} -result 0

test dataDirs-1 {Checks that sensible Linux dataDirs directory returned} \
-setup {
  TestHelpers::setEnvironment Linux myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  set dataDirs [$myAppDirs dataDirs]
  TestHelpers::countMatches $dataDirs {{configDir} {
    expr {![regexp {^.*myApp$} $configDir]}
  }}
} -cleanup {
  TestHelpers::restoreEnvironment
} -result 0

test dataDirs-2 {Checks that sensible Windows 2000 dataDirs directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows 2000" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  set dataDirs [$myAppDirs dataDirs]
  TestHelpers::countMatches $dataDirs {{configDir} {
    expr {"$::env(PROGRAMDATA)\\myBrand\\myApp\$" eq $configDir}
  }}
} -cleanup {
  TestHelpers::restoreEnvironment
} -result 0

test dataDirs-3 {Checks that sensible Windows Vista dataDirs directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows Vista" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  set dataDirs [$myAppDirs dataDirs]
  TestHelpers::countMatches $dataDirs {{configDir} {
    expr {"$::env(PROGRAMDATA)\\myBrand\\myApp\$" eq $configDir}
  }}
} -cleanup {
  TestHelpers::restoreEnvironment
} -result 0

test dataDirs-4 {Checks that sensible Windows XP dataDirs directory \
returned} -setup {
  TestHelpers::setEnvironment "Windows XP" myUser
  set myAppDirs [AppDirs new myBrand myApp]
} -body {
  set dataDirs [$myAppDirs dataDirs]
  TestHelpers::countMatches $dataDirs {{configDir} {
    expr {"$::env(ALLUSERSPROFILE)\\myBrand\\myApp\$" eq $configDir}
  }}
} -cleanup {
  TestHelpers::restoreEnvironment
} -result 0

cleanupTests
