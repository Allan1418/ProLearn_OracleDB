/*CATEGORIAS*/



-- Se creo la vista de las categorias que estan en estado 1
CREATE OR REPLACE VIEW FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_V AS
 SELECT 
  CATEGORIAS_TB_ID_CAT_PK ,
  NOMBRE_CATEGORIA
  FROM  FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB
  WHERE ESTADO_DELET_CATEGORIA = 1;
/



--Se busaca el ID de Categoria

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_GET_BYID_SP(
    P_ID_CATEGORIA IN NUMBER,
    P_CATEGORIA OUT SYS_REFCURSOR
)IS
BEGIN
    OPEN P_CATEGORIA FOR
    SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_V 
    WHERE CATEGORIAS_TB_ID_CAT_PK = P_ID_CATEGORIA;
EXCEPTION
    WHEN NO_DATA_FOUND THEN P_CATEGORIA := NULL;

END;
/


-- Procedimiento para listar todos las categorias


CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_GETALL_SP(
  P_CURSOR OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN P_CURSOR FOR
    SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_V;
END;
/


-- Procedimiento para eliminar una categoria

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_DELET_SP(
  P_ID_CATEGORIA IN NUMBER
) AS
BEGIN
  UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB
  SET ESTADO_DELET_CATEGORIA = 0
  WHERE CATEGORIAS_TB_ID_CAT_PK = P_ID_CATEGORIA;
  COMMIT;
END;
/


-- Este procedimiento tiene un parametro adicional P_ID_CATEGORIA que indica si se debe crear una nueva categoria
-- (si es 0) o actualizar uno existente (si es un valor diferente de 0).

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_UPSERT_SP(
  P_ID_CATEGORIA IN NUMBER,
  P_NOMBRE_CATEGORIA IN VARCHAR2
) AS
BEGIN
  IF P_ID_CATEGORIA = 0 THEN
    INSERT INTO FIDE_CATEGORIAS_TB (
      NOMBRE_CATEGORIA
    ) VALUES (
      P_NOMBRE_CATEGORIA
    );
  ELSE
    UPDATE FIDE_CATEGORIAS_TB
    SET NOMBRE_CATEGORIA = P_NOMBRE_CATEGORIA
    WHERE CATEGORIAS_TB_ID_CAT_PK = P_ID_CATEGORIA;
  END IF;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;
/

--------- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--------

/*CURSOS*/

-- Se creo la vista de los cursos que estan en estado 1

CREATE OR REPLACE VIEW FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_V AS
 SELECT 
    CURSOS_TB_ID_CUR_PK,
    NOMBRE_CURSO,
    DESCRP_CURSO,
    THUMBNAIL_CURSO,
    CATEGORIA_CURSO,
    ESTADO_PUBLICO
  FROM 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB
  WHERE ESTADO_DELET_CURSO = 1;
/

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.OBTENER_CURSOS_USUARIO_SP (
    P_ID_USUARIO IN NUMBER,
    P_CURSOR_CURSOS OUT SYS_REFCURSOR 
)
AS
BEGIN
    OPEN P_CURSOR_CURSOS FOR
        SELECT 
            CV.*
        FROM 
            FIDE_USUARIOS_CURSOS_V UCV
            INNER JOIN FIDE_CURSOS_V CV ON UCV.ID_CURSO = CV.CURSOS_TB_ID_CUR_PK
        WHERE 
            UCV.ID_USER = P_ID_USUARIO;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.INSERTAR_RELACION_USUARIO_CURSO_SP (
    P_ID_CURSO IN NUMBER,
    P_ID_USUARIO IN NUMBER
)
AS
    V_EXISTE_RELACION NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO V_EXISTE_RELACION
    FROM FIDE_USUARIOS_CURSOS_TB 
    WHERE ID_USER = P_ID_CURSO
    AND ID_CURSO = P_ID_USUARIO;

    IF V_EXISTE_RELACION = 0 THEN
        INSERT INTO FIDE_USUARIOS_CURSOS_TB (
            ID_USER,
            ID_CURSO
        ) 
        VALUES (
            P_ID_CURSO,
            P_ID_USUARIO 
        );

        COMMIT; 
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

---Se obtiene el curso mediante el ID

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSO_GET_BYID_SP(
  P_ID_CURSO IN NUMBER,
  P_CURSOS OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN P_CURSOS FOR
    SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_V
    WHERE CURSOS_TB_ID_CUR_PK = P_ID_CURSO;
END;
/

-- Procedimiento para eliminar un curso

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSO_DELET_SP(
  P_ID_CURSO NUMBER
)
AS
BEGIN
  UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB
  SET ESTADO_DELET_CURSO = 0
  WHERE CURSOS_TB_ID_CUR_PK = P_ID_CURSO;
  
  COMMIT;
END;
/


-- Procedimiento para listar todos los cursos publico

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSOS_GETALL_PUBLICO_SP(
  P_CURSOR OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_V
  WHERE ESTADO_PUBLICO = 1;
END;
/


-- Procedimiento para listar todos los cursos administrador

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSOS_GETALL_ADMIN_SP(
  P_CURSOR OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_V
  ORDER BY CURSOS_TB_ID_CUR_PK DESC;
END;
/


-- Este procedimiento tiene un parametro adicional P_ID_CURSO que indica si se debe crear un nuevo curso
-- (si es 0) o actualizar uno existente (si es un valor diferente de 0).

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSO_UPSERT_SP(
  P_ID_CURSO IN NUMBER,
  P_NOMBRE_CURSO IN VARCHAR2,
  P_DESCRP_CURSO IN VARCHAR2,
  P_THUMBNAIL_CURSO IN VARCHAR2,
  P_CATEGORIA_CURSO IN INT,
  P_ESTADO_PUBLICO IN NUMBER,
  P_ID_RESULTADO OUT NUMBER
) AS
BEGIN
  IF P_ID_CURSO = 0 THEN
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB (
      NOMBRE_CURSO,
      DESCRP_CURSO,
      THUMBNAIL_CURSO,
      CATEGORIA_CURSO,
      ESTADO_PUBLICO
    ) VALUES (
      P_NOMBRE_CURSO,
      P_DESCRP_CURSO,
      P_THUMBNAIL_CURSO,
      P_CATEGORIA_CURSO,
      0
    )RETURNING CURSOS_TB_ID_CUR_PK INTO P_ID_RESULTADO;
  ELSE
    UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB
    SET NOMBRE_CURSO = P_NOMBRE_CURSO,
        DESCRP_CURSO = P_DESCRP_CURSO,
        THUMBNAIL_CURSO = P_THUMBNAIL_CURSO,
        CATEGORIA_CURSO = P_CATEGORIA_CURSO,
        ESTADO_PUBLICO = P_ESTADO_PUBLICO
    WHERE CURSOS_TB_ID_CUR_PK = P_ID_CURSO;
  END IF;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;
/


--------- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--------

/*CAPITULO_X_CURSO*/

