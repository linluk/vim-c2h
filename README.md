C2H
===

*C2H* is a small vim Plugin to switch between source `c` and header `h` files.
To switch between them simply type `<leader>ch` or `:C2H`.

Usage
=====

  Command                    |  Effect
  ---------------------------|---------------------------------------------
  <leader>ch  or  :C2H       |  switch between source and header file
  :C2HAbout                  |  prints this help text
  :C2HRegister <arg1> <arg2> |  registers corresponding source and header extensions
  :C2HClear                  |  removes all file extension mappings
  :C2HReset                  |  resets all file extension mappings

Default Extension Mappings
==========================

C2H lets you jump ...

  ... From ...|... To ...
  ------------|-----------
  .H|.C, .CPP, .CC, .CXX
  .C|.H
  .c|.h
  .cxx|.h, .hpp
  .CXX|.H, .HPP
  .HPP|.CPP, .CC, .CXX
  .h|.c, .cpp, .cc, .cxx
  .cc|.h, .hpp
  .CC|.H, .HPP
  .cpp|.h, .hpp
  .hpp|.cpp, .cc, .cxx
  .CPP|.H, .HPP

... by default.

Bugs? Features?
===============
feel free to open an issue or send a pull request.

