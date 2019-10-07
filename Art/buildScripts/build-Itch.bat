@echo off
color 0e
cd ..
cd ..
@echo on
echo BUILDING GAME
lime build html5 -release
echo UPLOADING TO ITCH
butler push ./export/html5/bin ninja-muffin24/ld45:html5
butler status ninja-muffin24/ld45:html5
echo MOVING INTO GITHUB FOLDER
del .\docs\*.*
xcopy .\export\html5\bin /E .\docs\
pause