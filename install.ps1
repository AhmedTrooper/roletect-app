# ==============================================================================
# RoleTect - Unified Single-Line Installer for Windows PowerShell
# Repo: https://github.com/AhmedTrooper/roletect-app
#
# Usage:
#   irm https://raw.githubusercontent.com/AhmedTrooper/roletect-app/main/install.ps1 | iex
# ==============================================================================

$ErrorActionPreference = 'Stop'

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host ""
Write-Host "  ____       _     _____           _   " -ForegroundColor Cyan
Write-Host " |  _ \ ___ | | __|_   _|__   ___| |_ " -ForegroundColor Cyan
Write-Host " | |_) / _ \| |/ _ \| |/ _ \ / __| __|" -ForegroundColor Cyan
Write-Host " |  _ < (_) | |  __/| |  __/| (__| |_ " -ForegroundColor Cyan
Write-Host " |_| \_\___/|_|\___||_|\___(_)___|\__|" -ForegroundColor Cyan
Write-Host ""
Write-Host "RoleTect Windows Application Installer" -ForegroundColor White
Write-Host "=======================================" -ForegroundColor Gray

# --- Architecture Detection ---
$arch = "x64"
if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64" -or $env:PROCESSOR_ARCHITEW6432 -eq "ARM64") {
    $arch = "arm64"
}

Write-Host "Detected Architecture: $arch" -ForegroundColor Gray

# --- GitHub Release Lookup ---
$repo = "AhmedTrooper/roletect-app"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"

Write-Host "Fetching latest release from $repo..." -ForegroundColor Cyan

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

try {
    $headers = @{ "User-Agent" = "RoleTect-Installer" }
    $release = Invoke-RestMethod -Uri $apiUrl -Headers $headers -UseBasicParsing
} catch {
    Write-Warning "Could not query GitHub Releases API directly. Falling back to default download channel."
    $release = $null
}

$downloadUrl = $null

if ($release -and $release.assets) {
    if ($arch -eq "arm64") {
        $asset = $release.assets | Where-Object { $_.name -match 'arm64.*\.exe$' -or $_.name -match 'aarch64.*\.exe$' } | Select-Object -First 1
    } else {
        $asset = $release.assets | Where-Object { $_.name -match 'x64.*-setup\.exe$' -or $_.name -match 'x64.*\.msi$' -or $_.name -match '\.exe$' } | Select-Object -First 1
    }

    if ($asset) {
        $downloadUrl = $asset.browser_download_url
    }
}

if (-not $downloadUrl) {
    Write-Error "Could not automatically find a matching release asset for $arch."
    Write-Host "Please download the installer directly from: https://github.com/$repo/releases" -ForegroundColor Yellow
    exit 1
}

$tempInstaller = Join-Path $env:TEMP "RoleTect-Setup.exe"

Write-Host "Downloading installer: $downloadUrl" -ForegroundColor Cyan
Invoke-WebRequest -Uri $downloadUrl -OutFile $tempInstaller -UseBasicParsing

Write-Host "Launching RoleTect Setup..." -ForegroundColor Green

# Launch installer
Start-Process -FilePath $tempInstaller -Wait

# Cleanup installer file
if (Test-Path $tempInstaller) {
    Remove-Item -Path $tempInstaller -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "✔ RoleTect has been installed successfully!" -ForegroundColor Green
Write-Host "You can now launch RoleTect from your Start Menu or Desktop shortcut." -ForegroundColor White
Write-Host ""
