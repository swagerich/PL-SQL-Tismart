--------------------------------------
-- ACTIVAMOS LA CONSOLA DE IMPRESION
--------------------------------------
SET SERVEROUTPUT ON;

---------------------------------------------------------------------
--  ESPECIFICACION  DEL PACKETE PARA LA ENCAPSULACION,ORDEN,REUTILIZACION
---------------------------------------------------------------------

CREATE OR REPLACE PACKAGE hospital_pkg AS

    PROCEDURE sp_hospital_registrar (
        p_id_distrito  IN NUMBER,
        p_nombre       IN VARCHAR2,
        p_antiguedad   IN NUMBER,
        p_area         IN NUMBER,
        p_id_sede      IN NUMBER,
        p_id_gerente   IN NUMBER,
        p_id_condicion IN NUMBER
    );

    PROCEDURE sp_hospital_actualizar (
        p_id_hospital  IN NUMBER,
        p_id_distrito  IN NUMBER,
        p_nombre       IN VARCHAR2,
        p_antiguedad   IN NUMBER,
        p_area         IN NUMBER,
        p_id_sede      IN NUMBER,
        p_id_gerente   IN NUMBER,
        p_id_condicion IN NUMBER
    );

    PROCEDURE sp_hospital_eliminar (
        p_id_hospital IN NUMBER
    );

    PROCEDURE sp_hospital_listar;
END;


---------------------------------------
--  IMPLEMENTACION DEL  BODY DEL PACKETE
---------------------------------------

CREATE OR REPLACE PACKAGE BODY hospital_pkg AS



-- PROCEDURE PARA REGISTRAR UN HOSPITAL
---------------------------------------
 PROCEDURE sp_hospital_registrar (
    p_id_distrito  IN NUMBER,
    p_nombre       IN VARCHAR2,
    p_antiguedad   IN NUMBER,
    p_area         IN NUMBER,
    p_id_sede      IN NUMBER,
    p_id_gerente   IN NUMBER,
    p_id_condicion IN NUMBER
) AS

    v_mensaje      VARCHAR2(2000);

    V_FOREIGN_KEY_VIOLATION EXCEPTION;
    PRAGMA EXCEPTION_INIT(V_FOREIGN_KEY_VIOLATION,-02291);
    
BEGIN
     BEGIN
        INSERT INTO hospital (
            iddistrito,
            nombre,
            antiguedad,
            area,
            idsede,
            idgerente,
            idcondicion,
            fechaRegistro
        ) VALUES (
            p_id_distrito,
            p_nombre,
            p_antiguedad,
            p_area,
            p_id_sede,
            p_id_gerente,
            p_id_condicion,
            sysdate
        );
        
        COMMIT;
        v_mensaje := 'Hospital registrado con éxito!';
    
    -- MANEJAMOS LA EXCEPCION OCURRIDA
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            v_mensaje := 'Error: El hospital ya existe con los mismos datos.';
        WHEN V_FOREIGN_KEY_VIOLATION THEN
            v_mensaje := 'Error: Uno o más valores de clave foránea no existen.';
        WHEN OTHERS THEN
            v_mensaje := 'Error al registrar el hospital. Error: ' || SQLERRM;
            
        ROLLBACK;  
    END;
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;



-- PROCEDURE PARA ACTUALIZAR HOSPITAL
------------------------------------

 PROCEDURE sp_hospital_actualizar (
    p_id_hospital  IN NUMBER,
    p_id_distrito  IN NUMBER,
    p_nombre       IN VARCHAR2,
    p_antiguedad   IN NUMBER,
    p_area         IN NUMBER,
    p_id_sede      IN NUMBER,
    p_id_gerente   IN NUMBER,
    p_id_condicion IN NUMBER
) AS

