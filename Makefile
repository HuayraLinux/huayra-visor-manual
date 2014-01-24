all:
	@echo ""
	@echo "  init          Instala las dependencias para usar el software."
	@echo "  actualizar    Descargar una versión nueva del wiki offline."
	@echo "  test_mac      Ejecuta la aplicación en mac-os."
	@echo ""

init:
	npm install

_descargar_dump:
	rm -r -f export
	rm -r -f export.tar.gz
	wget http://200.55.245.7:89/wiki/export.tar.gz
	tar xzf export.tar.gz

actualizar: _descargar_dump
	mv export documentacion
	rm -r -f src/documentacion
	mv documentacion src/
	cp -r -f src/buscar.html src/documentacion/buscar.html
	grunt string-replace

test_mac:
	open -a node-webkit src

test:
	echo "..."

install:
	echo "..."
