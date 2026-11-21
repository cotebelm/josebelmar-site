# josebelmar-site

Página web personal y CV de José Belmar. Creado el 18-11-2026.

## Qué es

- **Sitio**: Quarto. Portada (`index.qmd`) con bio y papers destacados; Research
  (`research.qmd`) agrupado en Working Papers / Selected Work in Progress, con
  abstract desplegable. Ambas páginas se generan desde **`papers.yml`** (fuente de
  verdad de los papers) con las plantillas de `_templates/`. Formato elegido tras un
  benchmark de 14 sitios de economistas (18-11-2026): sobrio, sin figuras por paper,
  nota de que las opiniones no son del BID.
- **CV**: se mantiene en LaTeX en Overleaf (fuente de verdad), clonado como repo
  hermano `~/repos/cv_overleaf` (mismo patrón que `defensa_overleaf`). No editar el
  CV acá. `scripts/build_cv.ps1` hace pull de Overleaf, compila con `latexmk` en una
  carpeta temporal y copia el PDF a `files/Belmar_CV.pdf`, que sí se versiona
  (el CI no compila LaTeX).

- **Dos versiones del CV** (desde 19-11-2026), ambas del mismo proyecto de Overleaf:
  `main.tex` es la del sitio (sin párrafos de resumen, solo "Research Fields") y es la
  única que se publica; `application.tex` es la de postulaciones (sección "Summary"
  con investigación y trabajo en el BID). `.\scripts\build_cv.ps1 -Application` la
  deja en `Documents\Belmar_CV_application.pdf`; nunca va a `files/`.

- **PDFs de papers** (desde 21-11-2026): se alojan en `files/` con nombre fijo, no en
  Drive, para que el enlace del sitio, del CV y el "Link to Latest Version" del propio
  paper no cambien entre versiones. `scripts/build_paper.ps1` hace pull del clon de
  Overleaf, compila y recomprime las imágenes con `scripts/compress_pdf.py` (PyMuPDF,
  150 dpi). Paper de Panamá: `..\panamacanal_overleaf`, `paper.tex` →
  `files/Belmar_Panama_Canal.pdf` (136 MB sin comprimir, ~6 MB comprimido; GitHub
  rechaza archivos de más de 100 MB).

## Comandos

- Previsualizar: `quarto preview`
- Compilar: `quarto render` (salida en `_site/`, ignorada por git)
- Actualizar CV: `.\scripts\build_cv.ps1`, luego commit de `files/Belmar_CV.pdf`
- Actualizar el paper de Panamá:
  `.\scripts\build_paper.ps1 -Repo ..\panamacanal_overleaf -Main paper -Name Belmar_Panama_Canal.pdf`,
  luego commit del PDF
- Quarto está instalado en versión portable, fuera del PATH:
  `%LOCALAPPDATA%\Programs\Quarto\bin\quarto.exe`
- Publicación: `.github/workflows/publish.yml` compila y despliega a GitHub Pages
  en cada push a `main` (requiere que Pages esté activado en el repo).

## Decisiones

- **Ubicación**: `~/repos/`, fuera de Dropbox — no aplica la exclusión de `.git`.
- **Hosting**: GitHub Pages vía Actions, para reemplazar el Google Sites en
  `www.josebelmar.com` (decidido el 18-11-2026). Repo público y Pages activado el 19-11-2026;
  vista previa en https://cotebelm.github.io/josebelmar-site/. El historial se
  reescribió ese día en un solo commit (el primero traía un CV con la dirección de
  casa); respaldo local en `~/repos/josebelmar-site-history-backup.bundle`. Dominio
  migrado el 19-11-2026: en Squarespace Domains (cuenta Google de José) el CNAME
  `www` apunta a `cotebelm.github.io`; el apex `josebelmar.com` sigue con la
  redirección de Squarespace a `www`. HTTPS forzado. Si GitHub no emite el
  certificado tras ~1 h, quitar y volver a poner el dominio en Pages lo destraba.
  No tocar el DNS sin confirmación explícita de José.
- **Skills / agents**: no se copió nada a `.claude/` del proyecto ni desde el
  upstream `claude-code-my-workflow`. Es un sitio estático chico; bastan las skills
  de nivel usuario. Revisar solo si aparece un flujo repetitivo (p. ej. sincronizar
  la lista de papers con el CV).

## Reglas de contenido

- Sitio y CV deben listar los mismos papers: al cambiar `papers.yml`, actualizar
  también `cv_overleaf/sections/projects_titles.tex`, y viceversa.
- CV en formato académico: sin párrafo de perfil, sin viñetas de funciones, sin
  dirección de casa, referencias en la primera página.
- No publicar información interna de proyectos (rechazos, presupuestos, códigos de
  operación del BID, estados de envío sin confirmar con José).

## Pendientes

- Confirmaciones de José sobre papers (títulos, coautores, estados).
- Retirar el Google Sites (ya no recibe el dominio; no hay apuro).