v_mensaje VARCHAR2(2000);

 BEGIN
   
    UPDATE hospital
    SET
        iddistrito = p_id_distrito,
        nombre = p_nombre,
        antiguedad = p_antiguedad,
        area = p_area,
        idsede = p_id_sede,
        idgerente = p_id_gerente,
        idcondicion = p_id_condicion,
        fecharegistro = sysdate
    WHERE
        idhospital = p_id_hospital;
    
    -- SI LA FILA ES AFECTADA, SE ACTUALIZA LA DATA POR ID
    IF SQL%ROWCOUNT > 0 THEN
        v_mensaje := 'Hospital actualizado con éxito!';
    ELSE
        v_mensaje := 'No se encontró idHospital: ' || p_id_hospital || ' para su respectiva actualización';
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_mensaje);

    COMMIT;
   -- MANEJAMOS  CUALQUIER EXCEPCION
EXCEPTION
    WHEN OTHERS THEN
        v_mensaje := 'Error al actualizar el hospital con id: ' || p_id_hospital || '. Error: ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(v_mensaje);
        ROLLBACK;
END;




-- PROCEDURE PARA ELIMINAR HOSPITAL POR SU ID
--------------------------------------------

 PROCEDURE sp_hospital_eliminar (
    p_id_hospital IN NUMBER
) AS
    v_mensaje    VARCHAR2(2000);
BEGIN
    DELETE FROM hospital
    WHERE idhospital = p_id_hospital;
    
     -- SI LA FILA ES AFECTADA, SE ELIMINA LA DATA POR ID
    IF SQL%ROWCOUNT > 0 THEN
        v_mensaje := 'Hospital eliminado con éxito!';
    ELSE
        v_mensaje := 'No se encontró idHospital: ' || p_id_hospital || ' para su respectiva eliminación';
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
    COMMIT;
    
       -- MANEJAMOS  CUALQUIER EXCEPCION
EXCEPTION
    WHEN OTHERS THEN
        v_mensaje := 'Error al eliminar el hospital con id: ' || p_id_hospital || '. Error: ' || SQLERRM;
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
    ROLLBACK;
END;



-- PROCEDURE PARA LISTAR LOS HOSPITALES
---------------------------------------

 PROCEDURE SP_HOSPITAL_LISTAR AS
    CURSOR hospitales IS
        SELECT h.idHospital, h.Nombre, h.Antiguedad, h.Area, g.descGerente, c.descCondicion, s.descSede, d.descDistrito, p.descProvincia
        FROM hospital h
        INNER JOIN GERENTE g ON h.idGerente = g.idGerente
        INNER JOIN Condicion c ON h.idCondicion = c.idCondicion
        INNER JOIN sede s ON h.idSede = s.idSede
        INNER JOIN distrito d ON h.idDistrito = d.idDistrito
        INNER JOIN provincia p ON d.idProvincia = p.idProvincia;
        
    v_count number :=0;
    
BEGIN
    FOR hosp IN hospitales LOOP
        v_count := v_count +1;
        DBMS_OUTPUT.PUT_LINE('Hospital ID: ' || hosp.idHospital);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || hosp.Nombre);
        DBMS_OUTPUT.PUT_LINE('Antigüedad: ' || hosp.Antiguedad || ' ' || 'años');
        DBMS_OUTPUT.PUT_LINE('Área: ' || hosp.Area);
        DBMS_OUTPUT.PUT_LINE('Gerente: ' || hosp.descGerente);
        DBMS_OUTPUT.PUT_LINE('Condición: ' || hosp.descCondicion);
        DBMS_OUTPUT.PUT_LINE('Sede: ' || hosp.descSede);
        DBMS_OUTPUT.PUT_LINE('Distrito: ' || hosp.descDistrito);
        DBMS_OUTPUT.PUT_LINE('Provincia: ' || hosp.descProvincia);
           
        DBMS_OUTPUT.PUT_LINE('---------------------------');
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
  IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron registros en los hospitales.');
    END IF;
    
 END;

END;








