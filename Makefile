all:
	@echo "test                        Ejecuta una prueba de la aplicación sobre linux."
	@echo "test_mac                    Ejecuta una prueba de la aplicación."
	@echo "build                       Compila la aplicación para varias plataformas."
	@echo "actualizar_documentacion    Actualiza la documentación desde el wiki."

test_mac:
	@echo "Cuidado - se está usando la version de nodewebkit del sistema."
	open -a node-webkit.app src

test:
	./dist/node-webkit-v0.7.3-linux-ia32/nw src

build:
	grunt nodewebkit

actualizar_documentacion:
	rm -f export.tar.gz
	rm -rf mirror_documentacion
	rm -rf export
	wget http://200.55.245.7:89/wiki/export.tar.gz
 	rm -r -f src/documentacion
	tar xzf export.tar.gz
	mv export mirror_documentacion
	cp -rf ./mirror_documentacion src/documentacion
	cp src/buscar.html src/documentacion/
	grunt string-replace
