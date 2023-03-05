<#

   .SYNOPSIS
   Updates Git repositories in subdirectories of the specified directory or the current directory.

   .DESCRIPTION
   This script identifies subdirectories of either the directory passed in or the current directory that are Git repositories 
   and updates them with the latest changes from the upstream remote using `git pull`.
   
   Example useage with no path parameter:
   PS C:\> cd c:\git
   PS C:\git> .\PowerShellUtilityScripts\Scripts\GitPull-AllSubdirectories.ps1
   
   Example useage with a path parameter:
   PS C:\git> cd .\PowerShellUtilityScripts\Scripts\
   PS C:\git\PowerShellUtilityScripts\Scripts> .\GitPull-AllSubdirectories.ps1 c:\git   

   .PARAMETER path
   Optional parameter that specifies the path to the directory containing subdirectories to check. Defaults to the current directory if no parameters are specified.

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

# Enable strict mode
Set-StrictMode -Version Latest

# Check for the git executable
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git executable not found. Please make sure Git is installed and in the system's path."
}

# Get the current directory
$currentDirectory = Get-Location

# If a path was passed in use that otherwise use the currentDirectory
$path = $currentDirectory
if (-not $args.Count -eq 0) {
    $path = $args[0]
}

# Get all subdirectories of the current directory
$subDirectories = Get-ChildItem -Path $path -Directory -ErrorAction Stop

# Loop through each subdirectory and execute git pull if it's a git repository
foreach ($subDirectory in $subDirectories) {
    try {
        # Change the current directory to the subdirectory
        Set-Location -LiteralPath $subDirectory.FullName

        # Check if there is a repository to update
		Write-Output 
        Write-Output "Checking if $($subDirectory.Name) is a Git repository" 
        if (Test-Path -LiteralPath ".git" -PathType Container) {

            # Check if there is a remote configured for the repository
            $remote = (git remote -v)

            if ($null -ne $remote -and $remote.Count -gt 0) {
                Write-Output "Updating $($subDirectory.Name) from $($remote)"
                # Execute git pull if there is a remote configured for the repository
                git pull
            }
            else {
                Write-Output "The repository $($subDirectory.Name) has no remote configured."
            }
        }
        else {
            Write-Output "$($subDirectory.Name) is not a Git repository."
        }
    }
    catch {
        Write-Error $_.Exception.Message
    }
    finally {
        # Change the current directory back to the original directory
        Set-Location $currentDirectory
    }
}
