#!/bin/env tclsh
# Lists the default directories for various platforms and
# lists the directories being used for the current system.

# Add module dir to tm paths
set ThisScriptDir [file dirname [info script]]
set ModuleDir [file normalize [file join $ThisScriptDir ..]]
set TestDir [file normalize [file join $ThisScriptDir .. tests]]
::tcl::tm::path add $ModuleDir

source [file join $TestDir test_helpers.tcl]

package require AppDirs

proc listDirs {operatingSystemHeader} {
  puts "\n\n$operatingSystemHeader:"

  set myAppDirs [AppDirs new myBrand myApp]
  puts "    dataHome:    [$myAppDirs dataHome]"
  puts "    configHome:  [$myAppDirs configHome]"
  puts "    dataDirs:    [$myAppDirs dataDirs]"
  puts "    configDirs:  [$myAppDirs configDirs]"
}

set operatingSystems {
  Linux
  {Windows 2000}
  {Windows Vista}
  {Windows XP}
  Darwin
}

puts ""
puts "The following shows the current values being used by AppDirs."
listDirs "Current Operating System"

puts "\n"
puts "Below are listed the default directories used by the module AppDirs for"
puts "various operating systems.  The listings are using 'myUser' as the user"
puts "'myBrand' as the brand and 'myApp' as the name of the application."
puts ""
puts "Please note that these directories can change depending on how"
puts "environmental variables are set."

foreach operatingSystem $operatingSystems {
  TestHelpers::setEnvironment $operatingSystem myUser
  listDirs $operatingSystem
  TestHelpers::restoreEnvironment
}

puts "\n"
