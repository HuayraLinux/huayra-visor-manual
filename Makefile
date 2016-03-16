N=[0m
V=[01;32m

all:
	@echo ""
	@echo "  $(V)init$(N)          Instala las dependencias para usar el software."
	@echo "  $(V)actualizar$(N)    Descargar una versión nueva del wiki offline."
	@echo "  $(V)test_mac$(N)      Ejecuta la aplicación en mac-os."
	@echo ""
	@echo "  $(V)full$(N)         Actualiza y genera todo el paquete para distribuir."
	@echo ""


full: clean init actualizar

init:
	# npm install
	npm install grunt-cli grunt grunt-string-replace
	#sudo pip install beautifulsoup4

_descargar_dump:
	@rm -r -f export
	@rm -r -f export.tar.gz
	#wget http://200.55.245.7:89/wiki/export.tar.gz
	wget http://wiki.huayragnulinux.com.ar/export.tar.gz

_descomprimir_dump:
	tar xzf export.tar.gz

actualizar: _descargar_dump _descomprimir_dump _borrar_imagenes_duplicadas _mover_docs _reducir_dump _borrar_export _limpiar_directorios_vacios
	@echo "done"

_limpiar_directorios_vacios:
	find src/documentacion -type d -empty -delete

_borrar_imagenes_duplicadas:
	python ./borrar_imagenes_duplicadas.py

_mover_docs:
	rm -r -f documentacion
	rm -r -f src/documentacion
	mv export documentacion
	mv documentacion src/
	cp -r -f src/buscar.html src/documentacion/buscar.html
	grunt string-replace
	rm -r -f src/documentacion/images/deleted
	rm -r -f src/documentacion/images/temp/
	rm -r -f src/documentacion/images/archive/

_reducir_dump:
	python reducir_dump.py

_borrar_export:
	rm -r -f export.tar.gz

test_mac:
	open -a node-webkit src

test:
	echo "..."

clean:
	rm -fr documentacion
	rm -fr src/documentacion
	rm -fr node_modules
	rm -fr export.tar.gz

install:
	echo "..."
