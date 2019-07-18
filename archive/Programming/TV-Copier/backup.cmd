@echo off
robocopy h:\ n:\backup\public /mir /z /mt:12
robocopy i:\ n:\backup\pictures /mir /z /mt:12
robocopy m:\ n:\backup\music /mir /z /mt:12
robocopy "v:\home movies" "n:\backup\videos\home movies" /mir /z /mt:12
rem pause