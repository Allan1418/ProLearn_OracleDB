
package com.prolearn.service;


import org.springframework.web.multipart.MultipartFile;

public interface FirebaseStorageService {

    public String cargaArchivo(MultipartFile archivoLocalCliente, String carpeta, String tipo, Long id, String contentType);

    //El BuketName es el <id_del_proyecto> + ".appspot.com"
    final String BucketName = "prolearn-1a8ca.appspot.com";

    //Esta es la ruta básica de este proyecto
    final String rutaSuperiorStorage = "prolearn";

    //Ubicación donde se encuentra el archivo de configuracion Json
    final String rutaJsonFile = "firebase";

    //El nombre del archivo Json
    final String archivoJsonFile = "firebaseKEY.json";
}