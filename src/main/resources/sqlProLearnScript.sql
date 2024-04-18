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