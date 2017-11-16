CREATE OR REPLACE PACKAGE Pruebas_Alquileres AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idSocio_ INT, idFacturaCompra_ INT, tiempoAlquiler_ INT);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idAlquiler_ INT,
                        idSocio_ INT, idFacturaCompra_ INT, tiempoAlquiler_ INT);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idAlquiler_ INT);
END Pruebas_Alquileres;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Alquileres AS

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
        INSERT INTO Juegos VALUES (getJuegoId.NEXTVAL, 'Nombre 1', 'PC', 'Action', 'Descripcion 1', 12, 'Y', 'Y', 'Y', 'Y');--Con stock
        INSERT INTO Juegos VALUES (getJuegoId.NEXTVAL, 'Nombre 2', 'PC', 'Action', 'Descripcion 2', 12, 'Y', 'Y', 'Y', 'Y');--Con stock
        INSERT INTO Juegos VALUES (getJuegoId.NEXTVAL, 'Nombre 3', 'PC', 'Action', 'Descripcion 4', 12, 'Y', 'Y', 'Y', 'Y');--Sin stock
        
        
        --Insertar persona, socio
        INSERT INTO Personas VALUES (0, 'Nosotros', ' ', ' ', 41500, '12345678z', 'gamesystem@gamesystem.shop','Y');
        INSERT INTO Socios VALUES (0, 0, 'N');
        INSERT INTO Personas VALUES (getPersonaId.NEXTVAL, 'Chuck', 'Norris', 'Texas', 00001, '12345678z', 'walker@gamesystem.shop','Y');
        INSERT INTO Socios VALUES (getPersonaId.CURRVAL, 1000, 'Y');

        INSERT INTO Personas VALUES (getPersonaId.NEXTVAL, 'Alana', 'del Mar', 'Valencia', 24645, '12345678z', 'alana@gamesystem.shop','Y');
        INSERT INTO Socios VALUES (getPersonaId.CURRVAL, 1500, 'N');

        INSERT INTO Personas VALUES (getPersonaId.NEXTVAL, 'Francisco', 'Tobar', 'Malaga', 20739, '12345678z', 'fran@gamesystem.shop','Y');
        
        INSERT INTO Inventario VALUES (1, getJuegoId.CURRVAL -2, 500, 3.95);
        INSERT INTO Inventario VALUES (2, getJuegoId.CURRVAL -1, 100, 3.95);
        INSERT INTO Inventario VALUES (3, getJuegoId.CURRVAL, 0, 3.95);
        
        
        INSERT INTO Facturas VALUES (getFacturaId.NEXTVAL, 0, getJuegoId.CURRVAL -1, 1, 1.00, sysdate, sysdate);
        INSERT INTO Facturas VALUES (getFacturaId.NEXTVAL, 0, getJuegoId.CURRVAL -2, 1, 1.00, sysdate, sysdate);
        INSERT INTO Facturas VALUES (getFacturaId.NEXTVAL, getPersonaId.CURRVAL -1, getJuegoId.CURRVAL -1, 1, 1.00, sysdate, sysdate);
      
                
    END inicializar;
    
    --Insertar
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                    idSocio_ INT, idFacturaCompra_ INT, tiempoAlquiler_ INT) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados alquileres%ROWTYPE;
        idAlquilerResultado INTEGER;
    
    BEGIN
    
        --Inserto la factura
        INSERT INTO Facturas VALUES (idFacturaCompra_, idSocio_, getJuegoId.CURRVAL -2, 1, 1.00, sysdate, sysdate);
        
        --Inserto el alquiler
        INSERT INTO Alquileres VALUES (getAlquilerId.NEXTVAL, idFacturaCompra_, tiempoAlquiler_);
        
        idAlquilerResultado := getAlquilerId.CURRVAL;
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Alquileres A 
        WHERE A.idAlquiler = idAlquilerResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idFacturaCompra <> idFacturaCompra_ OR
            datosInsertados.tiempoAlquiler <> tiempoAlquiler_) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Alquiler EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idAlquiler_ INT,
                        idSocio_ INT, idFacturaCompra_ INT, tiempoAlquiler_ INT) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados alquileres%ROWTYPE;
    
    BEGIN
    
        --Actualizar alquiler
        UPDATE Alquileres A
        SET A.idFacturaCompra = idFacturaCompra_,
            A.tiempoAlquiler = tiempoAlquiler_
        WHERE A.idAlquiler = idAlquiler_;
        
        --Actualizar facturas
        UPDATE Facturas F
        SET F.idSocio = idSocio_
        WHERE F.idFactura = idFacturaCompra_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Alquileres A 
        WHERE A.idAlquiler = idAlquiler_;
        
         --Compruebo los datos
        IF (datosActualizados.idFacturaCompra <> idFacturaCompra_ OR
            datosActualizados.tiempoAlquiler <> tiempoAlquiler_) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Alquiler EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idAlquiler_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroAlquileresPre INT;
        numeroAlquileresPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroAlquileresPre
        FROM Alquileres A
        WHERE A.idAlquiler = idAlquiler_;
    
        --Borramos ese registro
        DELETE FROM Alquileres A
        WHERE A.idAlquiler = idAlquiler_;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroAlquileresPost
        FROM Alquileres A
        WHERE A.idAlquiler = idAlquiler_;
                
        --Comprobamos que sea cero
        IF(numeroAlquileresPre = numeroAlquileresPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Alquileres EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Alquileres;
/

SET SERVEROUTPUT ON;
 

DECLARE 
    idAlquiler INT;
    idSocio INT;
    idNoSocio INT;
    idFactura INT;
BEGIN

    Pruebas_Alquileres.inicializar;
    
    --Obtengo el id del socio
    idNoSocio := getPersonaId.CURRVAL;
    idSocio := idNoSocio -1;

    --Obtengo el id de la siguiente factura
    idFactura := getFacturaId.NEXTVAL;
        
    --Inserciones ok
    Pruebas_Alquileres.insertar('Prueba insercion ok', TRUE, idSocio, idFactura, 1);  
    
    --Obtengo el id de ese alquiler
    idAlquiler := getAlquilerId.CURRVAL;    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Alquileres.insertar('Prueba insercion id socio no existe', FALSE, idSocio+20, getFacturaId.NEXTVAL, 2);
    Pruebas_Alquileres.insertar('Prueba insercion id socio no es socio', FALSE, idNoSocio, getFacturaId.NEXTVAL, 2);
    Pruebas_Alquileres.insertar('Prueba insercion id socio Null', FALSE, NULL, getFacturaId.NEXTVAL, 2);
    Pruebas_Alquileres.insertar('Prueba insercion facturaId Null', FALSE, idSocio, NULL, 2);
    Pruebas_Alquileres.insertar('Prueba insercion tiempo alquiler cero', FALSE, idSocio, getFacturaId.NEXTVAL, 0);
    Pruebas_Alquileres.insertar('Prueba insercion tiempo alquiler Null', FALSE, idSocio, getFacturaId.NEXTVAL, NULL);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Alquileres.actualizar('Prueba actualizacion id socio', TRUE, idAlquiler, idSocio -1, idFactura, 2);
    Pruebas_Alquileres.actualizar('Prueba actualizacion idFactura', TRUE, idAlquiler, idSocio, idFactura-1, 2);
    Pruebas_Alquileres.actualizar('Prueba actualizacion tiempoAlquiler', TRUE, idAlquiler, idSocio, idFactura, 3);
   
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Alquileres.actualizar('Prueba actualizacion id socio no existe', FALSE, idAlquiler, idSocio +20, idFactura, 2);
    Pruebas_Alquileres.actualizar('Prueba actualizacion id socio no es socio', FALSE, idAlquiler, idNoSocio, idFactura, 2);
    Pruebas_Alquileres.actualizar('Prueba actualizacion facturaId Null', FALSE, idAlquiler, idSocio, NULL, 2);
    Pruebas_Alquileres.actualizar('Prueba actualizacion tiepo alquiler cero', FALSE, idAlquiler, idSocio, idFactura, 0);
    Pruebas_Alquileres.actualizar('Prueba actualizacion tiempo alquiler Null', FALSE, idAlquiler, idSocio, idFactura, NULL);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Alquileres.eliminar('Eliminacion ok', TRUE, idAlquiler);
    Pruebas_Alquileres.eliminar('Eliminacion id no existe', FALSE, idAlquiler);    

END;