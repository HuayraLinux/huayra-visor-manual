VERSION=1.3.2
NOMBRE="huayra-visor-manual"

N=[0m
G=[01;32m
Y=[01;33m
B=[01;34m
L=[01;30m

all:
	@echo ""
	@echo "${B}Comandos disponibles para ${G}${NOMBRE} - ${VERSION}${N}"
	@echo ""
	@echo "  $(G)init$(N)          Instala las dependencias para usar el software."
	@echo "  $(G)actualizar$(N)    Descargar una versión nueva del wiki offline."
	@echo "  $(G)test_mac$(N)      Ejecuta la aplicación en mac-os."
	@echo ""
	@echo "  $(G)patch_version$(N)         Incrementa la versión."
	@echo "  $(G)sincronizar_version$(N)   Sincroniza la versión con el servidor."
	@echo ""
	@echo "  $(G)full$(N)         Actualiza y genera todo el paquete para distribuir."
	@echo ""


full: clean init actualizar

init:
	@echo "${G}instalando dependencias ...${N}"
	@npm install
	npm install grunt-cli grunt grunt-string-replace

_descargar_dump:
	@echo "${G}descargando dump desde el wiki de huayra ...${N}"
	@rm -r -f export
	@rm -r -f export.tar.gz
	wget http://wiki.huayragnulinux.com.ar/export.tar.gz

_descomprimir_dump:
	@echo "${G}descomprimiendo dump ...${N}"
	@tar xzf export.tar.gz

actualizar: _descargar_dump _descomprimir_dump _borrar_imagenes_duplicadas _mover_docs _reducir_dump _borrar_export _limpiar_directorios_vacios
	@echo "${G}Terminaron todos las tareas de actualización.${N}"

_limpiar_directorios_vacios:
	@echo "${G}borrando directorios vacíos ...${N}"
	@find src/documentacion -type d -empty -delete

_borrar_imagenes_duplicadas:
	@echo "${G}borrando imagenes duplicadas ...${N}"
	@python ./borrar_imagenes_duplicadas.py

_mover_docs:
	@echo "${G}moviendo archivos de documentación ...${N}"
	@rm -r -f documentacion
	@rm -r -f src/documentacion
	@mv export documentacion
	@mv documentacion src/
	@cp -r -f src/buscar.html src/documentacion/buscar.html
	@grunt string-replace
	@rm -r -f src/documentacion/images/deleted
	@rm -r -f src/documentacion/images/temp/
	@rm -r -f src/documentacion/images/archive/

_reducir_dump:
	@echo "${G}reduciendo dump ...${N}"
	@python reducir_dump.py

_borrar_export:
	@echo "${G}borrando dump temporal ...${N}"
	@rm -r -f export.tar.gz

test_mac:
	open -a node-webkit src

test:
	echo "..."

patch_version:
	@bumpversion patch --current-version ${VERSION} Makefile --list
	@echo "Es recomendable escribir el comando que genera los tags y sube todo a github:"
	@echo "make sincronizar_version"

sincronizar_version:
	git commit -am 'release ${VERSION}'
	git tag '${VERSION}'
	git push
	git push --all
	git push --tags

clean:
	@echo "${G}limpiando archivos ...${N}"
	@rm -fr documentacion
	@rm -fr src/documentacion
	@rm -fr node_modules
	@rm -fr export.tar.gz

install:
	@echo " < PASO OMITIDO >"
