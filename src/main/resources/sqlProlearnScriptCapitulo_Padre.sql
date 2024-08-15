/*CAPITULO_PADRE*/


-- Se creo la vista de los capitulos padre que estan en estado 1

CREATE OR REPLACE VIEW FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_V AS
 SELECT 
  CAPITULO_PADRE_TB_ID_CP_PK ,
  NOMBRE_CAPITULO_PADRE,
  NUMERO_CAPITULO_PADRE
  FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB
  WHERE ESTADO_DELET_PADRE = 1;
/

--- Procedimiento para buscar al Capitulo Padre mediante el id

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CAPITULO_PADRE_GET_BYID_SP (
  P_ID_CAPITULO_PADRE IN NUMBER,
  P_RESULTADO OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN P_RESULTADO FOR
        SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_V
        WHERE CAPITULO_PADRE_TB_ID_CP_PK = P_ID_CAPITULO_PADRE;
        COMMIT; 
END;
/


---Se busca el ID del Curso y el Padre relacionado al Curso

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CAPITULO_PADRE_GETALL_BY_CURSO_SP(
  P_ID_CURSO IN NUMBER,
  P_CAPITULOS_PADRES OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN P_CAPITULOS_PADRES FOR
    SELECT DISTINCT CP.* FROM FIDE_CAPITULO_PADRE_V CP
    JOIN FIDE_CAPITULO_HIJO_TB  CH ON CP.CAPITULO_PADRE_TB_ID_CP_PK = CH.ID_CAPITULO_PADRE
    JOIN FIDE_CAPITULO_X_CURSO_TB CC ON CH.CAPITULO_HIJO_TB_ID_CH_PK = CC.ID_CAPITULO
    WHERE CC.ID_CURSO = P_ID_CURSO
    ORDER BY CP.NUMERO_CAPITULO_PADRE;
END;
/



-- Procedimiento para elimnar a un padre capitulo padre

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CAPITULO_PADRE_DELET_SP(
  P_ID_CAPITULO_PADRE NUMBER
) AS
BEGIN
  UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB 
  SET ESTADO_DELET_PADRE = 0
  WHERE CAPITULO_PADRE_TB_ID_CP_PK = P_ID_CAPITULO_PADRE;
  COMMIT;
END;
/


-- Este procedimiento tiene un parametro adicional P_ID_CAPITULO_PADRE que indica si se debe crear un
-- nuevo capatulo padre (si es 0) o actualizar uno existente (si es un valor diferente de 0).

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.CAPITULO_PADRE_UPSERT_SP(
  P_ID_CAPITULO_PADRE IN NUMBER,
  P_NOMBRE_CAPITULO_PADRE IN VARCHAR2,
  P_NUMERO_CAPITULO_PADRE IN INT,
  P_ID_CURSO IN NUMBER
) AS
  V_ID_NUEVO_PADRE NUMBER;
BEGIN
  IF P_ID_CAPITULO_PADRE = 0 THEN
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB (
      NOMBRE_CAPITULO_PADRE,
      NUMERO_CAPITULO_PADRE
    ) VALUES (
      P_NOMBRE_CAPITULO_PADRE,
      P_NUMERO_CAPITULO_PADRE
    ) RETURNING CAPITULO_PADRE_TB_ID_CP_PK INTO V_ID_NUEVO_PADRE;
    
    FIDE_PROLEARN_FINAL_PROF.CAPITULO_HIJO_UPSERT_SP(
      0,
      V_ID_NUEVO_PADRE,
      'Ejemplo',
      1,
      NULL,
      P_ID_CURSO
    );
    
  ELSE
    UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_CAPITULO_PADRE_TB
    SET NOMBRE_CAPITULO_PADRE = P_NOMBRE_CAPITULO_PADRE,
        NUMERO_CAPITULO_PADRE = P_NUMERO_CAPITULO_PADRE
    WHERE CAPITULO_PADRE_TB_ID_CP_PK = P_ID_CAPITULO_PADRE;
  END IF;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;
/

