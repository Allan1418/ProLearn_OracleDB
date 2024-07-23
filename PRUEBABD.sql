ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
SET DEFINE OFF;

SET SERVEROUTPUT ON;

DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username = 'PROLEARN';
 
  IF v_count > 0 THEN
    FOR rec IN (SELECT sid, serial# FROM v$session WHERE username = 'PROLEARN') LOOP
      EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || rec.sid || ',' || rec.serial# || ''' IMMEDIATE';
    END LOOP;
 
    EXECUTE IMMEDIATE 'DROP USER PROLEARN CASCADE';
    DBMS_OUTPUT.PUT_LINE('Usuario PROLEARN y sus objetos eliminados.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El usuario PROLEARN no existe.');
  END IF;
END;
/

CREATE USER PROLEARN IDENTIFIED BY contra_1;
GRANT DBA TO PROLEARN;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Usuario PROLEARN creado.');
END;
/

-- Creación de tablas

CREATE TABLE PROLEARN.usuarios (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(250) NOT NULL,
    apellidos VARCHAR2(250) NOT NULL,
    email VARCHAR2(25) NOT NULL,
    password VARCHAR2(512) NOT NULL 
);

CREATE TABLE PROLEARN.rol (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(255)
);

CREATE TABLE PROLEARN.usuario_rol (
    usuario_id NUMBER,
    rol_id NUMBER,
    FOREIGN KEY (usuario_id) REFERENCES PROLEARN.usuarios(id),
    FOREIGN KEY (rol_id) REFERENCES PROLEARN.rol(id)
);

CREATE TABLE PROLEARN.categorias (
  id_categoria NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
  nombre_categoria VARCHAR2(255) NOT NULL
);

CREATE TABLE PROLEARN.capitulo_padre (
  id_capitulo NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
  nombre_capitulo VARCHAR2(255) NOT NULL,
  numero_capitulo NUMBER NOT NULL
);

CREATE TABLE PROLEARN.capitulo_hijo (
  id_capitulo NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
  id_capitulo_padre NUMBER NOT NULL,
  nombre_capitulo VARCHAR2(255) NOT NULL,
  video_capitulo VARCHAR2(1024),
  numero_capitulo NUMBER NOT NULL,
  FOREIGN KEY (id_capitulo_padre) REFERENCES PROLEARN.capitulo_padre(id_capitulo)
);

CREATE TABLE PROLEARN.cursos (
  id_curso NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
  nombre_curso VARCHAR2(250) NOT NULL,
  descrp_curso VARCHAR2(1000),
  estado_curso NUMBER(1),
  thumbnail_curso VARCHAR2(1024),
  categoria_curso NUMBER NOT NULL,
  FOREIGN KEY (categoria_curso) REFERENCES PROLEARN.categorias(id_categoria)
);

CREATE TABLE PROLEARN.capitulo_x_curso (
  id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
  id_curso NUMBER NOT NULL,
  id_capitulo NUMBER NOT NULL,
  FOREIGN KEY (id_curso) REFERENCES PROLEARN.cursos(id_curso),
  FOREIGN KEY (id_capitulo) REFERENCES PROLEARN.capitulo_hijo(id_capitulo) ON DELETE CASCADE
);

-- Inserción de datos

INSERT INTO PROLEARN.rol (nombre) VALUES ('ROLE_USER');
INSERT INTO PROLEARN.rol (nombre) VALUES ('ROLE_ADMIN');

INSERT INTO PROLEARN.usuarios (nombre, apellidos, email, password)
VALUES ('Juan', 'Perez', 'juan@example.com', '$2a$12$kmdtxMDZnpAz1vjlLBAUGu77/NU2hn0yFSHewvEJbvdNXckwteJHS');
 
INSERT INTO PROLEARN.usuarios (nombre, apellidos, email, password)
VALUES ('admin', 'admin', 'admin@PROLEARN.com', '$2a$12$kmdtxMDZnpAz1vjlLBAUGu77/NU2hn0yFSHewvEJbvdNXckwteJHS');

INSERT INTO PROLEARN.usuario_rol (usuario_id, rol_id)
VALUES (1, 1);
INSERT INTO PROLEARN.usuario_rol (usuario_id, rol_id)
VALUES (2, 2);

INSERT INTO PROLEARN.categorias (nombre_categoria) VALUES ('Diseño');
INSERT INTO PROLEARN.categorias (nombre_categoria) VALUES ('Programacion');
INSERT INTO PROLEARN.categorias (nombre_categoria) VALUES ('Idiomas');

-- Inserts de Padres Python
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Introduccion', 1);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Variables', 2);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Operadores', 3);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Salida y entradas de datos', 4);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Operaciones aritmeticas', 5);

