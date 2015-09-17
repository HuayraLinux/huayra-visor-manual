all:
	@echo ""
	@echo "  init          Instala las dependencias para usar el software."
	@echo "  actualizar    Descargar una versión nueva del wiki offline."
	@echo "  test_mac      Ejecuta la aplicación en mac-os."
	@echo "  build         Genera todas las versiones binarias."
	@echo ""

all: init actualizar build

init:
	# npm install # con esto descargamos deps de package.json
	npm install grunt # que no esta empaquetado en .deb

_descargar_dump:
	rm -r -f export
	rm -r -f export.tar.gz
	#wget http://200.55.245.7:89/wiki/export.tar.gz
	wget http://wiki.huayragnulinux.com.ar/export.tar.gz
	tar xzf export.tar.gz

actualizar: _descargar_dump
	rm -r -f documentacion
	rm -r -f src/documentacion
	mv export documentacion
	mv documentacion src/
	cp -r -f src/buscar.html src/documentacion/buscar.html
	grunt string-replace
	rm -r -f src/documentacion/images/deleted
	rm -r -f src/documentacion/images/temp/
	rm -r -f src/documentacion/images/archive/
	python reducir_dump.py
	rm -r -f export.tar.gz

test_mac:
	open -a node-webkit src

test:
	echo "..."

build:
	grunt

clean:
	rm -fr documentacion
	rm -fr src/documentacion
	rm -fr node_modules
	rm -fr export.tar.gz
	
install:
	echo "..."
