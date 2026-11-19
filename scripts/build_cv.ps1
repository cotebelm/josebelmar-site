# Actualiza el PDF del CV a partir del proyecto de Overleaf.
# Uso:  .\scripts\build_cv.ps1          (hace git pull de Overleaf y compila)
#       .\scripts\build_cv.ps1 -NoPull  (compila lo que haya en el clon local)
param(
    [string]$CvRepo = (Join-Path $PSScriptRoot '..\..\cv_overleaf'),
    [switch]$NoPull
)
$ErrorActionPreference = 'Stop'

$site  = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$cv    = (Resolve-Path $CvRepo).Path
$build = Join-Path $env:TEMP 'cv_overleaf_build'
$dest  = Join-Path $site 'files\Belmar_CV.pdf'

if (-not $NoPull) {
    git -C $cv pull --ff-only
    if ($LASTEXITCODE -ne 0) { throw "git pull de Overleaf falló" }
}

# Los archivos auxiliares van a una carpeta temporal para no ensuciar el clon de Overleaf.
Push-Location $cv
try {
    latexmk -pdf -interaction=nonstopmode -halt-on-error "-outdir=$build" main.tex
    if ($LASTEXITCODE -ne 0) { throw "latexmk falló; ver $build\main.log" }
} finally {
    Pop-Location
}

Copy-Item (Join-Path $build 'main.pdf') $dest -Force
Write-Host "CV actualizado: $dest"
