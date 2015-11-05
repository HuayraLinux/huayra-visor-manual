# -*- encoding: utf-8 -*-
import re
import os
import reducir_dump

def listar_imagenes_en_disco():
    for file in reducir_dump.find('./export/images'):
        if r'/2F/' in file:
            nombre = file.lower()
            if nombre.endswith('.jpg') or nombre.endswith('.png') or nombre.endswith('.gif'):
                yield file


for f in listar_imagenes_en_disco():
    os.remove(f)