-- Inserts de Padres MySql
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Crear Base de datos', 2);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Conceptos básicos de MySQL', 3);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Consultas SQL', 4);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Funciones de agregación', 5);

-- Inserts de Padres JavaScript
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Tipos de datos', 2);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Capturas de datos', 3);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Operadores', 4);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Funciones', 5);

-- Inserts de Padres IA
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Numpy', 2);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Libreria Pandas', 3);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Matplotlib', 4);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Machine Learning in python', 5);

-- Inserts de Padres Curso de AutoCad
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Conocimientos Basicos', 2);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Figuras', 3);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Herramientas', 4);

-- Inserts de Padres Curso de Ingles
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Conversaciones', 2);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Numeros', 3);
INSERT INTO PROLEARN.capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Mr y Ms', 4);

-- Inserts de Submodulos Python
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(1,'Lenguaje de Programacion', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.apps;pot.com/o/Python%2FCapitulo%201%2F1.%20Programaci%C3%B3n%20en%20Python%20_%20Lenguaje%20de%20Programaci%C3%B3n%20Python.mp4?alt=media&token=d123f6a2-939a-42fd-a65d-f7ab73203ef3', 1);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(1,'Intalacion Python', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%201%2F2.%20Programaci%C3%B3n%20en%20Python%20_%20Descargar%20e%20instalar%20Python%20y%20PyCharm.mp4?alt=media&token=6548629f-35a3-499f-b994-012337add54c', 2);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(1,'Primer Codigo', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%201%2F3.%20Programaci%C3%B3n%20en%20Python%20_%20Hola%20mundo.mp4?alt=media&token=533887e8-b644-4f1a-8023-537a6c5e4ae4', 3);

INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(2, 'Asignacion de valores', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2F4.%20Programaci%C3%B3n%20en%20Python%20_%20Asignaci%C3%B3n%20de%20valores.mp4?alt=media&token=f032282e-ddea-441f-8b9f-ca29280a29a6', 1);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(2, 'Comentarios', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2F5.%20Programaci%C3%B3n%20en%20Python%20_%20Comentarios.mp4?alt=media&token=f31d21b4-d6cb-4858-b3ac-56238179ab86', 2);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(2, 'Operadores Aritmeticos', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2F6.%20Programaci%C3%B3n%20en%20Python%20_%20Operadores%20Aritm%C3%A9ticos.mp4?alt=media&token=49ca0f5d-f062-4cd1-b2e5-0a2b31ad9475', 3);

INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(3,'Operadores Relacionales','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%203%2F7.%20Programaci%C3%B3n%20en%20Python%20_%20Operadores%20Relacionales.mp4?alt=media&token=a8043c71-3fea-4a54-a3fe-cd59ffed1448',1);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(3,'Operadores Logicos','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%203%2F8.%20Programaci%C3%B3n%20en%20Python%20_%20Operadores%20L%C3%B3gicos.mp4?alt=media&token=29dedaa1-8f4e-4279-b97e-407de2b8a0e3',2);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(3,'Operadores de asignacion','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%203%2F9.%20Programaci%C3%B3n%20en%20Python%20_%20Operadores%20de%20asignaci%C3%B3n.mp4?alt=media&token=c83c23d2-f29f-43e0-a920-ee658f20639c',3);

INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(4,'Salida de datos','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%204%2F10.%20Programaci%C3%B3n%20en%20Python%20_%20Salida%20de%20datos.mp4?alt=media&token=f360dd27-26c3-401b-b4ab-adb3cb462e0d',1);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(4,'Entrada de datos','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%204%2F11.%20Programaci%C3%B3n%20en%20Python%20_%20Entrada%20de%20datos.mp4?alt=media&token=ed0c5254-da88-48f0-abb7-3b254ed23c18',2);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(4,'Funciones Integradas', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%204%2F12.%20Programaci%C3%B3n%20en%20Python%20_%20Funciones%20integradas.mp4?alt=media&token=9950c0c8-cee3-4d9e-8d6e-638ca14d63d3',3);

INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(5,'Operacion Aritmetica','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%205%2F13.%20Programaci%C3%B3n%20en%20Python%20_%20Ejercicio%201%20%E2%80%93%20Operaci%C3%B3n%20aritm%C3%A9tica.mp4?alt=media&token=b8be2578-83a8-46c4-a978-b9c0ba765239',1);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(5,'Operacion con 3 Tipos de Operadores','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%205%2F14.%20Programaci%C3%B3n%20en%20Python%20_%20Ejercicio%202%20%E2%80%93%20Operaci%C3%B3n%20con%203%20tipos%20de%20operadores.mp4?alt=media&token=7aef2655-f952-4af7-a8f7-4564a7700115',2);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(5,'Intercambiar el valor de 2 variables','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%205%2F15.%20Programaci%C3%B3n%20en%20Python%20_%20Ejercicio%203%20%E2%80%93%20Intercambiar%20el%20valor%20de%202%20variables.mp4?alt=media&token=82424758-baa9-4344-bc9f-8687509adf1a',3);

-- Inserts de Submodulos MySql
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(1,'Que es MySql','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/MySql%2FCapitulo%201%2FCURSO%20RAPIDO%20de%20MYSQL%202020%20%23%201%20%F0%9F%9B%A2%EF%B8%8F%20QUE%20ES%20MYSQL%20INTRODUCCI%C3%93N).mp4?alt=media&token=bf21551e-44fe-47a7-9d49-466c4c685b12',1);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(1,'Instalacion','https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/MySql%2FCapitulo%201%2FCURSO%20RAPIDO%20de%20MYSQL%202020%20%23%202%20%F0%9F%9B%A2%EF%B8%8FINSTALACI%C3%93N.mp4?alt=media&token=18006ff2-e4fa-4793-975d-769ef07f7de7',2);
    
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(6,'Asignacion de valores', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2F4.%20Programaci%C3%B3n%20en%20Python%20_%20Asignaci%C3%B3n%20de%20valores.mp4?alt=media&token=f032282e-ddea-441f-8b9f-ca29280a29a6', 1);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(6,'Comentarios', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2F5.%20Programaci%C3%B3n%20en%20Python%20_%20Comentarios.mp4?alt=media&token=f31d21b4-d6cb-4858-b3ac-56238179ab86', 2);
INSERT INTO PROLEARN.capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) VALUES
(6,'Operadores Aritmeticos', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2F6.%20Programaci%C3%B3n%20en%20Python%20_%20Operadores%20Aritm%C3%A9ticos.mp4?alt=media&token=49ca0f5d-f062-4cd1-b2e5-0a2b31ad9475', 3);

-- Crear secuencias para los IDs auto-incrementales
CREATE SEQUENCE seq_usuario_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_rol_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_categoria_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_curso_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_capitulo_padre_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_capitulo_hijo_id START WITH 1 INCREMENT BY 1;

-- Crear tablas
CREATE TABLE usuarios (
    id_usuario NUMBER DEFAULT seq_usuario_id.NEXTVAL PRIMARY KEY,
    nombre_usuario VARCHAR2(50),
    email VARCHAR2(100),
    contrasena VARCHAR2(100),
    estado_usuario NUMBER(1)
);

CREATE TABLE rol (
    id_rol NUMBER DEFAULT seq_rol_id.NEXTVAL PRIMARY KEY,
    nombre_rol VARCHAR2(50)
);

CREATE TABLE usuario_rol (
    id_usuario NUMBER,
    id_rol NUMBER,
    CONSTRAINT fk_usuario_rol_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_usuario_rol_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

CREATE TABLE categorias (
    id_categoria NUMBER DEFAULT seq_categoria_id.NEXTVAL PRIMARY KEY,
    nombre_categoria VARCHAR2(50)
);

CREATE TABLE cursos (
    id_curso NUMBER DEFAULT seq_curso_id.NEXTVAL PRIMARY KEY,
    nombre_curso VARCHAR2(100),
    descrp_curso CLOB,
    estado_curso NUMBER(1),
    thumbnail_curso VARCHAR2(255),
    categoria_curso NUMBER,
    CONSTRAINT fk_cursos_categoria FOREIGN KEY (categoria_curso) REFERENCES categorias(id_categoria)
);

CREATE TABLE capitulo_padre (
    id_capitulo_padre NUMBER DEFAULT seq_capitulo_padre_id.NEXTVAL PRIMARY KEY,
    nombre_capitulo VARCHAR2(100),
    numero_capitulo NUMBER
);

CREATE TABLE capitulo_hijo (
    id_capitulo_hijo NUMBER DEFAULT seq_capitulo_hijo_id.NEXTVAL PRIMARY KEY,
    id_capitulo_padre NUMBER,
    nombre_capitulo VARCHAR2(100),
    video_capitulo VARCHAR2(255),
    numero_capitulo NUMBER,
    CONSTRAINT fk_capitulo_hijo_padre FOREIGN KEY (id_capitulo_padre) REFERENCES capitulo_padre(id_capitulo_padre)
);

CREATE TABLE capitulo_x_curso (
    id_curso NUMBER,
    id_capitulo NUMBER,
    CONSTRAINT fk_capitulo_x_curso_curso FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    CONSTRAINT fk_capitulo_x_curso_capitulo FOREIGN KEY (id_capitulo) REFERENCES capitulo_padre(id_capitulo_padre)
);

-- Insertar datos
INSERT INTO categorias (nombre_categoria) VALUES ('Tecnología');
INSERT INTO categorias (nombre_categoria) VALUES ('Programación');
INSERT INTO categorias (nombre_categoria) VALUES ('Idiomas');

-- Inserts para capitulo_padre
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Introducción a Python', 1);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Variables y Tipos de Datos', 2);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Estructuras de Control', 3);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Funciones', 4);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Estructuras de Datos', 5);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Programación Orientada a Objetos', 6);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Módulos y Paquetes', 7);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Manejo de Excepciones', 8);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Trabajo con Archivos', 9);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Introducción a Bases de Datos', 10);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Introducción a GUI con Tkinter', 11);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Introducción a Web Scraping', 12);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Introducción a Data Science con Python', 13);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Proyecto Final', 14);
INSERT INTO capitulo_padre (nombre_capitulo, numero_capitulo) VALUES ('Conclusiones y Próximos Pasos', 15);

