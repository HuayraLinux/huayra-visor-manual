all:
	@echo "test                        Ejecuta una prueba de la aplicación."
	@echo "build                       Compila la aplicación para varias plataformas."
	@echo "actualizar_documentacion    Actualiza la documentación desde el wiki."

test:
	@echo "Cuidado - se está usando la version de nodewebkit del sistema."
	open -a node-webkit.app src

build:
	grunt nodewebkit

actualizar_documentacion:
	rm -r -f src/documentacion
	cp -rf ./mirror_documentacion src/documentacion
	cp src/buscar.html src/documentacion/
	#mv ~/vms/dokuwiki/documentacion src/
	grunt string-replace
