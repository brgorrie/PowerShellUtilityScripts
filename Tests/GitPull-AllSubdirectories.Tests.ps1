# Enable strict mode
#Set-StrictMode -Version Latest

$parentDirectory = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
Write-Host $parentDirectory

$parentDirectory = $parentDirectory -replace  "\\Tests",""
Write-Host $parentDirectory

$scriptPath = Join-Path -Path $parentDirectory -ChildPath "Scripts\GitPull-AllSubdirectories.ps1"
Write-Host $scriptPath

Describe "GitPull-AllSubdirectories.ps1" {
    Context "When Git is not installed" {
        It "Should throw an error" {
            { $scriptPath } | Should -Throw "Git executable not found. Please make sure Git is installed and in the system's path."
        }
    }

}