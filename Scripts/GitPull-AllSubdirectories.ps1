# Enable strict mode
Set-StrictMode -Version Latest

# Check for the git executable
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git executable not found. Please make sure Git is installed and in the system's path."
}

# Get the current directory
$currentDirectory = Get-Location

# Get all subdirectories of the current directory
$subDirectories = Get-ChildItem -Directory

# Loop through each subdirectory and execute git pull if it's a git repository
foreach ($subDirectory in $subDirectories) {
    try {
        # Change the current directory to the subdirectory
        Set-Location -LiteralPath $subDirectory.FullName

        Write-Host
        Write-Host "Checking if there is a repository to update at $($subDirectory.FullName)" 

        # Check if the current directory is a git repository
        if (Test-Path -LiteralPath ".git" -PathType Container) {
            # Check if there is a remote configured for the repository
            $remote = (git remote -v)

            if ($remote -ne $null -and $remote.Count -gt 0) {
                Write-Host "Retrieving updates from $($remote)" 
                # Execute git pull if there is a remote configured for the repository
                git pull
            }
            else {
                Write-Host "The repository at $($subDirectory.FullName) has no remote configured."
            }
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