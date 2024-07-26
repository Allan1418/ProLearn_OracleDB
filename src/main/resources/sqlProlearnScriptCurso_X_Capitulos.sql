CREATE TABLE FIDE_PROLEARN_FINAL_PROF.TESTI (
  PARA VARCHAR2(2)
);

/*CATEGORIAS*/


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
  
    RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar la categoria porque hay cursos asociados.');
  ELSE
  
    DELETE FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB
    WHERE CATEGORIAS_TB_ID_CAT_PK = P_ID_CATEGORIA;
    
    COMMIT;
  END IF;
END;
/



-- Procedimiento para buscar todas las categorias

DECLARE
  V_CURSOR   SYS_REFCURSOR; 
  V_REGISTRO FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB%ROWTYPE;
BEGIN
  FOR v_registro IN (SELECT *FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CATEGORIAS_TB ) 
  LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_registro.CATEGORIAS_TB_ID_CAT_PK || ', NOMBRE: ' || v_registro.NOMBRE_CATEGORIA);
  END LOOP;
END;
/




/*CURSOS*/

-- Procedimiento para agregar un curso

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
|| rec.nombre_curso || ', DescripciÃ³n: ' || rec.descrp_curso || ', Estado: ' 
|| rec.estado_curso || ', CategorÃ­a: ' || rec.categoria_curso);
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
-- Procedimiento para listar todos los capitulos de un curso
CREATE OR REPLACE PROCEDURE sp_list_chapters_of_course(
    p_id_curso IN INT
) IS
BEGIN
    FOR rec IN (SELECT ch.id_capitulo, ch.nombre_capitulo, ch.video_capitulo, ch.numero_capitulo
                FROM PROLEARN.capitulo_x_curso cxc
                JOIN PROLEARN.capitulo_hijo ch ON cxc.id_capitulo = ch.id_capitulo
                WHERE cxc.id_curso = p_id_curso) LOOP
        DBMS_OUTPUT.PUT_LINE('ID CapÃ­tulo: ' || rec.id_capitulo || 
                             ', Nombre CapÃ­tulo: ' || rec.nombre_capitulo || 
                             ', Video CapÃ­tulo: ' || rec.video_capitulo || 
                             ', NÃºmero CapÃ­tulo: ' || rec.numero_capitulo);
    END LOOP;
END;
/