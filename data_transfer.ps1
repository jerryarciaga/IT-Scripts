﻿<#
    FileName:       data_transfer.ps1
    Author:         Jerry Arciaga
    Contact:        jerryarciaga11@gmail.com
    Created:        09 Mar 24
    Description:
        This script copies multiple folders from one drive to another using a series of robocopy commands.
#>


#################################################################################
# VARIABLES - Specify the source, destination and a location to store log files #
#################################################################################
$SOURCE = "C:\Users\Jerry"
$DEST = "D:\jerry.bk"
$LOGFOLDER = "D:\logs"
$LOGPROFILE = "jerry.arciaga"

# Folders to copy
$FOLDERS = `
    "Contacts",`
    "Desktop",`
    "Documents",`
    "Downloads",`
    "Favorites",`
    "Links",`
    "Music",`
    "OneDrive",`
    "Pictures",`
    "Videos"

########################## END VARIABLES ########################################

# Create log folders if they don't exist yet.
if (!(Test-Path $LOGFOLDER)) {
    New-Item -ItemType Directory $LOGFOLDER
}
if (!(Test-Path $LOGFOLDER\$LOGPROFILE)) {
    New-Item -ItemType Directory $LOGFOLDER\$LOGPROFILE
}

# Give opportunity to check on specified files.
Write-Host "The following files are ready for transfer:"
foreach ($FOLDER in $FOLDERS) {
    if (Test-Path $SOURCE\$FOLDER) {
        Write-Host "$SOURCE\$FOLDER"
    }
    else {
        Write-Host "$SOURCE\$FOLDER does not exist. Exiting..."
        return
    }
}
pause

# Perform robocopy script for each specified folder.
foreach ($FOLDER in $FOLDERS) {
    robocopy $SOURCE\$FOLDER $DEST\$FOLDER `
        /mt /v /e /zb /xa:e /xx /r:2 /w:2 /tee `
        /copyall `
        /log:$LOGFOLDER\$LOGPROFILE\$FOLDER.copy.log
}