:: list all .csv files in the directory (and nested directories) and save the list to list_files.txt.
dir /s /b \\wsl.localhost\Ubuntu\home\work\*.csv > \\wsl.localhost\Ubuntu\home\work\list_files.txt

:: enable delayed variable expansion; for runtime evaluation within loops and conditionals
:: It is used when dealing with variables that change within a loop or conditional block
setlocal enabledelayedexpansion

:: create some environment variables
set list_files=\\wsl.localhost\Ubuntu\home\work\list_files.txt
set oldPathPart=\\wsl.localhost\Ubuntu\home\work
set newPathPart=\\dataserver\Groups\Group_AI\Shoaib\Data
set logFile=\\wsl.localhost\Ubuntu\home\work\logfile.txt

:: Clear the log file at the start
echo Log Start > "%logFile%"

:: run a for loop over each line in the list_files.txt
for /f "usebackq delims=" %%A in ("%list_files%") do (
    :: read line and store into "source"
    set "source=%%A"
    :: replace some part of the "source" and save new string into "destination" 
    set "destination=!source:%oldPathPart%=%newPathPart%!"
    :: extract the directory path from a full path (path with file name)
    for %%I in (!destination!) do set "dirPath=%%~dpI"
    :: create path "dirPath" if it does not exist
    if not exist !dirPath! mkdir !dirPath!
    :: write value of "dirPath" into logfile
    echo Directory path: !dirPath! >> %logFile% 2>&1
    :: write value of "dirPath" into logfile
    echo Source: !source! >> %logFile% 2>&1
    :: write value of "source" into logfile
    echo Destination: !destination! >> %logFile% 2>&1
    :: write value of "destination" into logfile
    scp !source! !destination! >> %logFile% 2>&1
    :: write into logfile
    echo ====================  >> %logFile% 2>&1
)

:: end the setlocal block and restore previous environment settings
endlocal

:: pause execution and waitsfor user input to continue
pause
