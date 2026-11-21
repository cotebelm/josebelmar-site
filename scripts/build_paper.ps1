# Publica en el sitio el PDF de un paper que vive en Overleaf.
# Uso:  .\scripts\build_paper.ps1 -Repo ..\panamacanal_overleaf -Main paper -Name Belmar_Panama_Canal.pdf
#       (agregar -NoPull para compilar lo que haya en el clon local)
#
# Hace git pull del clon de Overleaf, compila con latexmk en una carpeta temporal,
# recomprime las imágenes (scripts\compress_pdf.py) y deja el PDF en files\<Name>.
# El nombre del archivo no cambia entre versiones, así el enlace del sitio y del CV
# sigue sirviendo. Después: commit de files\<Name> y push.
param(
    [Parameter(Mandatory)][string]$Repo,
    [string]$Main = 'paper',
    [Parameter(Mandatory)][string]$Name,
    [int]$Dpi = 150,
    [switch]$NoPull
)
$ErrorActionPreference = 'Stop'

$site  = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$src   = (Resolve-Path $Repo).Path
$build = Join-Path $env:TEMP ("paper_build_" + (Split-Path $src -Leaf))
$dest  = Join-Path $site "files\$Name"

if (-not $NoPull) {
    git -C $src pull --ff-only
    if ($LASTEXITCODE -ne 0) { throw "git pull de Overleaf falló" }
}

Push-Location $src
try {
    latexmk -pdf -interaction=nonstopmode -halt-on-error "-outdir=$build" "$Main.tex"
    if ($LASTEXITCODE -ne 0) { throw "latexmk falló; ver $build\$Main.log" }
} finally {
    Pop-Location
}

python -I (Join-Path $PSScriptRoot 'compress_pdf.py') (Join-Path $build "$Main.pdf") $dest $Dpi
if ($LASTEXITCODE -ne 0) { throw "la compresión del PDF falló" }

$mb = [math]::Round((Get-Item $dest).Length / 1MB, 1)
Write-Host "Paper actualizado: $dest ($mb MB)"
