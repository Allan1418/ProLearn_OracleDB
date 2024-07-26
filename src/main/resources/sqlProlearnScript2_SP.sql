

/*USUARIOS*/

-- Procedimiento para aÃ±adir un usuario
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USER_ADD_SP (
    P_NOMBRE IN VARCHAR2,
    P_APELLIDOS IN VARCHAR2,
    P_EMAIL IN VARCHAR2,
    P_PASSWORD IN VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB (NOMBRE, APELLIDOS, EMAIL, PASSWORD)
    VALUES (P_NOMBRE, P_APELLIDOS, P_EMAIL, P_PASSWORD);
    COMMIT;
END;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.USER_ADD_SP(
    'Juan',
    'PÃ©rez',
    'juan.perez@example.com',
    'i_contraseÃ±a'
  );
END;
/

-- Procedimiento para eliminar un usuario
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USER_DELETE_SP (
  P_ID IN NUMBER
) AS
BEGIN

  DELETE FROM FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIO_ROL_TB
  WHERE USUARIO_ID = P_ID;

  DELETE FROM FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB
  WHERE USUARIOS_TB_ID_USER_PK = P_ID;

  COMMIT;
END;
/


BEGIN
  FIDE_PROLEARN_FINAL_PROF.USER_DELETE_SP(4);
END;
/


-- Procedimiento para listar todos los usuarios

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USER_FINDAL_SP(
    P_CURSOR OUT SYS_REFCURSOR) AS
BEGIN
    OPEN P_CURSOR FOR SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB;
END;
/
BEGIN
    DECLARE
    V_CURSOR   SYS_REFCURSOR; 
    V_REGISTRO FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB%ROWTYPE;
    BEGIN FIDE_PROLEARN_FINAL_PROF.SP_FINDALL_USER(
    V_CURSOR);
        LOOP
            FETCH V_CURSOR INTO V_REGISTRO;
            EXIT WHEN V_CURSOR%NOTFOUND;
            dbms_output.put_line('ID: '
                                 || V_REGISTRO.USUARIOS_TB_ID_USER_PK|| ', NOMBRE: ' || V_REGISTRO.NOMBRE ||
                                 ', APELLIDOS: '|| V_REGISTRO.APELLIDOS || ', EMAIL: '|| V_REGISTRO.EMAIL);
        END LOOP;
        CLOSE V_CURSOR;
    END;
END;
/

-- Procedimiento para obtener un usuario por correo electrÃ³nico

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USER_GET_BY_EMAILL_SP(
    P_EMAIL VARCHAR2)
AS
    V_NOMBRE     VARCHAR2(250);
    V_APELLIDOS  VARCHAR2(250);
    V_ID_USUARIO NUMBER;
BEGIN
    SELECT NOMBRE, APELLIDOS, USUARIOS_TB_ID_USER_PK
    INTO V_NOMBRE, V_APELLIDOS, V_ID_USUARIO
    FROM FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB
    WHERE EMAIL = P_EMAIL;

    DBMS_OUTPUT.PUT_LINE('ID Usuario: ' || V_ID_USUARIO);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || V_NOMBRE);
    DBMS_OUTPUT.PUT_LINE('Apellidos: ' || V_APELLIDOS);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrÃ³ el usuario con correo electrÃ³nico ' || P_EMAIL);
END;
/

BEGIN
     FIDE_PROLEARN_FINAL_PROF.USER_GET_BY_EMAILL_SP('admin@PROLEARN.com');  
END;
/




/*ROL*/ 

-- Procedimiento para crear un nuevo rol
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.ROLE_CREATE_SP(
    P_NOMBRE IN VARCHAR2
) IS
BEGIN
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_TB (NOMBRE)
    VALUES (P_Nombre);
    COMMIT;
END;
/

BEGIN
     FIDE_PROLEARN_FINAL_PROF.ROLE_CREATE_SP('ADMIN_USER');  
