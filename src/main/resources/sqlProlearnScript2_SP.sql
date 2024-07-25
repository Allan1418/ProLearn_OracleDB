

/*USUARIOS*/
--Buscar por email
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.US_FIND_BY_EMAIL_SP(
  p_email IN FIDE_USUARIOS_TB.EMAIL%TYPE,
  p_usuario OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_usuario FOR
  SELECT * FROM FIDE_USUARIOS_TB
  WHERE EMAIL = p_email;
END US_FIND_BY_EMAIL_SP;
/
-- 
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.US_FIND_ALL_USUARIOS_SP(
  p_usuarios OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_usuarios FOR
  SELECT 
    USUARIOS_TB_ID_USUARIOS_PK,
    NOMBRE,
    APELLIDOS,
    EMAIL,
    PASSWORD
  FROM 
    FIDE_USUARIOS_TB;
END US_FIND_ALL_USUARIOS_SP;
/
--recuperar todas las entidades
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.US_FIND_USUARIO_BY_ID_SP(
  p_id IN NUMBER,
  p_usuario OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_usuario FOR
  SELECT 
    USUARIOS_TB_ID_USUARIOS_PK,
    NOMBRE,
    APELLIDOS,
    EMAIL,
    PASSWORD
  FROM 
    FIDE_USUARIOS_TB
  WHERE 
    USUARIOS_TB_ID_USUARIOS_PK = p_id;
END US_FIND_USUARIO_BY_ID_SP;

-- Procedimiento para añadir un usuario
CREATE OR REPLACE PROCEDURE AddUsuario(
    p_nombre IN VARCHAR2,
    p_apellidos IN VARCHAR2,
    p_email IN VARCHAR2,
    p_password IN VARCHAR2
) AS
BEGIN
    INSERT INTO PROLEARN.usuarios (nombre, apellidos, email, password)
    VALUES (p_nombre, p_apellidos, p_email, p_password);
    COMMIT;
END;
/

-- Procedimiento para eliminar un usuario
CREATE OR REPLACE PROCEDURE DeleteUsuario(p_id IN NUMBER) AS
BEGIN
    DELETE FROM PROLEARN.usuarios WHERE id = p_id;
    COMMIT;
END;
/
-- Procedimiento para listar todos los usuarios
CREATE OR REPLACE PROCEDURE ListUsuarios AS
BEGIN
    FOR rec IN (SELECT * FROM PROLEARN.usuarios) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id || ', Nombre: ' || rec.nombre || ', Apellidos: ' || rec.apellidos || ', Email: ' || rec.email);
    END LOOP;
END;
/

-- Procedimiento para actualizar los datos de un usuario
CREATE OR REPLACE PROCEDURE sp_update_user(
    p_id IN INT,
    p_nombre IN VARCHAR2,
    p_apellidos IN VARCHAR2,
    p_email IN VARCHAR2,
    p_password IN VARCHAR2
) IS
BEGIN
    UPDATE PROLEARN.usuarios
    SET nombre = p_nombre,
        apellidos = p_apellidos,
        email = p_email,
        password = p_password
    WHERE id = p_id;
    COMMIT;
END;
/


/*ROL*/
-- Procedimiento para eliminar un rol de un usuario
CREATE OR REPLACE PROCEDURE sp_remove_role_from_user(
    p_usuario_id IN INT,
    p_rol_id IN INT
) IS
BEGIN
    DELETE FROM PROLEARN.usuario_rol
    WHERE usuario_id = p_usuario_id AND rol_id = p_rol_id;
    COMMIT;
END;
/

-- Procedimiento para listar todos los roles
CREATE OR REPLACE PROCEDURE sp_list_roles IS
BEGIN
    FOR rec IN (SELECT * FROM PROLEARN.rol) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id || ', Nombre: ' || rec.nombre);
    END LOOP;
END;
/

-- Procedimiento para eliminar un rol
CREATE OR REPLACE PROCEDURE sp_delete_role(
    p_id IN INT
) IS
BEGIN
    DELETE FROM PROLEARN.rol WHERE id = p_id;
    COMMIT;
END;
/
-- Procedimiento para crear un nuevo rol
CREATE OR REPLACE PROCEDURE sp_create_role(
    p_nombre IN VARCHAR2
) IS
BEGIN
    INSERT INTO PROLEARN.rol (nombre)
    VALUES (p_nombre);
    COMMIT;
END;
/

/*USUARIO_ROL*/
-- Procedimiento para asignar un rol a un usuario
CREATE OR REPLACE PROCEDURE sp_assign_role(
    p_usuario_id IN INT,
    p_rol_id IN INT
) IS
BEGIN
    INSERT INTO PROLEARN.usuario_rol (usuario_id, rol_id)
    VALUES (p_usuario_id, p_rol_id);
    COMMIT;
END;
/

-- Procedimiento para listar todos los roles de un usuario
CREATE OR REPLACE PROCEDURE sp_list_roles_of_user(
    p_usuario_id IN INT
) IS
BEGIN
    FOR rec IN (SELECT ur.usuario_id, ur.rol_id, r.nombre
                FROM PROLEARN.usuario_rol ur
                JOIN PROLEARN.rol r ON ur.rol_id = r.id
                WHERE ur.usuario_id = p_usuario_id) LOOP
        DBMS_OUTPUT.PUT_LINE('Usuario ID: ' || rec.usuario_id || ', Rol ID: ' || rec.rol_id || ', Nombre Rol: ' || rec.nombre);
    END LOOP;
END;
/




/*CATEGORIAS*/
-- Procedimiento para eliminar una categoría
CREATE OR REPLACE PROCEDURE sp_delete_category(
    p_id_categoria IN INT
) IS
BEGIN
    DELETE FROM PROLEARN.categorias WHERE id_categoria = p_id_categoria;
    COMMIT;
END;
/

-- Procedimiento para actualizar una categoría
CREATE OR REPLACE PROCEDURE sp_update_category(
    p_id_categoria IN INT,
    p_nombre_categoria IN VARCHAR2
) IS
BEGIN
    UPDATE PROLEARN.categorias
    SET nombre_categoria = p_nombre_categoria
    WHERE id_categoria = p_id_categoria;
    COMMIT;
END;
/




/*CAPITULO_PADRE*/
-- Procedimiento para eliminar un capítulo padre
CREATE OR REPLACE PROCEDURE sp_delete_parent_chapter(
    p_id_capitulo IN INT
) IS
BEGIN
    DELETE FROM PROLEARN.capitulo_padre WHERE id_capitulo = p_id_capitulo;
    COMMIT;
END;
/

-- Procedimiento para actualizar un capítulo padre
CREATE OR REPLACE PROCEDURE sp_update_parent_chapter(
    p_id_capitulo IN INT,
    p_nombre_capitulo IN VARCHAR2,
    p_numero_capitulo IN INT
) IS
BEGIN
    UPDATE PROLEARN.capitulo_padre
    SET nombre_capitulo = p_nombre_capitulo,
        numero_capitulo = p_numero_capitulo
    WHERE id_capitulo = p_id_capitulo;
    COMMIT;
END;
/




/*CAPITULO_HIJO*/
CREATE TABLE FIDE_PROLEARN_FINAL_PROF.TESTI (
  PARA VARCHAR2(2)
);


CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CH_FINDBYID_SP(
    P_ID_CAPITULO_HIJO IN NUMBER,
    P_CAPITULO_HIJO OUT FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB%ROWTYPE
)IS
BEGIN
    SELECT * INTO P_CAPITULO_HIJO FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB 
    WHERE CAPITULO_HIJO_TB_ID_CH_PK = P_ID_CAPITULO_HIJO;
    
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.TESTI (PARA) VALUES ('A');
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN P_CAPITULO_HIJO := NULL;

END;

-- Procedimiento para eliminar un capítulo hijo
CREATE OR REPLACE PROCEDURE sp_delete_child_chapter(
    p_id_capitulo IN INT
) IS
BEGIN
    DELETE FROM PROLEARN.capitulo_hijo WHERE id_capitulo = p_id_capitulo;
    COMMIT;
END;
/

-- Procedimiento para actualizar un capítulo hijo
CREATE OR REPLACE PROCEDURE sp_update_child_chapter(
    p_id_capitulo IN INT,
    p_id_capitulo_padre IN INT,
    p_nombre_capitulo IN VARCHAR2,
    p_video_capitulo IN VARCHAR2,
    p_numero_capitulo IN INT
) IS
BEGIN
    UPDATE PROLEARN.capitulo_hijo
    SET id_capitulo_padre = p_id_capitulo_padre,
        nombre_capitulo = p_nombre_capitulo,
        video_capitulo = p_video_capitulo,
        numero_capitulo = p_numero_capitulo
    WHERE id_capitulo = p_id_capitulo;
    COMMIT;
END;
/




--recuperar una entidad
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CH_FINDALLBYCAPITULOPADREID_SP(
  p_id_capitulo_padre IN FIDE_CAPITULO_HIJO_TB.ID_CAPITULO_PADRE%TYPE,
  p_result OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_result FOR
  SELECT 
    CAPITULO_HIJO_TB_ID_CAPITULO_PK,
    ID_CAPITULO_PADRE,
    NOMBRE_CAPITULO,
    VIDEO_CAPITULO,
    NUMERO_CAPITULO
  FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB
  WHERE ID_CAPITULO_PADRE = p_id_capitulo_padre;
END CH_FINDALLBYCAPITULOPADREID_SP;

--save

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CH_SAVE_CAPITULO_HIJO_SP(
  p_id_capitulo_padre IN FIDE_CAPITULO_HIJO_TB.ID_CAPITULO_PADRE%TYPE,
  p_nombre_capitulo IN FIDE_CAPITULO_HIJO_TB.NOMBRE_CAPITULO%TYPE,
  p_video_capitulo IN FIDE_CAPITULO_HIJO_TB.VIDEO_CAPITULO%TYPE,
  p_numero_capitulo IN FIDE_CAPITULO_HIJO_TB.NUMERO_CAPITULO%TYPE,
  p_capitulo_hijo_id OUT FIDE_CAPITULO_HIJO_TB.CAPITULO_HIJO_TB_ID_CAPITULO_PK%TYPE
) AS
BEGIN
  IF p_capitulo_hijo_id IS NULL THEN
    -- Insertar nuevo registro
    INSERT INTO FIDE_CAPITULO_HIJO_TB (
      ID_CAPITULO_PADRE,
      NOMBRE_CAPITULO,
      VIDEO_CAPITULO,
      NUMERO_CAPITULO
    ) VALUES (
      p_id_capitulo_padre,
      p_nombre_capitulo,
      p_video_capitulo,
      p_numero_capitulo
    ) RETURNING CAPITULO_HIJO_TB_ID_CAPITULO_PK INTO p_capitulo_hijo_id;
  ELSE
    -- Actualizar registro existente
    UPDATE FIDE_CAPITULO_HIJO_TB
    SET
      ID_CAPITULO_PADRE = p_id_capitulo_padre,
      NOMBRE_CAPITULO = p_nombre_capitulo,
      VIDEO_CAPITULO = p_video_capitulo,
      NUMERO_CAPITULO = p_numero_capitulo
    WHERE CAPITULO_HIJO_TB_ID_CAPITULO_PK = p_capitulo_hijo_id;
  END IF;
END CH_SAVE_CAPITULO_HIJO_SP;


--delete
CREATE OR REPLACE PROCEDURE CH_DELETE_CAPITULO_HIJO_SP(
  p_capitulo_hijo_id IN FIDE_CAPITULO_HIJO_TB.CAPITULO_HIJO_TB_ID_CAPITULO_PK%TYPE
) AS
BEGIN
  DELETE FROM FIDE_CAPITULO_HIJO_TB
  WHERE CAPITULO_HIJO_TB_ID_CAPITULO_PK = p_capitulo_hijo_id;
END CH_DELETE_CAPITULO_HIJO_SP;

--

/*CURSOS*/
-- Procedimiento para añadir un curso
CREATE OR REPLACE PROCEDURE AddCurso(
    p_nombre_curso IN VARCHAR2,
    p_descrp_curso IN VARCHAR2,
    p_estado_curso IN NUMBER,
    p_thumbnail_curso IN VARCHAR2,
    p_categoria_curso IN NUMBER
) AS
BEGIN
    INSERT INTO PROLEARN.cursos (nombre_curso, descrp_curso, estado_curso, thumbnail_curso, categoria_curso)
    VALUES (p_nombre_curso, p_descrp_curso, p_estado_curso, p_thumbnail_curso, p_categoria_curso);
    COMMIT;
END;
/
-- Procedimiento para actualizar un curso
CREATE OR REPLACE PROCEDURE UpdateCurso(
    p_id_curso IN NUMBER,
    p_nombre_curso IN VARCHAR2,
    p_descrp_curso IN VARCHAR2,
    p_estado_curso IN NUMBER,
    p_thumbnail_curso IN VARCHAR2,
    p_categoria_curso IN NUMBER
) AS
BEGIN
    UPDATE PROLEARN.cursos
    SET nombre_curso = p_nombre_curso,
        descrp_curso = p_descrp_curso,
        estado_curso = p_estado_curso,
        thumbnail_curso = p_thumbnail_curso,
        categoria_curso = p_categoria_curso
    WHERE id_curso = p_id_curso;
    COMMIT;
END;
/
-- Procedimiento para eliminar un curso
CREATE OR REPLACE PROCEDURE DeleteCurso(p_id_curso IN NUMBER) AS
BEGIN
    DELETE FROM PROLEARN.cursos WHERE id_curso = p_id_curso;
    COMMIT;
END;
/
-- Procedimiento para listar todos los cursos
CREATE OR REPLACE PROCEDURE sp_list_courses IS
BEGIN
    FOR rec IN (SELECT * FROM PROLEARN.cursos) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id_curso || ', Nombre: ' || rec.nombre_curso || ', Descripción: ' || rec.descrp_curso || ', Estado: ' || rec.estado_curso || ', Categoría: ' || rec.categoria_curso);
    END LOOP;
END;
/

D;
/


/*CAPITULO_X_CURSO*/
-- Procedimiento para listar todos los capítulos de un curso
CREATE OR REPLACE PROCEDURE sp_list_chapters_of_course(
    p_id_curso IN INT
) IS
BEGIN
    FOR rec IN (SELECT ch.id_capitulo, ch.nombre_capitulo, ch.video_capitulo, ch.numero_capitulo
                FROM PROLEARN.capitulo_x_curso cxc
                JOIN PROLEARN.capitulo_hijo ch ON cxc.id_capitulo = ch.id_capitulo
                WHERE cxc.id_curso = p_id_curso) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Capítulo: ' || rec.id_capitulo || 
                             ', Nombre Capítulo: ' || rec.nombre_capitulo || 
                             ', Video Capítulo: ' || rec.video_capitulo || 
                             ', Número Capítulo: ' || rec.numero_capitulo);
    END LOOP;
END;
/





/*OTROS*/
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_FINDBYID_SP(
    P_ID_CATEGORIA IN NUMBER,
    P_CATEGORIA OUT SYS_REFCURSOR
)IS
BEGIN
    OPEN P_CATEGORIA FOR
    SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB 
    WHERE CATEGORIAS_TB_ID_CAT_PK = P_ID_CATEGORIA;
    
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.TESTI (PARA) VALUES ('A');
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN P_CATEGORIA := NULL;

END;




