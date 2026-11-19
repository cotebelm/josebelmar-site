# Actualiza el PDF del CV a partir del proyecto de Overleaf.
# Uso:  .\scripts\build_cv.ps1               (hace git pull de Overleaf y compila)
#       .\scripts\build_cv.ps1 -NoPull       (compila lo que haya en el clon local)
#       .\scripts\build_cv.ps1 -Application  (compila la versión para postulaciones)
#
# Hay dos versiones del CV, ambas desde el mismo proyecto de Overleaf:
#   main.tex        -> versión del sitio web, sin párrafos de resumen. Va a files\Belmar_CV.pdf.
#   application.tex -> versión para postulaciones, con la sección Summary. NO se publica:
#                      queda en Documents\Belmar_CV_application.pdf.
param(
    [string]$CvRepo = (Join-Path $PSScriptRoot '..\..\cv_overleaf'),
    [switch]$NoPull,
    [switch]$Application
)
$ErrorActionPreference = 'Stop'

$site  = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$cv    = (Resolve-Path $CvRepo).Path
$build = Join-Path $env:TEMP 'cv_overleaf_build'

if ($Application) {
    $source = 'application'
    $dest   = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'Belmar_CV_application.pdf'
} else {
    $source = 'main'
    $dest   = Join-Path $site 'files\Belmar_CV.pdf'
}

if (-not $NoPull) {
    git -C $cv pull --ff-only
    if ($LASTEXITCODE -ne 0) { throw "git pull de Overleaf falló" }
}

# Los archivos auxiliares van a una carpeta temporal para no ensuciar el clon de Overleaf.
Push-Location $cv
try {
    latexmk -pdf -interaction=nonstopmode -halt-on-error "-outdir=$build" "$source.tex"
    if ($LASTEXITCODE -ne 0) { throw "latexmk falló; ver $build\$source.log" }
} finally {
    Pop-Location
}

Copy-Item (Join-Path $build "$source.pdf") $dest -Force
Write-Host "CV actualizado: $dest"
