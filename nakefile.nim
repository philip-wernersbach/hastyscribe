import nake
from version import v

const
  compile = "nim c -d:release"
  linux_x86 = "--cpu:i386 --os:linux"
  linux_arm = "--cpu:arm --os:linux"
  windows_x86 = "--cpu:i386 --os:windows"
  parallel = "--parallelBuild:1"
  hs = "hastyscribe"
  hs_file = "hastyscribe.nim"
  zip = "zip -X"

proc filename_for(os: string, arch: string): string =
  return "hastyscribe" & "_v" & v & "_" & os & "_" & arch & ".zip"

task "windows-x86-build", "Build HastyScribe for Windows (x86)":
  direshell compile, windows_x86,  hs_file

task "linux-x86-build", "Build HastyScribe for Linux (x86)":
  direshell compile, linux_x86,  hs_file
  
task "linux-arm-build", "Build HastyScribe for Linux (ARM)":
  direshell compile, linux_arm, parallel,  hs_file
  
task "macosx-x86-build", "Build HastyScribe for Mac OS X (x86)":
  direshell compile, hs_file

task "release", "Release HastyScribe":
  echo "\n\n\n WINDOWS - x86:\n\n"
  runTask "windows-x86-build"
  direshell zip, filename_for("windows", "x86"), hs & ".exe"
  direshell "rm", hs & ".exe"
  echo "\n\n\n LINUX - x86:\n\n"
  runTask "linux-x86-build"
  direshell zip, filename_for("linux", "x86"), hs 
  direshell "rm", hs 
  echo "\n\n\n LINUX - ARM:\n\n"
  runTask "linux-arm-build"
  direshell zip, filename_for("linux", "arm"), hs 
  direshell "rm", hs 
  echo "\n\n\n MAC OS X - x86:\n\n"
  runTask "macosx-x86-build"
  direshell zip, filename_for("macosx", "x86"), hs 
  direshell "rm", hs 
  echo "\n\n\n ALL DONE!"
