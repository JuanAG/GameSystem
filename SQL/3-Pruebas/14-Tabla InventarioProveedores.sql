CREATE OR REPLACE PACKAGE Pruebas_InvenPro AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idProveedor_ INT, idInventario_ INT);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idInventarioProvee_ INT,
                        idProveedor_ INT, idInventario_ INT);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idInventarioProvee_ INT);
END Pruebas_InvenPro;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_InvenPro AS

    --Inicializacion
    PROCEDURE inicializar AS
    BEGIN
        
        DELETE FROM Fotos;
        DELETE FROM Multimedia;
        
        DELETE FROM Compras;
        DELETE FROM Ventas;
        DELETE FROM Alquileres;        
        
        DELETE FROM InventarioProveedores;
        DELETE FROM PedidosProveedor;        
        DELETE FROM Inventario;
        DELETE FROM Proveedores; 
        
        DELETE FROM Facturas;
        
        DELETE FROM Juegos;
        
        DELETE FROM Login;
        DELETE FROM Socios;
        DELETE FROM Personas;
        
        --Insertar juegos
        INSERT INTO Juegos VALUES (getJuegoId.NEXTVAL, 'Nombre 1', 'PC', 'Action', 'Descripcion 1', 12, 'Y', 'Y', 'Y', 'Y');
        INSERT INTO Juegos VALUES (getJuegoId.NEXTVAL, 'Nombre 2', 'PC', 'Action', 'Descripcion 2', 12, 'Y', 'Y', 'Y', 'Y');
        
        --Insertar el proveeedor
        INSERT INTO Proveedores VALUES (getProveedorId.NEXTVAL, 'Proveedor 1', 'mail@proveedor1.com', 'cifNif');
        INSERT INTO Proveedores VALUES (getProveedorId.NEXTVAL, 'Proveedor 2', 'mail@proveedor2.com', 'cifNif');
        
        INSERT INTO Inventario VALUES (getInventarioId.NEXTVAL, getJuegoId.CURRVAL, 500, 3.95);
        INSERT INTO Inventario VALUES (getInventarioId.NEXTVAL, getJuegoId.CURRVAL -1, 100, 3.95);
              
        
    END inicializar;
    
    --Insertar
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idProveedor_ INT, idInventario_ INT) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados inventarioProveedores%ROWTYPE;
        idIP INTEGER;
    
    BEGIN
    
        idIP := getInventarioProveedorId.NEXTVAL;
        
        --Inserto el inventario del proveedor
        INSERT INTO InventarioProveedores VALUES (idIP, idProveedor_, idInventario_);
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM InventarioProveedores IP 
        WHERE IP.idInventarioProveedores = idIP;
        
        --Compruebo los datos
        IF (datosInsertados.idProveedor <> idProveedor_ OR
            datosInsertados.idInventario <> idInventario_) THEN
          
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de InventarioProveedores EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idInventarioProvee_ INT,
                        idProveedor_ INT, idInventario_ INT) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados inventarioProveedores%ROWTYPE;
    
    BEGIN
    
        --Actualizar inventario del proveedor
        UPDATE InventarioProveedores IP
        SET IP.idProveedor = idProveedor_,
            IP.idInventario = idInventario_
        WHERE IP.idInventarioProveedores = idInventarioProvee_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM InventarioProveedores IP 
        WHERE IP.idInventarioProveedores = idInventarioProvee_;
        
         --Compruebo los datos
        IF (datosActualizados.idProveedor <> idProveedor_ OR
            datosActualizados.idInventario <> idInventario_) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de InventarioProveedores EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idInventarioProvee_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroInventarioProveedorPre INT;
        numeroInventarioProveedorPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroInventarioProveedorPre
        FROM InventarioProveedores IP
        WHERE IP.idInventarioProveedores = idInventarioProvee_;
    
        --Borramos ese registro
        DELETE FROM InventarioProveedores IP
        WHERE IP.idInventarioProveedores = idInventarioProvee_;
        
        --Vemos la cantidad de resultados que han quedado
        SELECT COUNT(*) INTO numeroInventarioProveedorPost
        FROM InventarioProveedores IP
        WHERE IP.idInventarioProveedores = idInventarioProvee_;
        
  
        --Comprobamos que haya borrado algo
        IF(numeroInventarioProveedorPre = numeroInventarioProveedorPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de InventarioProveedores EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_InvenPro;
/

SET SERVEROUTPUT ON;
 

DECLARE 
    idInventarioProveed INT;
    idInventario INT;
    idProveedor INT;
BEGIN

    Pruebas_InvenPro.inicializar;
    
    --Obtengo los ids
    idInventario := getInventarioId.CURRVAL;
    idProveedor := getProveedorId.CURRVAL;
    
    --Inserciones ok
    Pruebas_InvenPro.insertar('Prueba insercion ok', TRUE, idProveedor, idInventario);
    
    --Obtengo el id del inventario
    idInventarioProveed := getInventarioProveedorId.CURRVAL;
    
    --Inserciones que no cumplen los requisitos
    Pruebas_InvenPro.insertar('Prueba insercion idProveedor no existe', FALSE, idProveedor-1, idInventario);
    Pruebas_InvenPro.insertar('Prueba insercion idproveedor Null', FALSE, NULL, idInventario);
    Pruebas_InvenPro.insertar('Prueba insercion idInventario no existe', FALSE, idProveedor, idInventario+1);
    Pruebas_InvenPro.insertar('Prueba insercion idInventario Null', FALSE, idProveedor, NULL);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_InvenPro.actualizar('Prueba actualizacion idProveedor', TRUE, idInventarioProveed, idProveedor+1, idInventario);
    Pruebas_InvenPro.actualizar('Prueba actualizacion idInventario', TRUE, idInventarioProveed, idProveedor, idInventario-1);
     
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_InvenPro.actualizar('Prueba actualizacion idProveedor no existe', FALSE, idInventarioProveed, idProveedor-1, idInventario);
    Pruebas_InvenPro.actualizar('Prueba actualizacion idProveedor Null', FALSE, idInventarioProveed, NULL, idInventario);
    Pruebas_InvenPro.actualizar('Prueba actualizacion idInventario no existe', FALSE, idInventarioProveed, idProveedor, idInventario+1);
    Pruebas_InvenPro.actualizar('Prueba actualizacion idInventario Null', FALSE, idInventarioProveed, idProveedor, NULL);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_InvenPro.eliminar('Eliminacion ok', TRUE, idInventarioProveed);
    Pruebas_InvenPro.eliminar('Eliminacion id no existe', FALSE, idInventarioProveed);

END;