END;
/
SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_TB;



-- Procedimiento para obtener un rol por nombre

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.ROL_FINDBY_NOMBRE_SP(
    P_NOMBRE VARCHAR2
)
AS
    V_ID_ROL NUMBER;
    V_NOMBRE_ROL VARCHAR2(255);
BEGIN
    SELECT ROL_TB_ID_ROL_PK, NOMBRE
    INTO V_ID_ROL, V_NOMBRE_ROL
    FROM FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_TB
    WHERE NOMBRE = P_NOMBRE;

    DBMS_OUTPUT.PUT_LINE('ID Rol: ' || V_ID_ROL);
    DBMS_OUTPUT.PUT_LINE('Nombre Rol: ' || V_NOMBRE_ROL);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontrÃ³ el rol con nombre ' || P_NOMBRE);
END;
/

BEGIN
     FIDE_PROLEARN_FINAL_PROF.ROL_FINDBY_NOMBRE_SP('ROLE_USER');  
END;
/




/*USUARIO_ROL*/

-- Procedimiento para asignar un rol a un usuario
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.ROLE_ASSIGN_SP(
    P_USUARIO_ID IN INT,
    P_ROL_ID IN INT
) IS
BEGIN
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIO_ROL_TB (USUARIO_ID, ROL_ID)
    VALUES (P_USUARIO_ID, P_ROL_ID);
    COMMIT;
END;
/

BEGIN
     FIDE_PROLEARN_FINAL_PROF.ROLE_ASSIGN_SP(3,3);  
END;
/




/*CATEGORIAS*/

--Procedimiento para crear una categoria

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_SAVE_SP(
  P_Nombre_Categoria VARCHAR2
) IS
BEGIN

  INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB (
    NOMBRE_CATEGORIA
  ) VALUES (
    P_Nombre_Categoria
  );
  
  COMMIT;
END;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.CATEGORIA_SAVE_SP('Nombre de la categorÃ­a');
END;
/

--Procedimiento para eliminar una categoria por su ID

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_DELET_SP (
P_ID_CATEGORIA NUMBER) 
IS
  V_CURSOS_ASOCIADOS NUMBER;
BEGIN

  SELECT COUNT(*) INTO V_CURSOS_ASOCIADOS
  FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB
  WHERE CATEGORIA_CURSO = P_ID_CATEGORIA;
  
  IF V_CURSOS_ASOCIADOS > 0 THEN
  
    RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar la categorÃ­a porque hay cursos asociados.');
  ELSE
  
    DELETE FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB
    WHERE CATEGORIAS_TB_ID_CAT_PK = P_ID_CATEGORIA;
    
    COMMIT;
  END IF;
END;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.CATEGORIA_DELET_SP(4);
END;
/

-- Procedimiento para buscar todas las categorias
DECLARE
  V_CURSOR   SYS_REFCURSOR; 
  V_REGISTRO FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB%ROWTYPE;
BEGIN
  FOR v_registro IN (
    SELECT *
    FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_registro.CATEGORIAS_TB_ID_CAT_PK || ', NOMBRE: ' || v_registro.NOMBRE_CATEGORIA);
  END LOOP;
END;
/




/*CAPITULO_PADRE*/

-- Procedimiento para eliminar un capÃƒÂ­tulo padre

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CP_DELET_SP(
  P_ID_CAPITULO_PADRE NUMBER
) AS
BEGIN

  DELETE FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB 
  WHERE ID_CAPITULO_PADRE = P_ID_CAPITULO_PADRE;
  
  DELETE FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB 
  WHERE CAPITULO_PADRE_TB_ID_CP_PK = P_ID_CAPITULO_PADRE;
  
  COMMIT;
END;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.CP_DELET_SP(2);
END;
/


-- Crear procedimiento para crear un capÃ­tulo padre

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CP_SAVE_SP(
  P_NOMBRE_CAPITULO VARCHAR2,
  P_NUMERO_CAPITULO INT
) AS
  V_ID_CAPITULO_PADRE NUMBER;
