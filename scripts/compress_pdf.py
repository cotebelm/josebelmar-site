"""Recomprime las imágenes de un PDF para publicarlo en la web.

Uso: python -I compress_pdf.py entrada.pdf salida.pdf [dpi]

Baja a `dpi` (150 por defecto) las imágenes que lo superan y las guarda como JPEG
de calidad 80. El texto y los gráficos vectoriales no se tocan. El paper de Panamá
pasa de 136 MB a ~7 MB sin diferencia visible en los mapas.
"""
import sys

import pymupdf

src, dst = sys.argv[1], sys.argv[2]
dpi = int(sys.argv[3]) if len(sys.argv) > 3 else 150

doc = pymupdf.open(src)
doc.rewrite_images(dpi_threshold=dpi + 10, dpi_target=dpi, quality=80,
                   lossy=True, lossless=True)
doc.save(dst, garbage=4, deflate=True, clean=True)
