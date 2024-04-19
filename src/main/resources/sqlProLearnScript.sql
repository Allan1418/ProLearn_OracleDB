drop schema if exists prolearn;
drop user if exists admin_1;

CREATE SCHEMA prolearn;

create user 'admin_1'@'%' identified by 'contra_1';
grant all privileges on prolearn.* to 'admin_1'@'%';
flush privileges;

CREATE TABLE prolearn.cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso varchar(250) NOT NULL,
    descrp_curso text,
    estado_curso boolean,
    thumbnail_curso varchar(1024),
    categoria_curso text
    
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE prolearn.usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(250) NOT NULL,
    apellidos varchar(250) NOT NULL,
    email varchar(25) NOT NULL,
    password varchar(512) NOT NULL
    
    
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE prolearn.rol (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(255)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE prolearn.usuario_rol (
    usuario_id INT,
    rol_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (rol_id) REFERENCES rol(id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO prolearn.rol(nombre)
values('ROLE_USER');

INSERT INTO prolearn.usuarios (nombre, apellidos, email, password)
VALUES ('Juan', 'Perez', 'juan@example.com', '$2a$12$kmdtxMDZnpAz1vjlLBAUGu77/NU2hn0yFSHewvEJbvdNXckwteJHS');
 
INSERT INTO prolearn.usuarios (nombre, apellidos, email, password)
VALUES ('Maria', 'Gonzalez', 'maria@example.com', SHA2('456', 512));

INSERT INTO prolearn.usuario_Rol(usuario_id,rol_id)
values('1','1');

INSERT INTO prolearn.cursos (nombre_curso,descrp_curso,estado_curso,thumbnail_curso,categoria_curso) 
VALUES ( 'Desarrollo de Aplicaciones Web con PHP y Laravel','Este curso te enseñará a desarrollar aplicaciones web dinámicas y robustas usando el framework Laravel y el lenguaje PHP.',
TRUE, 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F2%2F27%2FLaravel.svg%2F1200px-Laravel.svg.png&tbnid=12312312312312&vet=12ahUKEwiB9Z6L4syFAxVQg-AKHQ2-CZwQMygAegUIARCuAQ..i&imgrefurl=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FLaravel&docid=KjKjKjKjKjKjKj&w=1200&h=1200&q=laravel&client=opera-gx&ved=2ahUKEwiB9Z6L4syFAxVQg-AKHQ2-CZwQMygAegUIARCuAQ', 
'Desarrollo web' );

INSERT INTO prolearn.cursos (nombre_curso,descrp_curso,estado_curso,thumbnail_curso,categoria_curso)
 VALUES ( 'Programación Orientada a Objetos con Java','Este curso te enseñará los conceptos básicos y avanzados de la programación orientada a objetos usando el lenguaje Java.',
 TRUE, 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F6%2F6c%2FJava_programming_language_logo.svg%2F1200px-Java_programming_language_logo.svg.png&tbnid=Q3zrJG-_jJX5gM&vet=12ahUKEwiB9Z6L4syFAxVQg-AKHQ2-CZwQMygAegUIARCxAQ..i&imgrefurl=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FJava_(lenguaje_de_programaci%25C3%25B3n)&docid=jKjKjKjKjKjKjK&w=1200&h=1200&q=java&client=opera-gx&ved=2ahUKEwiB9Z6L4syFAxVQg-AKHQ2-CZwQMygAegUIARCxAQ', 'Programación' );

INSERT INTO prolearn.cursos (nombre_curso,descrp_curso,estado_curso,thumbnail_curso,categoria_curso) 
VALUES ( 'Desarrollo Web con JavaScript','Este curso te enseñará los fundamentos del lenguaje JavaScript y cómo usarlo para crear sitios web dinámicos e interactivos.',
TRUE, 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2F4%2F47%2FJava_Black_icon.svg&tbnid=IpRxpQC6Jex3ZM&vet=12ahUKEwixzbrK4syFAxVoFGIAHegWAE0QMygAegQIARBy..i&imgrefurl=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FJava_(lenguaje_de_programaci%25C3%25B3n)&docid=Kh6PdKInROJCrM&w=512&h=512&q=java&client=opera-gx&ved=2ahUKEwixzbrK4syFAxVoFGIAHegWAE0QMygAegQIARBy', 'Desarrollo web' );
