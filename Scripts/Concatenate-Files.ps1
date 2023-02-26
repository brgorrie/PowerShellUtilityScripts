<#
   .SYNOPSIS
   Takes a file extension as a parameter, finds all files with that extension in the current directory and subdirectories, and then combines them all into a single text file.

   .DESCRIPTION
   This script takes an optional parameter which can specify a file extension, if one isn't specified then *.cs files are what is searched for.
   The script searches for files with that extension in the current directory and all subdirectories concatenating them together into a *.txt file in the specified output directory.
   The output file name is in the following format All[FileExtension]Files_YYYY-MM-DD_HH-mm-ss.txt for example AllCsFiles_2023-02-25_22-50-14.txt
   
   Example useage to concatenate all *.cs files in a repo:
   PS C:\> cd c:\git\DiceRoller
   PS C:\git\DiceRoller> .\PowerShellUtilityScripts\Scripts\Concetenate-Files.ps1 -FileExtension cs -OutputDirectory C:\output
   
   .PARAMETER FileExtension
   Optional parameter that specifies the file extension to search for and concatenate.  If not specified then the script defaults to *.cs files. 
   
   .PARAMETER OutputDirectory
   Optional parameter that specifies the output directory for the concatenated file. If not specified then the default directory is C:\git.
   
   .NOTES
   Author: Brian Gorrie 

   .LICENSE
   Copyright 2023 Brian Gorrie

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

	   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
#>

param (
    [string]$FileExtension = "cs",
    [string]$OutputDirectory = "C:\git"
)

# Define variables for the output file and Git executable path
$outputFileName = "All${FileExtension^}Files_" + (Get-Date -Format "yyyy-MM-dd_HH-mm-ss") + ".txt"
$outputFilePath = Join-Path -Path $OutputDirectory -ChildPath $outputFileName

# Check if the output directory exists and is a folder
if (!(Test-Path -Path $OutputDirectory -PathType Container)) {
    Write-Error "Output directory $OutputDirectory does not exist or is not a folder."
    return
}

# Check if the output file already exists
if (Test-Path -Path $outputFilePath) {
    Write-Warning "Output file $outputFilePath already exists. Appending to the file."
}

# Concatenate all .cs files in the directory and its subdirectories
Get-ChildItem -Path . -Recurse -Include "*.$FileExtension" | ForEach-Object {
    Get-Content $_.FullName -Delimiter "`n" | Out-File -FilePath $outputFilePath -Encoding utf8 -Append -NoNewline -Force
    "`n" | Out-File -FilePath $outputFilePath -Encoding utf8 -Append -NoNewline
}

Write-Host "All .$FileExtension files concatenated and saved to $outputFilePath."