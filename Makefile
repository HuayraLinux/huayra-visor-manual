all:
	@echo ""
	@echo "  init          Instala las dependencias para usar el software."
	@echo "  actualizar    Descargar una versión nueva del wiki offline."
	@echo "  test_mac      Ejecuta la aplicación en mac-os."
	@echo "  build         Compila la descarga actual."
	@echo ""
	@echo "  full          Actualiza y genera todo el paquete para distribuir."
	@echo ""


full: clean init actualizar

init:
	# npm install
	npm install grunt-cli grunt grunt-string-replace
	pip install beautifulsoup4

_descargar_dump:
	rm -r -f export
	rm -r -f export.tar.gz
	#wget http://200.55.245.7:89/wiki/export.tar.gz
	wget http://wiki.huayragnulinux.com.ar/export.tar.gz

_descomprimir_dump:
	tar xzf export.tar.gz

actualizar: _descargar_dump _descomprimir_dump _mover_docs _reducir_dump _borrar_export
	@echo "done"

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
