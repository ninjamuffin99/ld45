@echo off
color 0d
cd ..
cd ..
@echo on
lime build windows -release
butler push ./export/release/windows/bin ninja-muffin24/ld45:win
butler status ninja-muffin24/ld45:win
pause