CREATE OR REPLACE PACKAGE Pruebas_Facturas AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idSocio_ INT, idJuego_ INT, cantidad_ INT, precio_ NUMBER, fechaPedido_ DATE, fechaEntrega_ DATE);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idFactura_ INT,
                        idSocio_ INT, idJuego_ INT, cantidad_ INT, precio_ NUMBER, fechaPedido_ DATE, fechaEntrega_ DATE);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idFactura_ INT);
END Pruebas_Facturas;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Facturas AS

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
        
        
        INSERT INTO Inventario VALUES (1, getJuegoId.CURRVAL -2, 500, 3.95);
        INSERT INTO Inventario VALUES (2, getJuegoId.CURRVAL -1, 1000, 3.95);
        INSERT INTO Inventario VALUES (3, getJuegoId.CURRVAL, 0, .95);
                
        --Insertar persona, socio
        INSERT INTO Personas VALUES (0, 'Nosotros', ' ', ' ', 41500, '12345678z', 'gamesystem@gamesystem.shop','Y');
        INSERT INTO Socios VALUES (0, 0, 'N');
        INSERT INTO Personas VALUES (getPersonaId.NEXTVAL, 'Chuck', 'Norris', 'Texas', 00001, '12345678z', 'walker@gamesystem.shop','Y');
        INSERT INTO Socios VALUES (getPersonaId.CURRVAL, 1000, 'Y');

        INSERT INTO Personas VALUES (getPersonaId.NEXTVAL, 'Alana', 'del Mar', 'Valencia', 24645, '12345678z', 'alana@gamesystem.shop','Y');
        INSERT INTO Socios VALUES (getPersonaId.CURRVAL, 1500, 'N');

        INSERT INTO Personas VALUES (getPersonaId.NEXTVAL, 'Francisco', 'Tobar', 'Malaga', 20739, '12345678z', 'fran@gamesystem.shop','Y');
        
        --Insertar el proveedor
        INSERT INTO Proveedores VALUES (getProveedorId.NEXTVAL,'Steam', 'steam@steam.com', 'A1234567A');
        
        --Compro el stock
        INSERT INTO Facturas VALUES (getFacturaId.NEXTVAL, 0, getJuegoId.CURRVAL -2, 100, 9.99, sysdate, sysdate);
        INSERT INTO Facturas VALUES (getFacturaId.NEXTVAL, 0, getJuegoId.CURRVAL -1, 100, 9.99, sysdate, sysdate);
        INSERT INTO Facturas VALUES (getFacturaId.NEXTVAL, 0, getJuegoId.CURRVAL, 1, 9.99, sysdate, sysdate);
               
    END inicializar;
    
    --Insertar
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                    idSocio_ INT, idJuego_ INT, cantidad_ INT, precio_ NUMBER, fechaPedido_ DATE, fechaEntrega_ DATE) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados facturas%ROWTYPE;
        idFacturaResultado INTEGER; 
    
    BEGIN
    
        idFacturaResultado := getFacturaId.NEXTVAL;
        
        --Inserto la factura
        INSERT INTO Facturas VALUES (idFacturaResultado, idSocio_, idJuego_, cantidad_, precio_, fechaPedido_, fechaEntrega_);
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Facturas F 
        WHERE F.idFactura = idFacturaResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idSocio <> idSocio_ OR
            datosInsertados.idJuego <> idJuego_ OR
            datosInsertados.cantidad <> cantidad_ OR
            datosInsertados.precio <> precio_ OR
            datosInsertados.fechaPedido <> fechaPedido_ OR
            datosInsertados.fechaEntrega <> fechaEntrega_) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Facturas EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idFactura_ INT,
                        idSocio_ INT, idJuego_ INT, cantidad_ INT, precio_ NUMBER, fechaPedido_ DATE, fechaEntrega_ DATE) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados facturas%ROWTYPE;
    
    BEGIN
    
        --Actualizar facturas
        UPDATE Facturas F
        SET F.idSocio = idSocio_,
            F.idJuego = idJuego_,
            F.cantidad = cantidad_,
            F.precio = precio_,
            F.fechaPedido = fechaPedido_,
            F.fechaEntrega = fechaEntrega_
        WHERE F.idFactura = idFactura_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Facturas F 
        WHERE F.idFactura = idFactura_;
        
         --Compruebo los datos
        IF (datosActualizados.idSocio <> idSocio_ OR
            datosActualizados.idJuego <> idJuego_ OR
            datosActualizados.cantidad <> cantidad_ OR
            datosActualizados.precio <> precio_ OR
            datosActualizados.fechaPedido <> fechaPedido_ OR
            datosActualizados.fechaEntrega <> fechaEntrega_) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Facturas EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idFactura_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroFacturasPre INT;
        numeroFacturasPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroFacturasPre
        FROM Facturas F
        WHERE F.idFactura = idFactura_;
    
        --Borramos ese registro
        DELETE FROM Facturas F
        WHERE F.idFactura = idFactura_;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroFacturasPost
        FROM Facturas F
        WHERE F.idFactura = idFactura_;
        
        --Comprobamos que sea cero
        IF(numeroFacturasPre = numeroFacturasPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Facturas EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Facturas;
/

SET SERVEROUTPUT ON;
 

DECLARE 
    idFactura INT;
    idJuego INT;
    idJuegoSinStock INT;
    idSocio INT;
    idNoSocio INT;
    idProveedor INT;
    fechaAnterior DATE;
    fechaMitad DATE;
    fechaPosterior DATE;
BEGIN

    --Creo las fechas
    fechaAnterior := SYSDATE-1;
    fechaMitad := SYSDATE;
    fechaPosterior := SYSDATE+1;

    Pruebas_Facturas.inicializar;
    
    --Obtengo el id de juego
    idJuego := getJuegoId.CURRVAL;
    
    --Obtengo el id del proveedor
    idProveedor := getProveedorId.CURRVAL;
    
    --Obtengo el id del socio
    idNoSocio := getPersonaId.CURRVAL;
    idSocio := idNoSocio -1;

    
    --Inserciones ok
    Pruebas_Facturas.insertar('Prueba insercion ok', TRUE, idSocio, idJuego, 1, 9.99, fechaMitad, fechaMitad);  
    
    --Obtengo el id de esa factura
    idFactura := getFacturaId.CURRVAL;    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Facturas.insertar('Prueba insercion id socio no existe', FALSE, idSocio+20, idJuego, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion id socio no es socio', FALSE, idNoSocio, idJuego, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion id socio Null', FALSE, NULL, idJuego, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion id juego que no existe', FALSE, idSocio, idJuego+10, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion id juego Null', FALSE, idSocio, NULL, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion cantidad negativa', FALSE, idSocio, idJuego, -1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion cantidad Null', FALSE, idSocio, idJuego, NULL, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion precio negativo', FALSE, idSocio, idJuego, 1, -9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion precio Null', FALSE, idSocio, idJuego, 1, NULL, fechaMitad, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion fechaPedido Null', FALSE, idSocio, idJuego, 1, 9.99, NULL, fechaMitad);
    Pruebas_Facturas.insertar('Prueba insercion fechaEntrega Null', FALSE, idSocio, idJuego, 1, 9.99, fechaMitad, NULL);
    Pruebas_Facturas.insertar('Prueba insercion fechaEntrega antes que fechaPedido', FALSE, idSocio, idJuego, 1, 9.99, fechaMitad, fechaAnterior);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Facturas.actualizar('Prueba actualizacion id socio', TRUE, idFactura, idSocio -1, idJuego, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion id juego', TRUE, idFactura, idSocio, idJuego-1, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion cantidad', TRUE, idFactura, idSocio, idJuego, 2, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion precio', TRUE, idFactura, idSocio, idJuego, 1, 19.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion fechaPedido anterior', TRUE, idFactura, idSocio, idJuego, 1, 9.99, fechaAnterior, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion fechaEntrega posterior', TRUE, idFactura, idSocio, idJuego, 1, 9.99, fechaMitad, fechaPosterior);
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Facturas.actualizar('Prueba actualizacion id socio no existe', FALSE, idFactura, idSocio +20, idJuego, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion id socio no es socio', FALSE, idFactura, idNoSocio, idJuego, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion id socio Null', FALSE, idFactura, NULL, idJuego, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion id juego no existe', FALSE, idFactura, idSocio, idJuego+10, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion id juego Null', FALSE, idFactura, idSocio, NULL, 1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion cantidad negativa', FALSE, idFactura, idSocio, idJuego, -1, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion cantidad Null', FALSE, idFactura, idSocio, idJuego, NULL, 9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion precio negativo', FALSE, idFactura, idSocio, idJuego, 1, -9.99, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion precio Null', FALSE, idFactura, idSocio, idJuego, 1, NULL, fechaMitad, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion fecha pedido Null', FALSE, idFactura, idSocio, idJuego, 1, 9.99, NULL, fechaMitad);
    Pruebas_Facturas.actualizar('Prueba actualizacion fecha entrega Null', FALSE, idFactura, idSocio, idJuego, 1, 9.99, fechaMitad, NULL);
    Pruebas_Facturas.actualizar('Prueba actualizacion fechaEntrega antes que fechaPedido', FALSE, idFactura, idSocio, idJuego, 1, 9.99, fechaMitad, fechaAnterior);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Facturas.eliminar('Eliminacion ok', TRUE, idFactura);
    Pruebas_Facturas.eliminar('Eliminacion id no existe', FALSE, idFactura);    

END;