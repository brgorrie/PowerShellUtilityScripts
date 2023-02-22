# Enable strict mode
Set-StrictMode -Version Latest

# Get the current directory
$currentDirectory = Get-Location

# Get all subdirectories of the current directory
$subDirectories = Get-ChildItem -Directory

# Loop through each subdirectory and execute git pull if it's a git repository
foreach ($subDirectory in $subDirectories) {
    try {
        # Change the current directory to the subdirectory
        Set-Location $subDirectory.FullName

		Write-Host
		Write-Host "Checking if there is a repository to update at $subDirectory" 

        # Check if the current directory is a git repository
        if (Test-Path -Path ".git" -PathType Container) {
            # Check for the git executable
            if (!(Get-Command git -ErrorAction SilentlyContinue)) {
                throw "Git executable not found. Please make sure Git is installed and in the system's path."
            }
            
            # Execute git pull if it's a git repository
            git pull
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
