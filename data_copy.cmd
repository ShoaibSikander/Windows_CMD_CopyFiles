dir /s /b \\wsl.localhost\Ubuntu\home\work\*.csv > \\wsl.localhost\Ubuntu\home\work\list_files.txt

setlocal enabledelayedexpansion

set "list_files=\\wsl.localhost\Ubuntu\home\work\list_files.txt"
set "oldPathPart=\\wsl.localhost\Ubuntu\home\work"
set "newPathPart=\\dataserver\Groups\Group_AI\Shoaib\Data"

for /f "usebackq delims=" %%A in ("%list_files%") do (
    set "source=%%A"
    set "destination=!source:%oldPathPart%=%newPathPart%!"
    for %%I in (!destination!) do set "dirPath=%%~dpI"
    if not exist !dirPath! mkdir !dirPath!
    echo Directory path: !dirPath!
    echo Source: !source!
    echo Destination: !destination!
    scp !source! !destination!
)

endlocal
pause