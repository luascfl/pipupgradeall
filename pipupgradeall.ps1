# Get a list of outdated packages using pip
$packages = pip list --outdated --format=json | ConvertFrom-Json | ForEach-Object { $_.name }

# Check if any packages are outdated
if (-not $packages) {
    Write-Host "All packages are up to date!"
    exit
}

# Upgrade each outdated package
Write-Host "Upgrading the following packages:"
$packages | ForEach-Object { Write-Host $_ }

# Upgrade each package
foreach ($package in $packages) {
    Write-Host "Upgrading $package..."
    pip install --upgrade $package
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to upgrade $package. Continuing with the next one..."
    }
}

Write-Host "Upgrade process completed."
