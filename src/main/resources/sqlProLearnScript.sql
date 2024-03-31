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
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(250) NOT NULL,
    apellidos varchar(250) NOT NULL,
    username varchar(25) NOT NULL,
    password varchar(512) NOT NULL
    
    
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table prolearn.rol (
  id_rol INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(20),
  id_usuario int,
  foreign key fk_rol_usuario (id_usuario) references usuarios(id_usuario)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO prolearn.usuarios (nombre, apellidos, username, password)
VALUES ('Juan', 'Perez', 'juan@example.com', SHA2('123', 512));
 
INSERT INTO prolearn.usuarios (nombre, apellidos, username, password)
VALUES ('Maria', 'Gonzalez', 'maria@example.com', SHA2('456', 512));

INSERT INTO prolearn.rol (nombre, id_usuario)
VALUES ('ROLE_ADMIN', 1);
 
INSERT INTO prolearn.rol (nombre, id_usuario)
VALUES ('ROLE_ADMIN', 2);