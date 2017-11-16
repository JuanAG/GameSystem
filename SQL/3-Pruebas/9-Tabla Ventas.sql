CREATE OR REPLACE PACKAGE Pruebas_Ventas AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idSocio_ INT, idFacturaCompra_ INT, descripcionEstado_ VARCHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idVenta_ INT,
                        idSocio_ INT, idFacturaCompra_ INT, descripcionEstado_ VARCHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idVenta_ INT);
END Pruebas_Ventas;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Ventas AS

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
                    idSocio_ INT, idFacturaCompra_ INT, descripcionEstado_ VARCHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados ventas%ROWTYPE;
        idVentaResultado INTEGER;
    
    BEGIN
    
        --Inserto la factura
        INSERT INTO Facturas VALUES (idFacturaCompra_, idSocio_, getJuegoId.CURRVAL -2, 1, 1.00, sysdate, sysdate);
        
        --Inserto la venta
        INSERT INTO Ventas VALUES (getVentaId.NEXTVAL, idFacturaCompra_, descripcionEstado_);
        
        idVentaResultado := getVentaId.CURRVAL;
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Ventas V 
        WHERE V.idVenta = idVentaResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idFacturaCompra <> idFacturaCompra_ OR
            TRIM(datosInsertados.descripcionEstado) <> TRIM(descripcionEstado_)) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Ventas EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idVenta_ INT,
                        idSocio_ INT, idFacturaCompra_ INT, descripcionEstado_ VARCHAR) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados ventas%ROWTYPE;
    
    BEGIN
    
        --Actualizar ventas
        UPDATE Ventas V
        SET V.idFacturaCompra = idFacturaCompra_,
            V.descripcionEstado = descripcionEstado_
        WHERE V.idVenta = idVenta_;
        
        --Actualizar facturas
        UPDATE Facturas F
        SET F.idSocio = idSocio_
        WHERE F.idFactura = idFacturaCompra_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Ventas V 
        WHERE v.idVenta = idVenta_;
        
         --Compruebo los datos
        IF (datosActualizados.idFacturaCompra <> idFacturaCompra_ OR
            TRIM(datosActualizados.descripcionEstado) <> TRIM(descripcionEstado_)) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Ventas EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idVenta_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroVentasPre INT;
        numeroVentasPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroVentasPre
        FROM Ventas V
        WHERE V.idVenta = idVenta_;
        
        --Borramos ese registro
        DELETE FROM Ventas V
        WHERE V.idVenta = idVenta_;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroVentasPost
        FROM Ventas V
        WHERE V.idVenta = idVenta_;
        
        --Comprobamos que sea cero
        IF(numeroVentasPre = numeroVentasPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Ventas EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Ventas;
/

SET SERVEROUTPUT ON;
 

DECLARE 
    idVenta INT;
    idSocio INT;
    idNoSocio INT;
    idFactura INT;
BEGIN

    Pruebas_Ventas.inicializar;
    
    --Obtengo el id del socio
    idNoSocio := getPersonaId.CURRVAL;
    idSocio := idNoSocio -1;

    --Obtengo el id de la siguiente factura
    idFactura := getFacturaId.NEXTVAL;
    
    --Inserciones ok
    Pruebas_Ventas.insertar('Prueba insercion ok', TRUE, idSocio, idFactura, 'Descripcion');  
    
    --Obtengo el id de esa venta
    idVenta := getVentaId.CURRVAL;    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Ventas.insertar('Prueba insercion id socio no existe', FALSE, idSocio+20, getFacturaId.NEXTVAL, 'Descripcion');
    Pruebas_Ventas.insertar('Prueba insercion id socio no es socio', FALSE, idNoSocio, getFacturaId.NEXTVAL, 'Descripcion');
    Pruebas_Ventas.insertar('Prueba insercion id socio Null', FALSE, NULL, getFacturaId.NEXTVAL, 'Descripcion');
    Pruebas_Ventas.insertar('Prueba insercion facturaId Null', FALSE, idSocio, NULL, 'Descripcion');
    Pruebas_Ventas.insertar('Prueba insercion descripcion vacia', FALSE, idSocio, getFacturaId.NEXTVAL, '');
    Pruebas_Ventas.insertar('Prueba insercion descripcion Null', FALSE, idSocio, getFacturaId.NEXTVAL, NULL);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Ventas.actualizar('Prueba actualizacion id socio', TRUE, idVenta, idSocio -1, idFactura, 'Descripcion');
    Pruebas_Ventas.actualizar('Prueba actualizacion idFactura', TRUE, idVenta, idSocio, idFactura-1, 'Descripcion');
    Pruebas_Ventas.actualizar('Prueba actualizacion descripcion', TRUE, idVenta, idSocio, idFactura, 'Nueva descripcion');
   
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Ventas.actualizar('Prueba actualizacion id socio no existe', FALSE, idVenta, idSocio +20, idFactura, 'Descripcion');
    Pruebas_Ventas.actualizar('Prueba actualizacion id socio no es socio', FALSE, idVenta, idNoSocio, idFactura, 'Descripcion');
    Pruebas_Ventas.actualizar('Prueba actualizacion facturaId Null', FALSE, idVenta, idSocio, NULL, 'Descripcion');
    Pruebas_Ventas.actualizar('Prueba actualizacion descripcion vacia', FALSE, idVenta, idSocio, idFactura, '');
    Pruebas_Ventas.actualizar('Prueba actualizacion descripcion Null', FALSE, idVenta, idSocio, idFactura, NULL);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Ventas.eliminar('Eliminacion ok', TRUE, idVenta);
    Pruebas_Ventas.eliminar('Eliminacion id no existe', FALSE, idVenta);    

END;