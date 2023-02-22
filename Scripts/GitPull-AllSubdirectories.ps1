# Get the current directory
$currentDirectory = Get-Location

# Get all subdirectories of the current directory
$subDirectories = Get-ChildItem -Directory

# Loop through each subdirectory and execute git pull if it's a git repository
foreach ($subDirectory in $subDirectories) {
    # Change the current directory to the subdirectory
    Set-Location $subDirectory.FullName

    # Check if the current directory is a git repository
    if (Test-Path -Path ".git" -PathType Container) {
        # Execute git pull if it's a git repository
        git pull
    }

    # Change the current directory back to the original directory
    Set-Location $currentDirectory
}
