# -*- encoding: utf-8 -*-
import re
import os

from bs4 import BeautifulSoup

def find(path):
    """Similar al comando find, pero retorna un generador."""
    for root, folders, files in os.walk(path):
        for filename in folders + files:
            path_completo = os.path.join(root, filename)
            if os.path.isfile(path_completo):
                yield path_completo

def listar_archivos_html():
    "Emite un listado con la ruta completa a todos los archivos .html"
    for file in find('src/documentacion'):
        if file.endswith('.html'):
            yield file

def listar_imagenes_en_disco():
    """Retorna una lista con las rutas completas
    a las imágenes miniaturas.

    Por ejemplo, una invocación podría retornar algo
    así:

        >>> listar_imagenes_en_disco()
        [
            'src/documentacion/images/thumb/0/00/Mix5.jpg/111px-Mix5.jpg',
            ...

    """
    for file in find('src/documentacion/images/thumb'):
        if file.endswith('.jpg') or file.endswith('.png'):
            yield file

def eliminar_atributos_srcset(texto):
    """Elimina el atributo srcset dado un string de texto
    html.

    Un ejemplo, antes de ejecutar esta función podríamos tener:

        "texto <img src='algo.jpg' srcset='algo1x.jpg 1x algo2.jpg..'>b"

    y después de invocar a esta función recibiríamos:

        "texto <img src='algo.jpg' >b"
    """
    return re.sub(r'srcset=".[^"]*"', r"srcset=''", texto)

def obtener_solo_nombre_de_imagenes(lista_de_archivos):
    return [os.path.basename(p) for p in lista_de_archivos if p.endswith('.jpg') or p.endswith('.png')]

def obtener_imagenes_utilizadas_en_texto_html(texto, nombre_archivo):
    """Retorna una lista de nombres de imágenes utilizadas
    en un texto html.

    Para esto la frnción extráe el valor del atributo 'src'
    de todos los tags html y los retorna en forma de lista.

    Un ejemplo de invocación:

        >>> texto = "<img src='../../imagenes/algo.jpg'>"
        >>> obtener_imagenes_utilizadas_en_texto_html(texto)
        ['algo.jpg']

    """
    soup = BeautifulSoup(texto, "lxml")
    tags = soup.findAll('img')

    rutas = [x.get('src') for x in tags]

    solo_nombres = obtener_solo_nombre_de_imagenes(rutas)
    return solo_nombres

def eliminar_srcset_de_archivo(ruta_a_archivo):
    archivo = open(ruta_a_archivo, "rt")
    contenido = archivo.read()
    archivo.close()

    archivo_nuevo = open(ruta_a_archivo, 'wt')
    contenido_nuevo = eliminar_atributos_srcset(contenido)
    archivo_nuevo.write(contenido_nuevo)
    archivo_nuevo.close()


def main():
    cantidad_archivos_borrados = 0
    cantidad_archivos_preservados = 0

    # Elimina todos los 'srcset' de los archivos HTML
    for archivo in listar_archivos_html():
        eliminar_srcset_de_archivo(archivo)

    # Obtiene todas las imagenes miniatura que están en el
    # disco y sus nombres.
    # De estas imágenes queremos saber luego cuales borrar.
    thumbs_en_disco = listar_imagenes_en_disco()
    solo_nombres_de_thumbs_en_disco = obtener_solo_nombre_de_imagenes(thumbs_en_disco)

    a = list(thumbs_en_disco)
    a.sort()
    print a

    # Recorre todos los archivos HTML buscando los nombres de archivos
    # que se tienen que preservar.
    solo_nombres_imagenes_a_preservar = []

    archivos = listar_archivos_html()

    for archivo in archivos:
        a = open(archivo, 'rt')
        contenido = a.read()
        solo_nombres_imagenes_a_preservar += obtener_imagenes_utilizadas_en_texto_html(contenido, archivo)
        a.close()

    solo_nombres_de_thumbs_en_disco = set(solo_nombres_de_thumbs_en_disco)
    solo_nombres_imagenes_a_preservar = set(solo_nombres_imagenes_a_preservar)

    nombres_a_eliminar = solo_nombres_de_thumbs_en_disco - solo_nombres_imagenes_a_preservar

    for imagen in listar_imagenes_en_disco():
        solo_nombre = os.path.basename(imagen)

        if solo_nombre in nombres_a_eliminar and not solo_nombre in solo_nombres_imagenes_a_preservar:

            os.remove(imagen)
            cantidad_archivos_borrados += 1
        else:

            cantidad_archivos_preservados +=1


    print "Resultado:"
    print ""
    print "   Miniaturas borradas:", cantidad_archivos_borrados
    print "   Miniaturas que se conservan:", cantidad_archivos_preservados

if __name__ == '__main__':
    main()
    pass
