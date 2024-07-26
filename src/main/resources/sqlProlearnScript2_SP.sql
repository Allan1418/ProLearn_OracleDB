

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
    USUARIOS_TB_ID_USER_PK,
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
    USUARIOS_TB_ID_USER_PK,
    NOMBRE,
    APELLIDOS,
    EMAIL,
    PASSWORD
  FROM 
    FIDE_USUARIOS_TB
  WHERE 
    USUARIOS_TB_ID_USER_PK = p_id;
END US_FIND_USUARIO_BY_ID_SP;

-- delete
--para eliminar un registro de la tabla
ALTER TABLE FIDE_USUARIOS_TB
ADD ESTADO VARCHAR2(10) DEFAULT 'ACTIVO';

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.US_ACTUALIZAR_ESTADO_USUARIO_SP(
  p_id_usuario NUMBER,
  p_estado VARCHAR2 DEFAULT 'INACTIVO'
)
AS
BEGIN
  UPDATE FIDE_USUARIOS_TB
  SET ESTADO = p_estado
  WHERE USUARIOS_TB_ID_USER_PK = p_id_usuario;
  
--  COMMIT;
END;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.US_ACTUALIZAR_ESTADO_USUARIO_SP(1, 'ACTIVO');
END;
/

--eliminar físicamente el registro de la tabla
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.US_ELIMINAR_USUARIO_SP(
  p_id_usuario NUMBER
)
AS
BEGIN
  DELETE FROM FIDE_USUARIOS_TB
  WHERE USUARIOS_TB_ID_USER_PK = p_id_usuario;
  
--  COMMIT;
END US_ELIMINAR_USUARIO_SP;
/