-- Inserts para capitulo_hijo
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (1, '¿Qué es Python?', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%201%2F%C2%BFQu%C3%A9%20es%20Python_%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=e9eedf82-c119-478d-8c5b-1e03d496ddf4', 1);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (1, 'Instalación de Python', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%201%2FInstalar%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=65eaac70-98c5-4e06-9e72-7b98e5d16e75', 2);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (1, 'Primer programa en Python', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%201%2FPrimer%20Programa%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=ada29f3c-6487-408a-be5e-bfa4b07b58e1', 3);

INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (2, 'Variables en Python', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2FVariables%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=11f0bafd-97f3-421b-8399-1cd59ecd7b51', 1);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (2, 'Tipos de datos en Python', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2FTipos%20de%20Datos%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=b7d98b09-daa6-44cc-9b8b-b71e34cf5719', 2);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (2, 'Operadores en Python', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%202%2FOperadores%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=99afe1fc-6d4d-44c9-b094-e4aeda56a9cb', 3);

INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (3, 'Condicionales if-else', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%203%2FCondicionales%20IF%20ELSE%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=fae52d92-cc4e-4de4-8baf-ae18c26701aa', 1);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (3, 'Bucles while', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%203%2FBucle%20WHILE%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=5c8307af-8eb8-4e6d-a8cc-ab7ec65949f5', 2);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (3, 'Bucles for', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%203%2FBucle%20FOR%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=c71acb3f-ef54-4b26-bc6b-79d0fc78b690', 3);

INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (4, 'Definición de funciones', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%204%2FFunciones%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=df0f2a7d-3883-4df2-a66e-22a1e09ad02e', 1);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (4, 'Argumentos y parámetros', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%204%2FArgumentos%20y%20Par%C3%A1metros%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=f7c19bf4-78b0-45f8-9d69-6a8b78dae563', 2);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (4, 'Retorno de valores', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%204%2FRetorno%20de%20Valores%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=b8b7c9a0-8f0a-4d7e-9f9f-f9f8f8f8f8f8', 3);

INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (5, 'Listas', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%205%2FListas%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=b8b7c9a0-8f0a-4d7e-9f9f-f9f8f8f8f8f8', 1);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (5, 'Tuplas', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%205%2FTuplas%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=b8b7c9a0-8f0a-4d7e-9f9f-f9f8f8f8f8f8', 2);
INSERT INTO capitulo_hijo (id_capitulo_padre, nombre_capitulo, video_capitulo, numero_capitulo) 
VALUES (5, 'Diccionarios', 'https://firebasestorage.googleapis.com/v0/b/prolearn-1a8ca.appspot.com/o/Python%2FCapitulo%205%2FDiccionarios%20en%20Python%20_%20Curso%20Python%20para%20Principiantes.mp4?alt=media&token=b8b7c9a0-8f0a-4d7e-9f9f-f9f8f8f8f8f8', 3);

-- Inserts para cursos
INSERT INTO cursos (nombre_curso, descrp_curso, estado_curso, thumbnail_curso, categoria_curso) 
VALUES ('Python', 'Python es un lenguaje de programación de alto nivel, interpretado y multiparadigma, creado en 1989 por Guido van Rossum y mantenido actualmente por la Python Software Foundation. Python es conocido por su sintaxis clara y fácil de leer, lo que lo hace ideal para principiantes y expertos por igual.', 1, 'https://www.dongee.com/tutoriales/content/images/2023/01/que-es-python-1.png', 2);

INSERT INTO cursos (nombre_curso, descrp_curso, estado_curso, thumbnail_curso, categoria_curso) 
VALUES ('MySql', 'MySQL es un sistema de gestión de bases de datos relacionales (RDBMS) de código abierto, ampliamente utilizado en el desarrollo de aplicaciones web, móviles y de escritorio. MySQL es conocido por su rendimiento, fiabilidad y facilidad de uso.', 1, 'https://datascientest.com/en/wp-content/uploads/sites/9/2023/11/mysql.webp', 2);


