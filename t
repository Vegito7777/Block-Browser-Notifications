# kill process
Stop-Process -Name msedge -Force -ErrorAction SilentlyContinue

# Get profiles
$profiles = Get-ChildItem -Path "C:\Users" -Directory

# Loop through each user profile
foreach ($profile in $profiles) {
    $cachePath = Join-Path -Path $profile.FullName -ChildPath "AppData\Local\Microsoft\Edge\User Data\Default\Cache\Cache_Data*"

    # Check if the cache path exists
    if (Test-Path $cachePath) {
        # Clear cache data for the current user profile
        Remove-Item -Path $cachePath -Force -Recurse
        Write-Host "Cache data cleared for user profile: $($profile.Name)"
    }
    else {
        Write-Host "Cache data not found for user profile: $($profile.Name)"
    }
}

ps chrome -ErrorAction SilentlyContinue | kill -PassThru
Start-Sleep -Seconds 5
#Main Section
$Items = @(‘Archived History’,
‘Cache*’,
‘Cookies’,
‘History’,
‘Login Data’,
‘Top Sites’,
‘Visited Links’,
‘Web Data’)
$Folder = “$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default”
$Items | % {
if (Test-Path “$Folder$<em>") {
Remove-Item "$Folder$</em> ”-Recurse -Confirm:$false -Force
}
}
