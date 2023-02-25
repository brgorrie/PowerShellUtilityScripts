Power Shell Utility Scripts
===========================

This repository contains a collection of powershell scripts that I use in my day to day development activities. 

## Get Started

Clone this repository, and start using the powershell scripts. 

## How to report issues raise feature requests

Head to the jira for the project https://github.com/brgorrie/PowerShellUtilityScripts/issues to raise any issues or feature requests.

## The scripts

### GitPull-AllSubdirectories.ps1

This script will iterate through all the subdirectories of the specified directory or if no parameter is supplied all the subdirectories of the current directory.  It will check if the directory is for a git repository, and that it has a remote configured.  If it does have a remote configured it will then do a git pull to update the local clone of the repository.

Example useage with no path parameter:

```
   PS C:\> cd c:\git
   PS C:\git> .\PowerShellUtilityScripts\Scripts\GitPull-AllSubdirectories.ps1
```   

Example useage with a path parameter:
```
   PS C:\git> cd .\PowerShellUtilityScripts\Scripts\
   PS C:\git\PowerShellUtilityScripts\Scripts> .\GitPull-AllSubdirectories.ps1 c:\git   
```