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
    
);

CREATE TABLE prolearn.usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario varchar(250) NOT NULL,
    apellidos_usuario varchar(250) NOT NULL,
    correo_usuario varchar(250) NOT NULL,
    contra_usuario varchar(250) NOT NULL
    
    
);