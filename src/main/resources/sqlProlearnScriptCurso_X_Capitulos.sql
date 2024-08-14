
/*CATEGORIAS*/



-- Se creo la vista de las categorias que estan en estado 1
CREATE OR REPLACE VIEW FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_V AS
 SELECT 
  CATEGORIAS_TB_ID_CAT_PK ,
  NOMBRE_CATEGORIA ,
  LAST_UPDATE_BY ,
  ESTADO_DELET_CATEGORIA 
  FROM  FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB
  WHERE ESTADO_DELET_CATEGORIA = 1;
  COMMIT;
/



--Se busaca el ID de Categoria

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_FINDBYID_SP(
    P_ID_CATEGORIA IN NUMBER,
    P_CATEGORIA OUT SYS_REFCURSOR
)IS
BEGIN
    OPEN P_CATEGORIA FOR
    SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_V 
    WHERE CATEGORIAS_TB_ID_CAT_PK = P_ID_CATEGORIA;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN P_CATEGORIA := NULL;

END;
/


-- Este procedimiento tiene un parámetro adicional P_ID_CATEGORIA que indica si se debe crear una nueva categoria
-- (si es 0) o actualizar uno existente (si es un valor diferente de 0).

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CATEGORIA_SAVE_UPDATE_SP(
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
    ESTADO_PUBLICO,
    ESTADO_DELET_CURSO
  FROM 
    FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB
  WHERE ESTADO_DELET_CURSO = 1;
/

---Se obtiene el curso mediante el ID

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSO_GET_BY_ID_SP(
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

-- Procedimiento para actualizar el estao del curso

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSO_ACTUALIZAR_ESTADO_DELET_SP(
  P_ID_CURSO NUMBER,
  P_ESTADO_DELET_CURSO NUMBER
)
AS
BEGIN
  UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB
  SET ESTADO_DELET_CURSO = P_ESTADO_DELET_CURSO
  WHERE CURSOS_TB_ID_CUR_PK = P_ID_CURSO;
  
  COMMIT;
END;
/


-- Procedimiento para listar todos los cursos publico

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSOS_GET_PUBLICO_SP(
  P_CURSOR OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_V;
END;
/


-- Procedimiento para listar todos los cursos administrador

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSOS_GET_ADMIN_SP(
  P_CURSOR OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_V;
END;
/


-- Este procedimiento tiene un parámetro adicional P_ID_CURSO que indica si se debe crear un nuevo curso
-- (si es 0) o actualizar uno existente (si es un valor diferente de 0).

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CURSO_SAVE_UPDATE_SP(
  P_ID_CURSO IN NUMBER,
  P_NOMBRE_CURSO IN VARCHAR2,
  P_DESCRP_CURSO IN VARCHAR2,
  P_THUMBNAIL_CURSO IN VARCHAR2,
  P_CATEGORIA_CURSO IN INT
) AS
BEGIN
  IF P_ID_CURSO = 0 THEN
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB (
      NOMBRE_CURSO,
      DESCRP_CURSO,
      THUMBNAIL_CURSO,
      CATEGORIA_CURSO
    ) VALUES (
      P_NOMBRE_CURSO,
      P_DESCRP_CURSO,
      P_THUMBNAIL_CURSO,
      P_CATEGORIA_CURSO
    );
  ELSE
    UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_CURSOS_TB
    SET NOMBRE_CURSO = P_NOMBRE_CURSO,
        DESCRP_CURSO = P_DESCRP_CURSO,
        THUMBNAIL_CURSO = P_THUMBNAIL_CURSO,
        CATEGORIA_CURSO = P_CATEGORIA_CURSO
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

