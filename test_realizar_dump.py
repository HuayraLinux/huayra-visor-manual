# -*- encoding: utf-8 -*-
import unittest
from reducir_dump import *


class Test(unittest.TestCase):

    def testPuedeEliminarSrcset(self):
        texto_de_prueba = """
                <div id="contentSub"></div>
                                <!-- start content -->
                <div id="mw-content-text" lang="es" dir="ltr" class="mw-content-ltr"><div class="thumb tright"><div class="thumbinner" style="width:258px;"><a href="../../../../articles/x/o/u/Archivo:Xournal.jpg.html" class="image"><img alt="" src="../../../../images/thumb/d/de/Xournal.jpg/256px-Xournal.jpg" width="256" height="256" class="thumbimage" srcset="../../../../images/thumb/d/de/Xournal.jpg/384px-Xournal.jpg 1.5x, ../../../../images/thumb/d/de/Xournal.jpg/512px-Xournal.jpg 2x" /></a>  <div class="thumbcaption"><div class="magnify"><a href="../../../../articles/x/o/u/Archivo:Xournal.jpg.html" class="internal" title="Aumentar"><img src="../../../../skins/common/images/magnify-clip.png" width="15" height="11" alt="" /></a></div>Xournal</div></div></div>
        <p>Huayra incluye entre sus aplicaciones a <b>Xournal</b>. Este programa te permite escribir, resaltar y marcar tus documentos en PDF.  No dejes de leer este sencillo tutorial e indagar en la variedad de funcionalidades de la aplicación.
        </p>
        <dl><dt>Hacer anotaciones en mi PDF
        </dt><dd>Para abrir la aplicación debemos hacer lo siguiente:
        </dd><dd>1- ALT + F2 (también podemos abrir la aplicación desde el <a href="../../../../articles/m/e/n/Men%C3%BA_Huayra.html" title="Menú Huayra">Menú Huayra</a> &gt;&gt; <b>Accesorios</b>.
        </dd><dd>2- Escribir XOURNAL
        """

        texto = eliminar_atributos_srcset(texto_de_prueba)
        self.assertNotIn("srcset", texto, "ya no tiene que tener srcset")

    def testObtenerRutasAImagenes(self):
        texto_de_prueba = """
                <div id="contentSub"></div>
                                <!-- start content -->
                <div id="mw-content-text" lang="es" dir="ltr" class="mw-content-ltr"><div class="thumb tright"><div class="thumbinner" style="width:258px;"><a href="../../../../articles/x/o/u/Archivo:Xournal.jpg.html" class="image"><img alt="" src="../../../../images/thumb/d/de/Xournal.jpg/256px-Xournal.jpg" width="256" height="256" class="thumbimage" srcset="../../../../images/thumb/d/de/Xournal.jpg/384px-Xournal.jpg 1.5x, ../../../../images/thumb/d/de/Xournal.jpg/512px-Xournal.jpg 2x" /></a>  <div class="thumbcaption"><div class="magnify"><a href="../../../../articles/x/o/u/Archivo:Xournal.jpg.html" class="internal" title="Aumentar"><img src="../../../../skins/common/images/magnify-clip.png" width="15" height="11" alt="" /></a></div>Xournal</div></div></div>
        <p>Huayra incluye entre sus aplicaciones a <b>Xournal</b>. Este programa te permite escribir, resaltar y marcar tus documentos en PDF.  No dejes de leer este sencillo tutorial e indagar en la variedad de funcionalidades de la aplicación.
        </p>
        <dl><dt>Hacer anotaciones en mi PDF
        </dt><dd>Para abrir la aplicación debemos hacer lo siguiente:
        </dd><dd>1- ALT + F2 (también podemos abrir la aplicación desde el <a href="../../../../articles/m/e/n/Men%C3%BA_Huayra.html" title="Menú Huayra">Menú Huayra</a> &gt;&gt; <b>Accesorios</b>.
        </dd><dd>2- Escribir XOURNAL
        """
        imagenes = obtener_imagenes_utilizadas_en_texto_html(texto_de_prueba)
        self.assertIn("256px-Xournal.jpg", imagenes)

    def testListaMinuaturasDelDisco(self):
        archivos = listar_imagenes_en_disco()
        archivo_conocido = 'src/documentacion/images/thumb/f/ff/Compartirweb3.jpg/360px-Compartirweb3.jpg'
        self.assertIn(archivo_conocido, list(archivos))

    def testListaArchivosHTML(self):
        archivos = listar_archivos_html()
        archivo_conocido = 'src/documentacion/articles/22/m/a/"Matar"_aplicaciones.html'
        self.assertIn(archivo_conocido, list(archivos))

if __name__ == "__main__":
    unittest.main()