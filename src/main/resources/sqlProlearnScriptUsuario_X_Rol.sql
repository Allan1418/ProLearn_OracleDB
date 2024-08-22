  
/*USUARIO*/

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.ACTUALIZAR_ROL_Y_VENCIMIENTO IS
BEGIN
  UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB
  SET 
    ROL_ID = 1,
    VENCIMIENTO_SUSCRIPCION = NULL
  WHERE 
    VENCIMIENTO_SUSCRIPCION < SYSDATE;
  COMMIT;
END;
/

-- Se creo la vista de las categorias que estan en estado 1

CREATE OR REPLACE VIEW FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIO_V AS
 SELECT 
    USUARIOS_TB_ID_USER_PK,
    NOMBRE,
    APELLIDOS,
    EMAIL,
    PASSWORD,
    ROL_ID,
    VENCIMIENTO_SUSCRIPCION
  FROM  FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIOS_TB
  WHERE ESTADO_DELET_USUARIOS = 1;


-- Se creo la vista de rol que estan en estado 1

CREATE OR REPLACE VIEW FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_V AS
SELECT 
    ROL_TB_ID_ROL_PK,
    NOMBRE
FROM 
    FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_TB
WHERE 
    ESTADO_DELET_ROL = 1;


CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.ROL_GETBY_NOMBRE_SP(
  P_NOMBRE IN VARCHAR2,
  P_ROL OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN P_ROL FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_V
  WHERE NOMBRE = P_NOMBRE;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.ROL_GETBY_ID_SP(
  P_ID_ROL IN NUMBER,
  P_CURSOR OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_V
  WHERE ROL_TB_ID_ROL_PK = P_ID_ROL;
END;
/


-- Procedimiento para buscar todos un rol por su id

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.ROL_GET_BYID_SP(
    P_ROL_ID IN NUMBER,
    P_CURSOR OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN P_CURSOR FOR
    SELECT * FROM  FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_V
    WHERE 
        ROL_TB_ID_ROL_PK = P_ROL_ID;
END;
/


CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.ROL_GET_BYALL_SP(
  P_CURSOR OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_ROL_V;
END;
/


CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USUARIO_GET_BYID_SP(
  P_ID_USER IN NUMBER,
  P_CURSOR OUT SYS_REFCURSOR
) AS
BEGIN
    FIDE_PROLEARN_FINAL_PROF.ACTUALIZAR_ROL_Y_VENCIMIENTO;
  OPEN P_CURSOR FOR
  SELECT *
  FROM FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIO_V
  WHERE USUARIOS_TB_ID_USER_PK = P_ID_USER;
END;
/

-- Procedimiento para buscar un usuario mediante su email con su estado en 1

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USUARIO_GET_BY_EMAIL_SP(
  P_EMAIL IN VARCHAR2,
  P_CURSOR OUT SYS_REFCURSOR
) AS
BEGIN
  FIDE_PROLEARN_FINAL_PROF.ACTUALIZAR_ROL_Y_VENCIMIENTO;
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIO_V
  WHERE EMAIL = P_EMAIL;
END;
/

-- Procedimiento para buscar todos los usuarios en la tabal con su estado en 1

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USUARIO_FINDALL_SP(
  P_CURSOR OUT SYS_REFCURSOR
) AS
BEGIN
  FIDE_PROLEARN_FINAL_PROF.ACTUALIZAR_ROL_Y_VENCIMIENTO;
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_USUARIO_V;
END;
/


-- Procedimiento para eliminar un usuario

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USUARIO_DELET_SP(
  p_id_usuario IN NUMBER
) AS
BEGIN
  UPDATE FIDE_USUARIOS_TB
  SET ESTADO_DELET_USUARIOS = 0
  WHERE USUARIOS_TB_ID_USER_PK = p_id_usuario;
  COMMIT;
END;
/


-- Este procedimiento tiene un parametro adicional P_ID_USUARIO que indica si se debe crear un nuevo usuario
-- (si es 0) o actualizar uno existente (si es un valor diferente de 0).

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.USUARIO_UPSERT_SP(
  P_ID_USUARIO IN NUMBER,
  P_NOMBRE IN VARCHAR2,
  P_APELLIDOS IN VARCHAR2,
  P_EMAIL IN VARCHAR2,
  P_PASSWORD IN VARCHAR2,
  P_ROL_ID IN NUMBER,
  P_ID_RESULTANTE OUT NUMBER
) AS
    V_ID_NUEVO_USUARIO NUMBER;
    V_EMAIL_EXISTENTE NUMBER;
BEGIN
  BEGIN
    SELECT COUNT(*) INTO V_EMAIL_EXISTENTE
    FROM FIDE_USUARIOS_TB
    WHERE EMAIL = P_EMAIL;

    IF V_EMAIL_EXISTENTE > 0 THEN
      P_ID_RESULTANTE := -1;
      RETURN;
    END IF;

    IF P_ID_USUARIO = 0 THEN
      INSERT INTO FIDE_USUARIOS_TB (
        NOMBRE,
        APELLIDOS,
        EMAIL,
        PASSWORD,
        ROL_ID
      ) VALUES (
        P_NOMBRE,
        P_APELLIDOS,
        P_EMAIL,
        P_PASSWORD,
        1
      ) RETURNING USUARIOS_TB_ID_USER_PK INTO V_ID_NUEVO_USUARIO;
    ELSE
      UPDATE FIDE_USUARIOS_TB
      SET NOMBRE = P_NOMBRE,
          APELLIDOS = P_APELLIDOS,
          EMAIL = P_EMAIL,
          PASSWORD = P_PASSWORD,
          ROL_ID = P_ROL_ID
      WHERE USUARIOS_TB_ID_USER_PK = P_ID_USUARIO;
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      P_ID_RESULTANTE := -1;
      RAISE;
  END;
END;
/

--------- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--------

/*USUARIO_ROL*/