BEGIN
  INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB (
    NOMBRE_CAPITULO_PADRE,
    NUMERO_CAPITULO_PADRE
  ) VALUES (
    P_NOMBRE_CAPITULO,
    P_NUMERO_CAPITULO
  ) RETURNING CAPITULO_PADRE_TB_ID_CP_PK INTO V_ID_CAPITULO_PADRE;
  
  COMMIT;
END;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.CP_SAVE_SP('Primera Prueba', 5);
END;
/
COMMIT;

---Se obtiene los padre mediante el ID del curso

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.GET_CAP_PADRE_X_CURSO_SP(
  p_id_curso IN NUMBER
)
AS
  CURSOR c_capitulos_padres IS
    SELECT DISTINCT cp.*
    FROM FIDE_CAPITULO_PADRE_TB cp
    JOIN FIDE_CAPITULO_HIJO_TB ch ON cp.CAPITULO_PADRE_TB_ID_CP_PK = ch.ID_CAPITULO_PADRE
    JOIN FIDE_CAPITULO_X_CURSO_TB cc ON ch.CAPITULO_HIJO_TB_ID_CH_PK = cc.ID_CAPITULO
    WHERE cc.ID_CURSO = p_id_curso
    ORDER BY cp.NUMERO_CAPITULO_PADRE;
BEGIN
  FOR r_capitulo_padre IN c_capitulos_padres LOOP
    NULL;
  END LOOP;
END;
/




/*CAPITULO_HIJO*/


-- Procedimiento para guardar un hijo

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CH_SAVE_SP(
  P_ID_CAPITULO_PADRE IN FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB.ID_CAPITULO_PADRE%TYPE,
  P_NOMBRE_CAPITULO IN VARCHAR2,
  P_NUMERO_CAPITULO IN INT
) AS
BEGIN
  INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_HIJO_TB (
  ID_CAPITULO_PADRE,
  NOMBRE_CAPITULO_HIJO,
  NUMERO_CAPITULO_HIJO)
  VALUES (P_ID_CAPITULO_PADRE, P_NOMBRE_CAPITULO, P_NUMERO_CAPITULO);
  COMMIT;
END;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.CH_SAVE_SP(5, 'Primera Prueba', 2);
END;
/
COMMIT;

-- Procedimiento para eliminar un capÃƒÂ­tulo hijo

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CH_DELETE_SP(
  P_ID_CAPITULO_HIJO IN FIDE_CAPITULO_HIJO_TB.CAPITULO_HIJO_TB_ID_CH_PK%TYPE
) AS
BEGIN

  DELETE FROM FIDE_CAPITULO_HIJO_TB
  WHERE CAPITULO_HIJO_TB_ID_CH_PK = P_ID_CAPITULO_HIJO;
  
  COMMIT;
END;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.CH_DELETE_SP(80);
END;
/


-- Procedimiento para llamar a todos los capÃƒÂ­tulo hijo

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.APITULOS_HIJOS_FIND_ALL AS
  CURSOR CUR_CAPITULOS_HIJOS IS
    SELECT *
    FROM FIDE_CAPITULO_HIJO_TB;
  
  V_REGISTRO FIDE_CAPITULO_HIJO_TB%ROWTYPE;
BEGIN
  OPEN CUR_CAPITULOS_HIJOS;
  
  DBMS_OUTPUT.PUT_LINE('ID  || Nombre ');
  
  LOOP
    FETCH CUR_CAPITULOS_HIJOS INTO V_REGISTRO;
    EXIT WHEN CUR_CAPITULOS_HIJOS%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(V_REGISTRO.CAPITULO_HIJO_TB_ID_CH_PK || ' || ' || V_REGISTRO.NOMBRE_CAPITULO_HIJO );
  END LOOP;
  
  CLOSE CUR_CAPITULOS_HIJOS;
