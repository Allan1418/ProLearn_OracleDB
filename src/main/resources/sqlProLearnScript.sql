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
    ruta_imagen varchar(1024)
)