#!/bin/sh

#Las plantillas de la wiki
find src/documentacion/ -type d -iname "Plantilla:*" -exec rm -r {} +
find src/documentacion/ -iname "Plantilla:*.html" -delete

#Por ahora sólo matchea el índice de categorías que se exporta
find src/documentacion/ -iname "Especial:*.html" -delete

#Usuarios que se armaron una página de perfil
find src/documentacion/ -iname "Usuario:*.html" -delete

#Plantillas que por alguna razón no llevan el prefijo 'Plantilla:'
rm src/documentacion/articles/e/s/c/1.0:Escritorio/box-footer.html
rm src/documentacion/articles/e/s/c/1.0:Escritorio/Box-footer.html
rm src/documentacion/articles/e/s/c/1.0:Escritorio/box-header.html

#Ayuda sobre como editar la wiki
rm src/documentacion/articles/c/o/n/Ayuda:Contenidos.html

#Una página de discusión de la wiki, no tengo suficientes iguales como para ver cuál es el patrón para el nombramiento
rm src/documentacion/articles/i/n/s/3.0_talk:Instalación.html

#Borrar carpetas vacías
find src/documentacion/ -type d -empty -delete


