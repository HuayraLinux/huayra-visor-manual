all:
	@echo "test       Ejecuta una prueba de la aplicación."
	@echo "build      Compila la aplicación para varias plataformas."

test:
	@echo "Cuidado - se está usando la version de nodewebkit del sistema."
	open -a node-webkit.app src

build:
	grunt nodewebkit
