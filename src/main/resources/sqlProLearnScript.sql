drop schema if exists prolearn;
drop user if exists admin_1;

CREATE SCHEMA prolearn;

create user 'admin_1'@'%' identified by 'contra_1';
grant all privileges on prolearn.* to 'admin_1'@'%';
flush privileges;

CREATE TABLE prolearn.cursos (
	id_curso INT auto_increment primary KEY,
    nombre_curso varchar(250) NOT NULL,
    descrp_curso text,
    ruta_imagen varchar(1024)
);

CREATE TABLE prolearn.usuarios (
  id_usuario INT auto_increment primary KEY,
  nombre_completo VARCHAR(255) NOT NULL,
  correo_electronico VARCHAR(255) NOT NULL UNIQUE,
  contrasena VARCHAR(255) NOT NULL,
  rol VARCHAR(50) NOT NULL DEFAULT 'Estudiante'
);

CREATE TABLE prolearn.contrasenas(
    id_solicitud INT Primary Key auto_increment,
	correo_electronico VARCHAR(255)
);

CREATE TABLE prolearn.crear(
id_crear INT Primary Key auto_increment,
nombre_usuario VARCHAR(255),
apellid_usuario VARCHAR(255),
correo_electronico VARCHAR(255),
contraseña VARCHAR(255)
);

INSERT INTO prolearn.cursos (id_curso, nombre_curso, descrp_curso, ruta_imagen)
VALUES
(1, 'Introducción a la Programación en Python', 'Aprende los fundamentos de la programación con Python, un lenguaje sencillo y versátil.', 'images/python_intro.jpg'),
(2, 'Análisis de Datos con Pandas', 'Domina el manejo y análisis de datos con la librería Pandas en Python.', 'images/pandas_data_analysis.jpg'),
(3, 'Desarrollo Web con Django', 'Crea aplicaciones web dinámicas y escalables utilizando el framework Django.', 'images/django_web_dev.jpg'),
(4, 'Machine Learning con Scikit-learn', 'Adéntrate en el mundo del Machine Learning con la biblioteca Scikit-learn de Python.', 'images/scikit_learn_ml.jpg'),
(5, 'Bases de Datos con MySQL', 'Aprende a diseñar, crear y manipular bases de datos relacionales con MySQL.', 'images/mysql_database.jpg'),
(6, 'Introducción a la Ciberseguridad', 'Aprende los fundamentos de la seguridad informática y protege tus sistemas y datos.', 'images/cybersecurity_intro.jpg'),
(7, 'Desarrollo de Apps Móviles con React Native', 'Crea aplicaciones móviles multiplataforma con React Native y JavaScript.', 'images/react_native_mobile_app.jpg'),
(8, 'Diseño Web con HTML y CSS', 'Aprende a crear páginas web atractivas y funcionales utilizando HTML y CSS.', 'images/html_css_web_design.jpg'),
(9, 'Marketing Digital para Emprendedores', 'Impulsa tu negocio online con estrategias de marketing digital efectivas.', 'images/digital_marketing_entrepreneurs.jpg'),
(10, 'Gestión de Proyectos con Agile', 'Aprende a gestionar proyectos de forma eficiente utilizando metodologías Agile.', 'images/agile_project_management.jpg'),
(11, 'Gestión de Proyectos con Agile', 'Aprende a gestionar proyectos de forma eficiente utilizando metodologías Agile.', 'images/agile_project_management.jpg');

INSERT INTO prolearn.usuarios (id_usuario, nombre_completo, correo_electronico, contrasena, rol)
VALUES
(1, 'Juan Pérez', 'juan.perez@ejemplo.com', '123456', 'Estudiante'),
(2, 'María López', 'maria.lopez@ejemplo.com', 'abcdef', 'Profesor'),
(3, 'Ana García', 'ana.garcia@ejemplo.com', 'ghijkl', 'Administrador'),
(4, 'Pedro Martínez', 'pedro.martinez@ejemplo.com', 'zxcvbn', 'Estudiante'),
(5, 'Laura Fernández', 'laura.fernandez@ejemplo.com', 'poiuytre', 'Profesor');

INSERT INTO prolearn.contrasenas(id_solicitud,correo_electronico)
VALUES
(1, 'juan.perez@ejemplo.com'),
(2, 'pepe.perez@ejemplo.com');


INSERT INTO prolearn.crear(id_crear,nombre_usuario, apellid_usuario, correo_electronico, contraseña) VALUES
(1,'juanperez', 'Pérez García', 'juanperez@correo.com', '123456'),
(2,'marialopez', 'López Martínez', 'marialopez@correo.com', 'abc123'),
(3,'pedrogarcia', 'García Fernández', 'pedrogarcia@correo.com', 'qwerty123'),
(4,'anagomez', 'Gómez Rodríguez', 'anagomez@correo.com', 'asdfgh123'),
(5,'luisromero', 'Romero Sánchez', 'luisromero@correo.com', 'zxcvbn123');
