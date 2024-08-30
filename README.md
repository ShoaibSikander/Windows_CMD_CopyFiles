# Windows_CMD_CopyFiles
This repository shows how we can use a .cmd script to copy all files in nested directories from one location to another.

The are several csv files prsent in a set of nested directories and we want them all to be copied to some other location with exact same nested directory structure. This script first of all prepares a list of all such files and writes them into a file 'list_files.txt'. Then we loop over each line of the file, doing following:
- read complete path to a file (this location is the source from where to copy)
- replace initial part of the directory structure (this location is the destination where to copy)
- extract directory structure of the destination path (remove the filename from destination path)
- Create the destination path if it does not exist
- Copy file from source to destination

Output of the script is written into a logfile.
