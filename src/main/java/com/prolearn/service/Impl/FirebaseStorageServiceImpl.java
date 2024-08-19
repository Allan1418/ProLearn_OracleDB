package com.prolearn.service.Impl;

import com.google.auth.Credentials;
import com.google.auth.ServiceAccountSigner;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.*;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.Storage.SignUrlOption;
import com.google.cloud.storage.StorageOptions;
import com.prolearn.service.FirebaseStorageService;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.concurrent.TimeUnit;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FirebaseStorageServiceImpl implements FirebaseStorageService {
    @Override
    public String cargaArchivo(MultipartFile archivoLocalCliente, String carpeta, String tipo, Long id, String contentType) {
        try {
            // El nombre original del archivo local del cliene
            String extension = archivoLocalCliente.getOriginalFilename().substring(archivoLocalCliente.getOriginalFilename().lastIndexOf("."));

            // variable temporal para evitar conflictos entre desarrolladores
            String username = System.getProperty("user.name");
            
            // Se genera el nombre del video
            String fileName = username + tipo + sacaNumero(id) + extension;

            // Se convierte/sube el archivo a un archivo temporal
            File file = this.convertToFile(archivoLocalCliente);

            // se copia a Firestore y se obtiene el url valido(por 10 años) 
            String URL = this.uploadFile(file, carpeta, fileName, contentType);

            // Se elimina el archivo temporal cargado desde el cliente
            file.delete();

            return URL;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String uploadFile(File file, String carpeta, String fileName, String contentType) throws IOException {
        //Se define el lugar y acceso al archivo .jasper
        ClassPathResource json = new ClassPathResource(rutaJsonFile + File.separator + archivoJsonFile);
        BlobId blobId = BlobId.of(BucketName, rutaSuperiorStorage + "/" + carpeta + "/" + fileName);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType(contentType).build();

        Credentials credentials = GoogleCredentials.fromStream(json.getInputStream());
        Storage storage = StorageOptions.newBuilder().setCredentials(credentials).build().getService();
        storage.create(blobInfo, Files.readAllBytes(file.toPath()));
        String url = storage.signUrl(blobInfo, 3650, TimeUnit.DAYS, SignUrlOption.signWith((ServiceAccountSigner) credentials)).toString();
        return url;
    }

    //Método utilitario que convierte el archivo desde el equipo local del usuario a un archivo temporal en el servidor
    private File convertToFile(MultipartFile archivoLocalCliente) throws IOException {
        File tempFile = File.createTempFile("art", null);
        try (FileOutputStream fos = new FileOutputStream(tempFile)) {
            fos.write(archivoLocalCliente.getBytes());
            fos.close();
        }
        return tempFile;
    }

    //Método utilitario para obtener un string con ceros....
    private String sacaNumero(long id) {
        return String.format("%09d", id);
    }
}