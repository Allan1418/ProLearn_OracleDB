

/*USUARIOS*/






/*ROL*/






/*USUARIO_ROL*/






/*CATEGORIAS*/






/*CAPITULO_PADRE*/






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
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN P_CAPITULO_HIJO := NULL;

END;



/*CURSOS*/






/*CAPITULO_X_CURSO*/






/*OTROS*/





