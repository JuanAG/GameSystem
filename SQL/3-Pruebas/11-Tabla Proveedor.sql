CREATE OR REPLACE PACKAGE Pruebas_Proveedor AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        nombre_ VARCHAR, mail_ VARCHAR, cif_ VARCHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idProveedor_ INT,
                        nombre_ VARCHAR, mail_ VARCHAR, cif_ VARCHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idProveedor_ INT);
END Pruebas_Proveedor;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Proveedor AS

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
        
    END inicializar;
    
    --Insertar
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                    nombre_ VARCHAR, mail_ VARCHAR, cif_ VARCHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados proveedores%ROWTYPE;
        idProveedorResultado INTEGER;
    
    BEGIN
    
        idProveedorResultado := getProveedorId.NEXTVAL;

        --Inserto el proveedor
        INSERT INTO Proveedores VALUES (idProveedorResultado, nombre_, mail_, cif_);
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Proveedores P 
        WHERE P.idProveedor = idProveedorResultado;
        
        --Compruebo los datos
        IF (TRIM(datosInsertados.nombre) <> TRIM(nombre_) OR
            TRIM(datosInsertados.mail) <> TRIM(mail_) OR
            TRIM(datosInsertados.cifnif) <> TRIM(cif_)) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Proveedor EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idProveedor_ INT,
                        nombre_ VARCHAR, mail_ VARCHAR, cif_ VARCHAR) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados proveedores%ROWTYPE;
    
    BEGIN
    
        --Actualizar proveedor
        UPDATE Proveedores P
        SET P.nombre = nombre_,
            P.mail = mail_,
            P.cifNif = cif_
        WHERE P.idProveedor = idProveedor_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Proveedores P 
        WHERE P.idProveedor = idProveedor_;
        
         --Compruebo los datos
        IF (TRIM(datosActualizados.nombre) <> TRIM(nombre_) OR
            TRIM(datosActualizados.mail) <> TRIM(mail_) OR
            TRIM(datosActualizados.cifnif) <> TRIM(cif_)) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Proveedor EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idProveedor_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroProveedoresPre INT;
        numeroProveedoresPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroProveedoresPre
        FROM Proveedores P
        WHERE P.idProveedor = idProveedor_;
        
        --Borramos ese registro
        DELETE FROM Proveedores P
        WHERE P.idProveedor = idProveedor_;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroProveedoresPost
        FROM Proveedores P
        WHERE P.idProveedor = idProveedor_;
        
        --Comprobamos que sea cero
        IF(numeroProveedoresPre = numeroProveedoresPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Proveedor EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Proveedor;
/

SET SERVEROUTPUT ON;
 

DECLARE 
    idProveedor INT;
BEGIN

    Pruebas_Proveedor.inicializar;
    
    --Inserciones ok
    Pruebas_Proveedor.insertar('Prueba insercion ok', TRUE, 'NombreProveedor', 'mail@proveedor.com', 'cifNif');
    
    --Obtengo el id de ese proveedor
    idProveedor := getProveedorId.CURRVAL;
    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Proveedor.insertar('Prueba insercion nombre Null', FALSE, NULL, 'mail2@proveedor.com', 'cifNif');
    Pruebas_Proveedor.insertar('Prueba insercion nombre vacio', FALSE, '', 'mail3@proveedor.com', 'cifNif');
    Pruebas_Proveedor.insertar('Prueba insercion mail vacio', FALSE, 'NombreProveedor', '', 'cifNif');
    Pruebas_Proveedor.insertar('Prueba insercion mail sin arroba', FALSE, 'NombreProveedor', 'mail5proveedor.com', 'cifNif');
    Pruebas_Proveedor.insertar('Prueba insercion mail sin punto', FALSE, 'NombreProveedor', 'mail6@proveedorcom', 'cifNif');
    Pruebas_Proveedor.insertar('Prueba insercion mail Null', FALSE, 'NombreProveedor', NULL, 'cifNif');
    Pruebas_Proveedor.insertar('Prueba insercion cif vacio', FALSE, 'NombreProveedor', 'mail7@proveedor.com', '');
    Pruebas_Proveedor.insertar('Prueba insercion cif Null', FALSE, 'NombreProveedor', 'mail8@proveedor.com', NULL);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Proveedor.actualizar('Prueba actualizacion nombre', TRUE, idProveedor, 'NombreProveedorActualizado', 'mail@proveedor.com', 'cifNif');
    Pruebas_Proveedor.actualizar('Prueba actualizacion mail', TRUE, idProveedor, 'NombreProveedor', 'mailActualizado@proveedor.com', 'cifNif');
    Pruebas_Proveedor.actualizar('Prueba actualizacion cif', TRUE, idProveedor, 'NombreProveedor', 'mail@proveedor.com', 'cifNifAct');
     
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Proveedor.actualizar('Prueba actualizacion nombre a Null', FALSE, idProveedor, NULL, 'mail9@proveedor.com', 'cifNif');
    Pruebas_Proveedor.actualizar('Prueba actualizacion nombre vacio', FALSE, idProveedor, '', 'mail10@proveedor.com', 'cifNif');
    Pruebas_Proveedor.actualizar('Prueba actualizacion mail vacio', FALSE, idProveedor, 'NombreProveedor', '', 'cifNif');
    Pruebas_Proveedor.actualizar('Prueba actualizacion mail sin arroba', FALSE, idProveedor, 'NombreProveedor', 'mail11proveedor.com', 'cifNif');
    Pruebas_Proveedor.actualizar('Prueba actualizacion mail sin punto', FALSE, idProveedor, 'NombreProveedor', 'mail12@proveedorcom', 'cifNif');
    Pruebas_Proveedor.actualizar('Prueba actualizacion mail a Null', FALSE, idProveedor, 'NombreProveedor', NULL, 'cifNif');
    Pruebas_Proveedor.actualizar('Prueba actualizacion cif vacio', FALSE, idProveedor, 'NombreProveedor', 'mail13@proveedor.com', '');
    Pruebas_Proveedor.actualizar('Prueba actualizacion cif a Null', FALSE, idProveedor, 'NombreProveedor', 'mail14@proveedor.com', NULL);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Proveedor.eliminar('Eliminacion ok', TRUE, idProveedor);
    Pruebas_Proveedor.eliminar('Eliminacion id no existe', FALSE, idProveedor);

END;