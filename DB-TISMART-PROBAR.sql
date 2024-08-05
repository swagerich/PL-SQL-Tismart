------------------------------------------------
-- USOS DE LOS (PROCEDURE) - REGISTRAR
------------------------------------------------
BEGIN
HOSPITAL_PKG.SP_HOSPITAL_REGISTRAR(
    P_ID_DISTRITO => 1,
    P_NOMBRE => 'DOS DE MAYO IV',
    P_ANTIGUEDAD => 100,
    P_AREA => 952.20,
    P_ID_SEDE => 1,
    P_ID_GERENTE => 1,
    P_ID_CONDICION => 1);
END;


------------------------------------------------
-- USOS DE LOS (PROCEDURE) - ACTUALIZAR
-----------------------------------------------
BEGIN
    HOSPITAL_PKG.SP_HOSPITAL_ACTUALIZAR(
   P_ID_HOSPITAL => 3, 
   P_ID_DISTRITO => 2, 
   P_NOMBRE => 'SOLIDAD CALLAO 25', 
   P_ANTIGUEDAD => 20, 
   P_AREA => 100,
   P_ID_SEDE => 1, 
   P_ID_GERENTE => 1, 
   P_ID_CONDICION => 1);
END;

------------------------------------------------
-- USOS DE LOS (PROCEDURE) - LISTAR
-----------------------------------------------
BEGIN 
HOSPITAL_PKG.SP_HOSPITAL_LISTAR();
END;


------------------------------------------------
-- USOS DE LOS (PROCEDURE) - ELIMINAR
-----------------------------------------------

BEGIN
HOSPITAL_PKG.SP_HOSPITAL_ELIMINAR(P_ID_HOSPITAL => 22);
END;

