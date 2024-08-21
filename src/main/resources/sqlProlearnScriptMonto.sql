--Crea la secuencia para la tabla de monto
CREATE SEQUENCE FIDE_PROLEARN_FINAL_PROF.ID_MONTO_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;
/

-- hay que establecer una columna de algun tipo de duracion, un lapso de tiempo
-- lo de descuento no lo entiendo, hay que pensarlo

--Creacion de la tabla monto
CREATE TABLE FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB (
    MONTO_TB_ID_MT_PK NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    MONTO NUMBER(10, 2) NOT NULL,
    DESCUENTO NUMBER(5, 2) DEFAULT 0, --???
    PRECIO_CON_DESCUENTO NUMBER(10, 2) GENERATED ALWAYS AS (
    MONTO - (MONTO * DESCUENTO / 100)) VIRTUAL, --???
    FECHA_PAGO DATE, --???
    FECHA_EXPIRACION DATE, --???
    ESTADO_PUBLICO_MONTO NUMBER(1) NOT NULL,
    ESTADO_DELET_MONTO NUMBER(1) NOT NULL,
    DESCRIPCION VARCHAR2(255),
    LAST_UPDATE_BY VARCHAR2(100),
    LAST_UPDATE_DATE DATE,
    CREATED_BY VARCHAR2(100),
    CREATION_DATE DATE,
    ACCION VARCHAR2(100)
);
/

-- Crear trigger para insertar valor del secuenciador
CREATE OR REPLACE TRIGGER FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_ID_TRG
BEFORE INSERT ON FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB
FOR EACH ROW
BEGIN
  :NEW.MONTO_TB_ID_MT_PK := FIDE_PROLEARN_FINAL_PROF.ID_MONTO_SEQ.NEXTVAL;
END;
/

-- Crear trigger para establecer ESTADO en TRUE despues de la insercion
CREATE OR REPLACE TRIGGER FIDE_PROLEARN_FINAL_PROF.FIDE_CURSO_ESTADO_PUBLICO_MONTO_TRG
BEFORE INSERT ON FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB
FOR EACH ROW
BEGIN
    :NEW.ESTADO_PUBLICO_MONTO := 1 ;
END;
/

-- Crear trigger para establecer ESTADO en TRUE despues de la insercion
CREATE OR REPLACE TRIGGER FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_ESTADO_TRG
BEFORE INSERT ON FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB
FOR EACH ROW
BEGIN
    :NEW.ESTADO_DELET_MONTO := 1 ;
END;
/
--Crea el trigger de auditoría para la tabla de facturas
CREATE OR REPLACE TRIGGER FIDE_PROLEARN_FINAL_PROF.MONTO_TB_AUDIT_TRG
BEFORE INSERT OR UPDATE ON FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.CREATED_BY := USER;
        :NEW.CREATION_DATE := SYSTIMESTAMP;
        :NEW.ACCION := 'INSERT';
    ELSIF UPDATING THEN
        :NEW.LAST_UPDATE_BY := USER;
        :NEW.LAST_UPDATE_DATE := SYSTIMESTAMP;
        :NEW.ACCION := 'UPDATE';
    END IF;
END;


--Inserts de Montos
INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB (TIPO_SUSCRIPCION, PRECIO_PRINCIPAL, DESCUENTO, DESCRIPCION)
VALUES ('Mensual', 10.000, 0, 'Suscripción de un mes sin descuento');

INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB (TIPO_SUSCRIPCION, PRECIO_PRINCIPAL, DESCUENTO, DESCRIPCION)
VALUES ('Trimestral', 45.000, 15, 'Suscripción de tres meses con 15% de descuento');

INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB (TIPO_SUSCRIPCION, PRECIO_PRINCIPAL, DESCUENTO, DESCRIPCION)
VALUES ('Anual', 120.000, 35, 'Suscripción de un año con 35% de descuento');


--------------------------------Otros procedimientos----------------------------

-- Se creo la vista de Montos que estan en estado 1
CREATE OR REPLACE VIEW FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_V AS
SELECT 
  MONTO_TB_ID_MT_PK,
  NOMBRE,
  MONTO,
  DESCUENTO,
  PRECIO_CON_DESCUENTO,
  FECHA_PAGO,
  FECHA_EXPIRACION,
  ESTADO_PUBLICO_MONTO
FROM FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB
WHERE ESTADO_DELET_MONTO = 1;
/

--- Procedimiento para buscar montos mediante el id
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.MONTO_GET_BYID_SP (
  P_ID_MONTO IN NUMBER,
  P_RESULTADO OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN P_RESULTADO FOR
        SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_V
        WHERE MONTO_TB_ID_MT_PK = P_ID_MONTO;
    COMMIT;
END;
/

---Se trae los montos
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.MONTO_GETALL_SP(
  P_MONTOS OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN P_MONTOS FOR
    SELECT *
    FROM FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_V ;
END;
/

-- Procedimiento para elimnar a un monto admin
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.MONTO_DELET_SP(
  P_ID_MONTO NUMBER
) AS
BEGIN
  UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB 
  SET ESTADO_DELET_MONTO = 0
  WHERE MONTO_TB_ID_MT_PK = P_ID_MONTO;
  COMMIT;
END;
/

-- Procedimiento para listar todos los montos publico
CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.MONTO_GETALL_PUBLICO_SP(
  P_CURSOR OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN P_CURSOR FOR
  SELECT * FROM FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB
  WHERE ESTADO_PUBLICO_MONTO = 1;
END;
/

CREATE OR REPLACE PROCEDURE FIDE_PROLEARN_FINAL_PROF.MONTO_UPSERT_SP(
  P_MONTO_TB_ID_MT_PK IN NUMBER,
  P_NOMBRE IN VARCHAR2,
  P_MONTO IN NUMBER,
  P_DESCUENTO IN NUMBER,
  P_ESTADO_PUBLICO_MONTO IN NUMBER,
  P_DESCRIPCION IN VARCHAR2,
  P_ID_RESULTADO OUT NUMBER
) AS
BEGIN
  IF P_MONTO_TB_ID_MT_PK = 0 THEN
    INSERT INTO FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB (
      NOMBRE,
      MONTO,
      DESCUENTO,
      ESTADO_PUBLICO_MONTO,
      DESCRIPCION
    ) VALUES (
      P_NOMBRE,
      P_MONTO,
      P_DESCUENTO,
      P_ESTADO_PUBLICO_MONTO,
      P_DESCRIPCION
    ) RETURNING MONTO_TB_ID_MT_PK INTO P_ID_RESULTADO;
  ELSE
    UPDATE FIDE_PROLEARN_FINAL_PROF.FIDE_MONTO_TB
    SET NOMBRE = P_NOMBRE,
        MONTO = P_MONTO,
        DESCUENTO = P_DESCUENTO,
        ESTADO_PUBLICO_MONTO = P_ESTADO_PUBLICO_MONTO,
        DESCRIPCION = P_DESCRIPCION
    WHERE MONTO_TB_ID_MT_PK = P_MONTO_TB_ID_MT_PK;
  END IF;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;
