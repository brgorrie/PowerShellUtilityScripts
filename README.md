Power Shell Utility Scripts
===========================

This repository contains a collection of powershell scripts that I use in my day to day development activities. 

## Get Started

Clone this repository, and start using the powershell scripts. 

## How to report issues raise feature requests

Head to the jira for the project https://github.com/brgorrie/PowerShellUtilityScripts/issues to raise any issues or feature requests.

## The scripts

### GitPull-AllSubdirectories.ps1

#### Description
This script will iterate through all the subdirectories of the specified directory or if no parameter is supplied all the subdirectories of the current directory.  It will check if the directory is for a git repository, and that it has a remote configured.  If it does have a remote configured it will then do a git pull to update the local clone of the repository.

#### Parameter: path
Optional parameter that specifies the path to the directory containing subdirectories to check. Defaults to the current directory if no parameters are specified.

#### Example useage with no path parameter

```
   PS C:\> cd c:\git
   PS C:\git> .\PowerShellUtilityScripts\Scripts\GitPull-AllSubdirectories.ps1
```   

#### Example useage with a path parameter
```
   PS C:\git> cd .\PowerShellUtilityScripts\Scripts\
   PS C:\git\PowerShellUtilityScripts\Scripts> .\GitPull-AllSubdirectories.ps1 c:\git   
```

### Concatenate-Files.ps1

#### Description
This script takes three optional parameters:
  - FileExtension: Specifies the file extension to search for and concatenate. If not specified, then the script defaults to "*.cs" files.
  - OutputDirectory: Specifies the output directory for the concatenated file. If not specified, then the default directory is "C:\git".
  - SearchDirectory: Specifies the directory to search for files with the specified extension. If not specified, then the current directory is used.

The script searches for files with the specified extension in the specified directory and all subdirectories, concatenating them together into a \*.txt file in the specified output directory. The output file name is in the following format: All[FileExtension]Files_YYYY-MM-DD_HH-mm-ss.txt, for example, AllCsFiles_2023-02-25_22-50-14.txt.

#### Parameter FileExtension
Optional parameter that specifies the file extension to search for and concatenate. If not specified, then the script defaults to "*.cs" files.

#### Parameter OutputDirectory
Optional parameter that specifies the output directory for the concatenated file. If not specified, then the default directory is "C:\git".

#### Parameter SearchDirectory
Optional parameter that specifies the directory to search for files with the specified extension. If not specified, then the current directory is used.

#### Example usage to concatenate all *.cs files in a repo with no parameters
```
PS C:\> cd c:\git\DiceRoller
PS C:\git\DiceRoller> C:\git\PowerShellUtilityScripts\Scripts\Concetenate-Files.ps1 -FileExtension cs 
```

#### Example useage with parameters
```
PS C:\> cd c:\git\PowerShellUtilityScripts\Scripts\
PS C:\git\PowerShellUtilityScripts\Scripts> .\Concetenate-Files.ps1 -FileExtension cs -OutputDirectory C:\output -SearchDirectory C:\git\DiceRoller
```

