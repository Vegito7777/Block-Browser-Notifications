# Kill the Microsoft Edge process if it is running
Stop-Process -Name "msedge" -Force -ErrorAction SilentlyContinue

# Get user profiles in C:\Users
$profiles = Get-ChildItem -Path "C:\Users" -Directory

# Loop through each user profile to clear Edge cache
foreach ($profile in $profiles) {
    $cachePath = Join-Path -Path $profile.FullName -ChildPath "AppData\Local\Microsoft\Edge\User Data\Default\Cache\Cache_Data*"

    # Check if the cache path exists
    if (Test-Path -Path $cachePath) {
        # Clear cache data for the current user profile
        Remove-Item -Path $cachePath -Force -Recurse
        Write-Host "Cache data cleared for user profile: $($profile.Name)"
    }
    else {
        Write-Host "Cache data not found for user profile: $($profile.Name)"
    }
}

# Kill the Google Chrome process if it is running
Get-Process -Name "chrome" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 5

# Define the items to be cleared from Chrome's user data
$items = @(
    "Archived History",
    "Cache*",
    "Cookies",
    "History",
    "Login Data",
    "Top Sites",
    "Visited Links",
    "Web Data"
)

# Define the path to Chrome's default user data folder
$folder = "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default"

# Loop through each item and delete it if it exists
foreach ($item in $items) {
    $itemPath = Join-Path -Path $folder -ChildPath $item
    if (Test-Path -Path $itemPath) {
        Remove-Item -Path $itemPath -Recurse -Force
        Write-Host "Cleared: $item"
    }
    else {
        Write-Host "Not found: $item"
    }
}
