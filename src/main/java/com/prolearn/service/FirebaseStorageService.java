
package com.prolearn.service;


import org.springframework.web.multipart.MultipartFile;

public interface FirebaseStorageService {

    public String cargaArchivo(MultipartFile archivoLocalCliente, String carpeta, Long id, String contentType);

    //El BuketName es el <id_del_proyecto> + ".appspot.com"
    final String BucketName = "prolearn-1a8ca.appspot.com";

    //Esta es la ruta básica de este proyecto Techshop
    final String rutaSuperiorStorage = "prolearn";

    //Ubicación donde se encuentra el archivo de configuración Json
    final String rutaJsonFile = "firebase";

    //El nombre del archivo Json
    final String archivoJsonFile = "prolearn-1a8ca-firebase-adminsdk-q3dqn-882c564149.json";
}