/*ROL*/
--findByNombre
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.RL_FIND_ROL_BY_NOMBRE_SP(
  p_nombre IN VARCHAR2,
  p_roles OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_roles FOR
  SELECT 
    ROL_TB_ID_ROL_PK,
    NOMBRE
  FROM 
    FIDE_ROL_TB
  WHERE 
    UPPER(NOMBRE) LIKE UPPER('%' || p_nombre || '%');
END RL_FIND_ROL_BY_NOMBRE_SP;
/

--SAVE ROL
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.RL_GUARDAR_ROL_SP(
  p_nombre IN VARCHAR2,
  p_id_rol OUT NUMBER
)
AS
BEGIN
  INSERT INTO FIDE_ROL_TB (NOMBRE)
  VALUES (p_nombre)
  RETURNING ROL_TB_ID_ROL_PK INTO p_id_rol;
  
 -- COMMIT;
END RL_GUARDAR_ROL_SP;
/

--delete ROL
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.RL_ELIMINAR_ROL_SP(
  p_id_rol IN NUMBER
)
AS
BEGIN
  DELETE FROM FIDE_ROL_TB
  WHERE ROL_TB_ID_ROL_PK = p_id_rol;
  
--  COMMIT;
END RL_ELIMINAR_ROL_SP;
/



/*USUARIO_ROL*/






/*CATEGORIAS*/






/*CAPITULO_PADRE*/

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CP_FINDBYID_SP (
  P_ID_CAPITULO_PADRE IN NUMBER,
  P_RESULTADO OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN P_RESULTADO FOR
        SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB
        WHERE CAPITULO_PADRE_TB_ID_CP_PK = P_ID_CAPITULO_PADRE;
    
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.TESTI (PARA) VALUES ('B');
    COMMIT; 

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        OPEN P_RESULTADO FOR SELECT NULL FROM DUAL WHERE 1=0;
END;




/*CAPITULO_HIJO*/
CREATE TABLE FIDE_PROLEARN_FINAL_PROF.TESTI (
  PARA VARCHAR2(2)
);


CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CH_FINDBYID_SP (
    P_ID_CAPITULO_HIJO IN NUMBER,
    P_RESULTADO OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN P_RESULTADO FOR
        SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB CH
        WHERE CH.CAPITULO_HIJO_TB_ID_CH_PK = P_ID_CAPITULO_HIJO;
    
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.TESTI (PARA) VALUES ('A');
    COMMIT; 

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        OPEN P_RESULTADO FOR SELECT NULL FROM DUAL WHERE 1=0; 
END;    

select * from FIDE_PROLEARN_FINAL_PROF.TESTI;

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
--llama al curso
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CS_FIND_ALL_CURSOS_SP(
  p_cursos OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_cursos FOR
  SELECT 
    CURSOS_TB_ID_CUR_PK,
    NOMBRE_CURSO,
    DESCRP_CURSO,
    ESTADO_CURSO,
    THUMBNAIL_CURSO,
    CATEGORIA_CURSO
  FROM 
    FIDE_CURSOS_TB;
END CS_FIND_ALL_CURSOS_SP;
/

--
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CS_FIND_CURSO_BY_ID_SP(
  p_id IN NUMBER,
  p_curso OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_curso FOR
  SELECT 
    CURSOS_TB_ID_CUR_PK,
    NOMBRE_CURSO,
    DESCRP_CURSO,
    ESTADO_CURSO,
    THUMBNAIL_CURSO,
    CATEGORIA_CURSO
  FROM 
    FIDE_CURSOS_TB
  WHERE 
    CURSOS_TB_ID_CUR_PK = p_id;
END CS_FIND_CURSO_BY_ID_SP;
/

-- save
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CS_SAVE_CURSO_SP(
  p_nombre_curso IN VARCHAR2,
  p_descripcion_curso IN VARCHAR2,
  p_estado_curso IN NUMBER,
  p_thumbnail_curso IN VARCHAR2,
  p_categoria_curso IN NUMBER,
  p_id OUT NUMBER
) AS
BEGIN
  INSERT INTO FIDE_CURSOS_TB (
    NOMBRE_CURSO,
    DESCRP_CURSO,
    ESTADO_CURSO,
    THUMBNAIL_CURSO,
    CATEGORIA_CURSO
  ) VALUES (
    p_nombre_curso,
    p_descripcion_curso,
    p_estado_curso,
    p_thumbnail_curso,
    p_categoria_curso
  ) RETURNING CURSOS_TB_ID_CUR_PK INTO p_id;
END CS_SAVE_CURSO_SP;
/

--DELETE
CREATE OR REPLACE PROCEDURE CS_DELETE_CURSO_SP(
  p_id IN NUMBER
) AS
BEGIN
  -- Eliminar dependencias en FIDE_CATEGORIAS_TB
  DELETE FROM FIDE_CATEGORIAS_TB
  WHERE CATEGORIAS_TB_ID_CAT_PK IN (
    SELECT CATEGORIA_CURSO
    FROM FIDE_CURSOS_TB
    WHERE CURSOS_TB_ID_CUR_PK = p_id
  );
  
  -- Eliminar registro en FIDE_CURSOS_TB
  DELETE FROM FIDE_CURSOS_TB
  WHERE CURSOS_TB_ID_CUR_PK = p_id;
END CS_DELETE_CURSO_SP;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.CS_DELETE_CURSO_SP(1);
END;

/*CAPITULO_X_CURSO*/






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




--------------------------paquetes----------------------------------------------
-------------Paquetes uauraios----------

--Paquete Crear usuario 
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_creacion_usuarios AS
    PROCEDURE crear_usuario(
        p_nombre IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.NOMBRE%TYPE,
        p_apellidos IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.APELLIDOS%TYPE,
        p_email IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.EMAIL%TYPE,
        p_password IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.PASSWORD%TYPE
    );
END pkg_creacion_usuarios;
/

--Paquete Actualiar usuario
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_actualizacion_usuarios AS
    PROCEDURE actualizar_usuario(
        p_id_usuario IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.USUARIOS_TB_ID_USER_PK%TYPE,
        p_nombre IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.NOMBRE%TYPE,
        p_apellidos IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.APELLIDOS%TYPE,
        p_email IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.EMAIL%TYPE
    );
END pkg_actualizacion_usuarios;
/

--Paquete Consultar usuario
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_consulta_usuarios AS
    FUNCTION obtener_usuario_por_id(
        p_id_usuario IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.USUARIOS_TB_ID_USER_PK%TYPE
    ) RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB%ROWTYPE;

    FUNCTION obtener_usuario_por_email(
        p_email IN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB.EMAIL%TYPE
    ) RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB%ROWTYPE;
END pkg_consulta_usuarios;
/

------Paquetes categoria------
--Paquete crear categoria
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_creacion_categorias AS
    PROCEDURE crear_categoria(p_nombre_categoria IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB.NOMBRE_CATEGORIA%TYPE);
END pkg_creacion_categorias;
/

--Paquete actualizar categoria
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_actualizacion_categorias AS
    PROCEDURE actualizar_categoria(p_id_categoria IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB.CATEGORIAS_TB_ID_CAT_PK%TYPE, 
    p_nombre_categoria IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB.NOMBRE_CATEGORIA%TYPE);
END pkg_actualizacion_categorias;
/

--Paquete consultar categoria
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_consulta_categorias AS
    FUNCTION obtener_categoria_por_id(p_id_categoria IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB.CATEGORIAS_TB_ID_CAT_PK%TYPE) 
    RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB%ROWTYPE;
    FUNCTION obtener_categoria_por_nombre(p_nombre_categoria IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB.NOMBRE_CATEGORIA%TYPE) 
    RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB%ROWTYPE;
END pkg_consulta_categorias;
/

-------Paquete capitulo padre-----
--Paquete crear capitulo padre
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_creacion_capitulo_padre AS
    PROCEDURE crear_capitulo_padre(p_nombre_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB.NOMBRE_CAPITULO_PADRE%TYPE, 
    p_numero_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB.NUMERO_CAPITULO_PADRE%TYPE);
END pkg_creacion_capitulo_padre;
/

--Paquete actualiza capitulo padre
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_actualizacion_capitulo_padre AS
    PROCEDURE actualizar_capitulo_padre(p_id_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB.CAPITULO_PADRE_TB_ID_CP_PK%TYPE, 
    p_nombre_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB.NOMBRE_CAPITULO_PADRE%TYPE,
    p_numero_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB.NUMERO_CAPITULO_PADRE%TYPE);
END pkg_actualizacion_capitulo_padre;
/

--Paquete consulta capitulo padre
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_consulta_capitulo_padre AS
    FUNCTION obtener_capitulo_padre_por_id(p_id_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB.CAPITULO_PADRE_TB_ID_CP_PK%TYPE) 
    RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB%ROWTYPE;
    FUNCTION obtener_capitulo_padre_por_nombre(p_nombre_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB.NOMBRE_CAPITULO_PADRE%TYPE) 
    RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB%ROWTYPE;
    
END pkg_consulta_capitulo_padre;
/

------Paqute capitulo hijo ----------------
-- Paquete crear capitulo hijo 
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_creacion_capitulo_hijo AS
    PROCEDURE crear_capitulo_hijo(p_id_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.ID_CAPITULO_PADRE%TYPE, 
    p_nombre_capitulo_hijo IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.NOMBRE_CAPITULO_HIJO%TYPE, p_video_capitulo IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.VIDEO_CAPITULO%TYPE, p_numero_capitulo_hijo IN
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.NUMERO_CAPITULO_HIJO%TYPE);
END pkg_creacion_capitulo_hijo;
/
--Paquete actualizar capitulo hijo 
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_actualizacion_capitulo_hijo AS
    PROCEDURE actualizar_capitulo_hijo(p_id_capitulo_hijo IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.CAPITULO_HIJO_TB_ID_CH_PK%TYPE, 
    p_id_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.ID_CAPITULO_PADRE%TYPE, 
    p_nombre_capitulo_hijo IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.NOMBRE_CAPITULO_HIJO%TYPE, 
    p_video_capitulo IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.VIDEO_CAPITULO%TYPE, 
    p_numero_capitulo_hijo IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.NUMERO_CAPITULO_HIJO%TYPE);
END pkg_actualizacion_capitulo_hijo;
/
--Paquete consultar capitulo hijo 
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_consulta_capitulo_hijo AS
    FUNCTION obtener_capitulo_hijo_por_id(p_id_capitulo_hijo IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.CAPITULO_HIJO_TB_ID_CH_PK%TYPE)
    RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB%ROWTYPE;
    FUNCTION obtener_capitulo_hijo_por_nombre(p_nombre_capitulo_hijo IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.NOMBRE_CAPITULO_HIJO%TYPE) 
    RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB%ROWTYPE;
    FUNCTION obtener_capitulo_hijo_por_id_capitulo_padre(p_id_capitulo_padre IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.ID_CAPITULO_PADRE%TYPE) 
    RETURN SYS_REFCURSOR;
END pkg_consulta_capitulo_hijo;
/

------Paquete cusrsos----
--Paquete crear curso
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_creacion_cursos AS
    PROCEDURE crear_curso(p_nombre_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.NOMBRE_CURSO%TYPE, p_descripcion_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.DESCRP_CURSO%TYPE, p_estado_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.ESTADO_CURSO%TYPE, p_thumbnail_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.THUMBNAIL_CURSO%TYPE, p_categoria_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.CATEGORIA_CURSO%TYPE);
END pkg_creacion_cursos;
/
--Paquete actualizar curso
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_actualizacion_cursos AS
    PROCEDURE actualizar_curso(p_id_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.CURSOS_TB_ID_CUR_PK%TYPE, p_nombre_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.NOMBRE_CURSO%TYPE, p_descripcion_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.DESCRP_CURSO%TYPE, p_estado_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.ESTADO_CURSO%TYPE, p_thumbnail_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.THUMBNAIL_CURSO%TYPE, p_categoria_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.CATEGORIA_CURSO%TYPE);
END pkg_actualizacion_cursos;
/
--Paquete consultar cusrso
CREATE OR REPLACE PACKAGE FIDE_PROLEARN_FINAL_PROF.pkg_consulta_cursos AS
    FUNCTION obtener_curso_por_id(p_id_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.CURSOS_TB_ID_CUR_PK%TYPE) 
    RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB%ROWTYPE;
    FUNCTION obtener_curso_por_nombre(p_nombre_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.NOMBRE_CURSO%TYPE)
    RETURN FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB%ROWTYPE;
    FUNCTION obtener_cursos_por_categoria(p_categoria_curso IN 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB.CATEGORIA_CURSO%TYPE) 
    RETURN SYS_REFCURSOR;
END pkg_consulta_cursos;
/

-------------------------Cursores-------------------------------------
--Cursor recuperar los datos de la tabla  usuarios
SET SERVEROUTPUT ON
DECLARE
    -- Declaración del cursor
    CURSOR usuarios_cursor IS
        SELECT USUARIOS_TB_ID_USER_PK, NOMBRE, APELLIDOS, EMAIL, PASSWORD
        FROM FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB;

    -- Variables para almacenar los datos recuperados por el cursor
    v_id_usuario NUMBER;
    v_nombre VARCHAR2(250);
    v_apellidos VARCHAR2(250);
    v_email VARCHAR2(25);
    v_password VARCHAR2(512);
BEGIN
    -- Abrir el cursor
    OPEN usuarios_cursor;

    -- Recuperar y mostrar los datos de los usuarios
    LOOP
        FETCH usuarios_cursor INTO v_id_usuario, v_nombre, v_apellidos, v_email, v_password;
        EXIT WHEN usuarios_cursor%NOTFOUND;

        -- Mostrar los datos del usuario
        DBMS_OUTPUT.PUT_LINE('ID Usuario: ' || v_id_usuario);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre);
        DBMS_OUTPUT.PUT_LINE('Apellidos: ' || v_apellidos);
        DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
        DBMS_OUTPUT.PUT_LINE('Password: ' || v_password);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;

    -- Cerrar el cursor
    CLOSE usuarios_cursor;
END;
/

--Cursor recuperar los datos de la tabla rol
DECLARE
    -- Declaración del cursor
    CURSOR roles_cursor IS
        SELECT ROL_TB_ID_ROL_PK, NOMBRE
        FROM FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_TB;

    -- Variables para almacenar los datos recuperados por el cursor
    v_id_rol NUMBER;
    v_nombre VARCHAR2(255);
BEGIN
    -- Abrir el cursor
    OPEN roles_cursor;

    -- Recuperar y mostrar los datos de los roles
    LOOP
        FETCH roles_cursor INTO v_id_rol, v_nombre;
        EXIT WHEN roles_cursor%NOTFOUND;

        -- Mostrar los datos del rol
        DBMS_OUTPUT.PUT_LINE('ID Rol: '|| v_id_rol);
        DBMS_OUTPUT.PUT_LINE('Nombre: '|| v_nombre);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;

    -- Cerrar el cursor
    CLOSE roles_cursor;
END;
/

--cursor recuperar los datos de la tabla catergoria 
DECLARE
    -- Declaración del cursor
    CURSOR categorias_cursor IS
        SELECT CATEGORIAS_TB_ID_CAT_PK, NOMBRE_CATEGORIA
        FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB;
    
    -- Variables para almacenar los datos recuperados por el cursor
    v_id_categoria NUMBER;
    v_nombre_categoria VARCHAR2(255);
BEGIN
    -- Abrir el cursor
    OPEN categorias_cursor;
    
    -- Recuperar y mostrar los datos de las categorías
    LOOP
        FETCH categorias_cursor INTO v_id_categoria, v_nombre_categoria;
        EXIT WHEN categorias_cursor%NOTFOUND;
        
        -- Mostrar los datos de la categoría
        DBMS_OUTPUT.PUT_LINE('ID Categoría: ' || v_id_categoria);
        DBMS_OUTPUT.PUT_LINE('Nombre Categoría: ' || v_nombre_categoria);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE categorias_cursor;
END;
/

--Cursor recuperar los datos de la tabla capitulos_padre
DECLARE
    -- Declaración del cursor
    CURSOR capitulos_padre_cursor IS
        SELECT CAPITULO_PADRE_TB_ID_CP_PK, NOMBRE_CAPITULO_PADRE, NUMERO_CAPITULO_PADRE
        FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB;
    
    -- Variables para almacenar los datos recuperados por el cursor
    v_id_capitulo_padre NUMBER;
    v_nombre_capitulo_padre VARCHAR2(255);
    v_numero_capitulo_padre INT;
BEGIN
    -- Abrir el cursor
    OPEN capitulos_padre_cursor;
    
    -- Recuperar y mostrar los datos de los capítulos padre
    LOOP
        FETCH capitulos_padre_cursor INTO v_id_capitulo_padre, v_nombre_capitulo_padre, v_numero_capitulo_padre;
        EXIT WHEN capitulos_padre_cursor%NOTFOUND;
        
        -- Mostrar los datos del capítulo padre
        DBMS_OUTPUT.PUT_LINE('ID Capítulo Padre: '|| v_id_capitulo_padre);
        DBMS_OUTPUT.PUT_LINE('Nombre Capítulo Padre: '|| v_nombre_capitulo_padre);
        DBMS_OUTPUT.PUT_LINE('Número Capítulo Padre: '|| v_numero_capitulo_padre);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE capitulos_padre_cursor;
END;
/

--Cursor recuperar los datos de la tabla capitulos_hijo
DECLARE
    -- Declaración del cursor
    CURSOR capitulos_hijo_cursor IS
        SELECT CH.CAPITULO_HIJO_TB_ID_CH_PK, CH.ID_CAPITULO_PADRE, CH.NOMBRE_CAPITULO_HIJO, CH.VIDEO_CAPITULO, CH.NUMERO_CAPITULO_HIJO, CP.NOMBRE_CAPITULO_PADRE
        FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB CH
        JOIN FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB CP ON CH.ID_CAPITULO_PADRE = CP.CAPITULO_PADRE_TB_ID_CP_PK;
    
    -- Variables para almacenar los datos recuperados por el cursor
    v_id_capitulo_hijo NUMBER;
    v_id_capitulo_padre INT;
    v_nombre_capitulo_hijo VARCHAR2(255);
    v_video_capitulo VARCHAR2(1024);
    v_numero_capitulo_hijo INT;
    v_nombre_capitulo_padre VARCHAR2(255);
BEGIN
    -- Abrir el cursor
    OPEN capitulos_hijo_cursor;
    
    -- Recuperar y mostrar los datos de los capítulos hijo
    LOOP
        FETCH capitulos_hijo_cursor INTO v_id_capitulo_hijo, v_id_capitulo_padre, v_nombre_capitulo_hijo, v_video_capitulo, v_numero_capitulo_hijo, v_nombre_capitulo_padre;
        EXIT WHEN capitulos_hijo_cursor%NOTFOUND;
        
        -- Mostrar los datos del capítulo hijo
        DBMS_OUTPUT.PUT_LINE('ID Capítulo Hijo: ' || v_id_capitulo_hijo);
        DBMS_OUTPUT.PUT_LINE('ID Capítulo Padre: ' || v_id_capitulo_padre);
        DBMS_OUTPUT.PUT_LINE('Nombre Capítulo Hijo: ' || v_nombre_capitulo_hijo);
        DBMS_OUTPUT.PUT_LINE('Video Capítulo: ' || v_video_capitulo);
        DBMS_OUTPUT.PUT_LINE('Número Capítulo Hijo: ' || v_numero_capitulo_hijo);
        DBMS_OUTPUT.PUT_LINE('Nombre Capítulo Padre: ' || v_nombre_capitulo_padre);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE capitulos_hijo_cursor;
END;
/

--Cursor recuperar los datos de la tabla Cursos
DECLARE
    -- Declaración del cursor
    CURSOR cursos_cursor IS
        SELECT C.CURSOS_TB_ID_CUR_PK, C.NOMBRE_CURSO, C.DESCRP_CURSO, C.ESTADO_CURSO, C.THUMBNAIL_CURSO, C.CATEGORIA_CURSO, CG.NOMBRE_CATEGORIA
        FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB C
        JOIN FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB CG ON C.CATEGORIA_CURSO = CG.CATEGORIAS_TB_ID_CAT_PK;
    
    -- Variables para almacenar los datos recuperados por el cursor
    v_id_curso NUMBER;
    v_nombre_curso VARCHAR2(250);
    v_descripcion_curso VARCHAR2(1000);
    v_estado_curso NUMBER(1);
    v_thumbnail_curso VARCHAR2(1024);
    v_categoria_curso INT;
    v_nombre_categoria VARCHAR2(250);
BEGIN
    -- Abrir el cursor
    OPEN cursos_cursor;
    
    -- Recuperar y mostrar los datos de los cursos
    LOOP
        FETCH cursos_cursor INTO v_id_curso, v_nombre_curso, v_descripcion_curso, v_estado_curso, v_thumbnail_curso, v_categoria_curso, v_nombre_categoria;
        EXIT WHEN cursos_cursor%NOTFOUND;
        
        -- Mostrar los datos del curso
        DBMS_OUTPUT.PUT_LINE('ID Curso: ' || v_id_curso);
        DBMS_OUTPUT.PUT_LINE('Nombre Curso: ' || v_nombre_curso);
        DBMS_OUTPUT.PUT_LINE('Descripción Curso: ' || v_descripcion_curso);
        DBMS_OUTPUT.PUT_LINE('Estado Curso: ' || v_estado_curso);
        DBMS_OUTPUT.PUT_LINE('Thumbnail Curso: ' || v_thumbnail_curso);
        DBMS_OUTPUT.PUT_LINE('Categoría Curso: ' || v_categoria_curso);
        DBMS_OUTPUT.PUT_LINE('Nombre Categoría: ' || v_nombre_categoria);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE cursos_cursor;
END;
/

--Cursor recuperar los datos de la tabla capitulos_x_cursos
DECLARE
    -- Declaración del cursor
    CURSOR capitulos_x_cursos_cursor IS
        SELECT CXC.CAP_X_CUR_TB_ID_PK, CXC.ID_CURSO, CXC.ID_CAPITULO, C.NOMBRE_CURSO, CH.NOMBRE_CAPITULO_HIJO
        FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_X_CURSO_TB CXC
        JOIN FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB C ON CXC.ID_CURSO = C.CURSOS_TB_ID_CUR_PK
        JOIN FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB CH ON CXC.ID_CAPITULO = CH.CAPITULO_HIJO_TB_ID_CH_PK;
    
    -- Variables para almacenar los datos recuperados por el cursor
    v_id_capitulo_x_curso NUMBER;
    v_id_curso INT;
    v_id_capitulo INT;
    v_nombre_curso VARCHAR2(250);
    v_nombre_capitulo_hijo VARCHAR2(255);
BEGIN
    -- Abrir el cursor
    OPEN capitulos_x_cursos_cursor;
    
    -- Recuperar y mostrar los datos de los capítulos por curso
    LOOP
        FETCH capitulos_x_cursos_cursor INTO v_id_capitulo_x_curso, v_id_curso, v_id_capitulo, v_nombre_curso, v_nombre_capitulo_hijo;
        EXIT WHEN capitulos_x_cursos_cursor%NOTFOUND;
        
        -- Mostrar los datos del capítulo por curso
        DBMS_OUTPUT.PUT_LINE('ID Capítulo x Curso: '|| v_id_capitulo_x_curso);
        DBMS_OUTPUT.PUT_LINE('ID Curso: '|| v_id_curso);
        DBMS_OUTPUT.PUT_LINE('ID Capítulo: '|| v_id_capitulo);
        DBMS_OUTPUT.PUT_LINE('Nombre Curso: '|| v_nombre_curso);
        DBMS_OUTPUT.PUT_LINE('Nombre Capítulo Hijo: '|| v_nombre_capitulo_hijo);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE capitulos_x_cursos_cursor;
END;
/

