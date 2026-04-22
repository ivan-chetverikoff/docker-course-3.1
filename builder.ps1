param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$GitHubRepo,
    [Parameter(Mandatory=$true, Position=1)]
    [string]$DockerHubRepo
)

$ErrorActionPreference = "Stop"

Write-Host "Cloning: https://github.com/$GitHubRepo.git"
$TempDir = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

try {
    git clone --depth 1 "https://github.com/$GitHubRepo.git" $TempDir
    if ($LASTEXITCODE -ne 0) { throw "Clone failed" }

    Push-Location $TempDir

    if (-not (Test-Path "Dockerfile")) {
        throw "Dockerfile not found in repo root"
    }

    $ImageName = $DockerHubRepo.ToLower()
    Write-Host "Building: $ImageName"
    docker build -t $ImageName .
    if ($LASTEXITCODE -ne 0) { throw "Docker build failed" }

    Write-Host "Pushing to Docker Hub: $ImageName"
    docker push $ImageName
    if ($LASTEXITCODE -ne 0) { throw "Docker push failed (check docker login)" }

    Pop-Location
    Write-Host "SUCCESS! Image $ImageName published."
}
finally {
    Write-Host "Cleaning temp..."
    if (Test-Path $TempDir) { Remove-Item -Path $TempDir -Recurse -Force }
}