END APITULOS_HIJOS_FIND_ALL;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.APITULOS_HIJOS_FIND_ALL;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CH_CP_FIND_ID_SP AS
  CURSOR CUR_CAPITULOS_HIJOS IS
    SELECT *
    FROM FIDE_CAPITULO_HIJO_TB;
  
  V_REGISTRO FIDE_CAPITULO_HIJO_TB%ROWTYPE;
BEGIN
  OPEN CUR_CAPITULOS_HIJOS;
  
  DBMS_OUTPUT.PUT_LINE('ID padre');
  
  LOOP
    FETCH CUR_CAPITULOS_HIJOS INTO V_REGISTRO;
    EXIT WHEN CUR_CAPITULOS_HIJOS%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE( v_registro.ID_CAPITULO_PADRE );
  END LOOP;
  
  CLOSE CUR_CAPITULOS_HIJOS;
END CH_CP_FIND_ID_SP;
/

BEGIN
  FIDE_PROLEARN_FINAL_PROF.CH_CP_FIND_ID_SP;
END;
/


---Se obtiene los hijos mediante el ID del curso y del padre

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.GET_CAPITULOS_HIJOS_SP(
  p_id_curso IN NUMBER,
  p_id_capitulo_padre IN NUMBER
)
AS
  CURSOR c_capitulos_hijos IS
    SELECT ch.*
    FROM FIDE_CAPITULO_HIJO_TB ch
    JOIN FIDE_CAPITULO_X_CURSO_TB cc ON ch.CAPITULO_HIJO_TB_ID_CH_PK = cc.ID_CAPITULO
    WHERE cc.ID_CURSO = p_id_curso
    AND ch.ID_CAPITULO_PADRE = p_id_capitulo_padre
    ORDER BY ch.NUMERO_CAPITULO_HIJO;
BEGIN
  FOR r_capitulo_hijo IN c_capitulos_hijos LOOP
    NULL;
  END LOOP;
END;
/




/*CURSOS*/

-- Procedimiento para aÃƒÂ±adir un curso

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
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id_curso || ', Nombre: ' 
|| rec.nombre_curso || ', DescripciÃƒÂ³n: ' || rec.descrp_curso || ', Estado: ' 
|| rec.estado_curso || ', CategorÃƒÂ­a: ' || rec.categoria_curso);
    END LOOP;
END;
/

---Se obtiene el curso mediante el ID

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.GET_CURSO_BY_ID_SP(
  p_id_curso IN NUMBER
)
AS
  v_curso FIDE_CURSOS_TB%ROWTYPE;
BEGIN
  SELECT 
    *
  INTO 
    v_curso
  FROM 
    FIDE_CURSOS_TB
  WHERE 
    CURSOS_TB_ID_CUR_PK = p_id_curso;
  NULL;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
END;
/




/*CAPITULO_X_CURSO*/
-- Procedimiento para listar todos los capÃƒÂ­tulos de un curso
CREATE OR REPLACE PROCEDURE sp_list_chapters_of_course(
    p_id_curso IN INT
) IS
BEGIN
    FOR rec IN (SELECT ch.id_capitulo, ch.nombre_capitulo, ch.video_capitulo, ch.numero_capitulo
                FROM PROLEARN.capitulo_x_curso cxc
                JOIN PROLEARN.capitulo_hijo ch ON cxc.id_capitulo = ch.id_capitulo
                WHERE cxc.id_curso = p_id_curso) LOOP
        DBMS_OUTPUT.PUT_LINE('ID CapÃƒÂ­tulo: ' || rec.id_capitulo || 
                             ', Nombre CapÃƒÂ­tulo: ' || rec.nombre_capitulo || 
                             ', Video CapÃƒÂ­tulo: ' || rec.video_capitulo || 
                             ', NÃƒÂºmero CapÃƒÂ­tulo: ' || rec.numero_capitulo);
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
/




