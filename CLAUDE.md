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

## Comandos

- Previsualizar: `quarto preview`
- Compilar: `quarto render` (salida en `_site/`, ignorada por git)
- Actualizar CV: `.\scripts\build_cv.ps1`, luego commit de `files/Belmar_CV.pdf`
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
  casa); respaldo local en `~/repos/josebelmar-site-history-backup.bundle`. El
  cambio de DNS del dominio lo hace José en su registrador; no tocar el dominio
  sin confirmación explícita.
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

- Confirmaciones de José sobre papers (títulos, coautores, estados) y PDF propio del
  paper de Panamá para alojarlo en `files/` en vez de Drive.
- Revisión de José del sitio publicado; luego dominio propio (`www.josebelmar.com`)
  y cambio de DNS, y retirar el Google Sites.
