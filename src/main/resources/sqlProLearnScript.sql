drop schema if exists prolearn;
drop user if exists admin_1;

CREATE SCHEMA prolearn;

create user 'admin_1'@'%' identified by 'contra_1';
grant all privileges on prolearn.* to 'admin_1'@'%';
flush privileges;

/*creacion de tablas*/

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



CREATE TABLE prolearn.categorias (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre_categoria VARCHAR(255) NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE prolearn.capitulo_padre (
  id_capitulo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_capitulo VARCHAR(255) NOT NULL,
  num_capitulo INT NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE prolearn.capitulo_hijo (
  id_capitulo INT AUTO_INCREMENT PRIMARY KEY,
  id_categoria_padre INT NOT NULL,
  nombre_capitulo VARCHAR(255) NOT NULL,
  video_capitulo TEXT NOT NULL,
  numero_capitulo INT NOT NULL,
  FOREIGN KEY (id_categoria_padre) REFERENCES capitulo_padre(id_capitulo)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE prolearn.cursos (
  id_curso INT AUTO_INCREMENT PRIMARY KEY,
  nombre_curso VARCHAR(250) NOT NULL,
  descrp_curso TEXT,
  estado_curso BOOLEAN,
  thumbnail_curso VARCHAR(1024),
  categoria_curso INT NOT NULL,
  FOREIGN KEY (categoria_curso) REFERENCES categorias(id_categoria)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE prolearn.capitulo_x_curso (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_curso INT NOT NULL,
  id_capitulo INT NOT NULL,
  FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
  FOREIGN KEY (id_capitulo) REFERENCES capitulo_hijo(id_capitulo)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


/*insercion de datos*/

INSERT INTO prolearn.rol(nombre)
values('ROLE_USER');

INSERT INTO prolearn.usuarios (nombre, apellidos, email, password)
VALUES ('Juan', 'Perez', 'juan@example.com', '$2a$12$kmdtxMDZnpAz1vjlLBAUGu77/NU2hn0yFSHewvEJbvdNXckwteJHS');
 
INSERT INTO prolearn.usuarios (nombre, apellidos, email, password)
VALUES ('Maria', 'Gonzalez', 'maria@example.com', SHA2('456', 512));

INSERT INTO prolearn.usuario_Rol(usuario_id,rol_id)
values('1','1');



INSERT INTO prolearn.categorias (nombre_categoria) VALUES ('Web Development'), ('Data Science'), ('Machine Learning');

INSERT INTO prolearn.capitulo_padre (nombre_capitulo, num_capitulo) VALUES
('Introduction', 1),
('Basics of HTML', 2),
('Basics of CSS', 3),
('Data Analysis', 2),
('Data Visualization', 3),
('Machine Learning in python', 2),
('Building Machine Learning Models', 3);

INSERT INTO prolearn.capitulo_hijo (id_categoria_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(1, 'Getting Started with Web Development', 'video1.mp4', 1),
(1, 'HTML Basics', 'video2.mp4', 2),
(2, 'HTML Tags', 'video3.mp4', 1),
(2, 'CSS Basics', 'video4.mp4', 2),
(3, 'CSS Selectors', 'video5.mp4', 1),

(1, 'Data Analysis with Pandas', 'video6.mp4', 1),
(4, 'Data Visualization with Matplotlib', 'video7.mp4', 1),

(1, 'Introduction to Machine Learning', 'video8.mp4', 1),
(1, 'Building Machine Learning Models with TensorFlow', 'video9.mp4', 2);

INSERT INTO prolearn.cursos (nombre_curso, descrp_curso, estado_curso, thumbnail_curso, categoria_curso) VALUES
('Curso de javascript', 'Learn the basics of web development', true, 'thumbnail1.jpg', 1),
('Data Visualization with Python', 'Learn howto visualize data using Python', true, 'thumbnail2.jpg', 2),
('Machine Learning with TensorFlow', 'Learn how to build machine learning models using TensorFlow', true, 'thumbnail3.jpg', 3);

INSERT INTO prolearn.capitulo_x_curso (id_curso, id_capitulo) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),

(2, 6),
(2, 7),

(3, 8),
(3, 9);
