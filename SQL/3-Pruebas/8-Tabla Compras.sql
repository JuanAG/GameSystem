CREATE OR REPLACE PACKAGE Pruebas_Compras AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idSocio_ INT, idFacturaCompra_ INT, esPagado_ CHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idCompra_ INT,
                        idSocio_ INT, idFacturaCompra_ INT, esPagado_ CHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idCompra_ INT);
END Pruebas_Compras;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Compras AS

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
                    idSocio_ INT, idFacturaCompra_ INT, esPagado_ CHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados compras%ROWTYPE;
        idCompraResultado INTEGER;
    
    BEGIN
    
        --Inserto la factura
        INSERT INTO Facturas VALUES (idFacturaCompra_, idSocio_, getJuegoId.CURRVAL -2, 1, 1.00, sysdate, sysdate);
        
        --Inserto la compra
        INSERT INTO Compras VALUES (getCompraId.NEXTVAL, idFacturaCompra_, esPagado_);
        
        idCompraResultado := getCompraId.CURRVAL;
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Compras C 
        WHERE C.idCompra = idCompraResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idFacturaCompra <> idFacturaCompra_ OR
            datosInsertados.esPagado <> esPagado_) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Compras EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idCompra_ INT,
                        idSocio_ INT, idFacturaCompra_ INT, esPagado_ CHAR) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados compras%ROWTYPE;
    
    BEGIN
    
        --Actualizar compras
        UPDATE Compras C
        SET C.idFacturaCompra = idFacturaCompra_,
            C.esPagado = esPagado_
        WHERE C.idCompra = idCompra_;
        
        --Actualizar facturas
        UPDATE Facturas F
        SET F.idSocio = idSocio_
        WHERE F.idFactura = idFacturaCompra_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Compras C 
        WHERE C.idCompra = idCompra_;
        
         --Compruebo los datos
        IF (datosActualizados.idFacturaCompra <> idFacturaCompra_ OR
            datosActualizados.esPagado <> esPagado_) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Compras EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idCompra_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroComprasPre INT;
        numeroComprasPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroComprasPre
        FROM Compras C
        WHERE C.idCompra = idCompra_;
        
        --Borramos ese registro
        DELETE FROM Compras C
        WHERE C.idCompra = idCompra_;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroComprasPost
        FROM Compras C
        WHERE C.idCompra = idCompra_;
        
        --Comprobamos que sea cero
        IF(numeroComprasPre = numeroComprasPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Compras EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Compras;
/

SET SERVEROUTPUT ON;
 

DECLARE 
    idCompra INT;
    idSocio INT;
    idNoSocio INT;
    idFactura INT;
BEGIN

    Pruebas_Compras.inicializar;
    
    --Obtengo el id del socio
    idNoSocio := getPersonaId.CURRVAL;
    idSocio := idNoSocio -1;

    --Obtengo el id de la siguiente factura
    idFactura := getFacturaId.NEXTVAL;
    
    --Inserciones ok
    Pruebas_Compras.insertar('Prueba insercion ok', TRUE, idSocio, idFactura, 'Y');
    Pruebas_Compras.insertar('Prueba insercion ok', TRUE, idSocio, getFacturaId.NEXTVAL, 'N');
  
    
    --Obtengo el id de esa compra
    idCompra := getCompraId.CURRVAL;    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Compras.insertar('Prueba insercion id socio no existe', FALSE, idSocio+20, getFacturaId.NEXTVAL, 'Y');
    Pruebas_Compras.insertar('Prueba insercion id socio no es socio', FALSE, idNoSocio, getFacturaId.NEXTVAL, 'Y');
    Pruebas_Compras.insertar('Prueba insercion id socio Null', FALSE, NULL, getFacturaId.NEXTVAL, 'Y');
    Pruebas_Compras.insertar('Prueba insercion facturaId Null', FALSE, idSocio, NULL, 'Y');
    Pruebas_Compras.insertar('Prueba insercion esPagado vacio', FALSE, idSocio, getFacturaId.NEXTVAL, '');
    Pruebas_Compras.insertar('Prueba insercion esPagado incorrecto', FALSE, idSocio, getFacturaId.NEXTVAL, 'NN');
    Pruebas_Compras.insertar('Prueba insercion esPagado incorrecto', FALSE, idSocio, getFacturaId.NEXTVAL, 'F');
    Pruebas_Compras.insertar('Prueba insercion esPagado Null', FALSE, idSocio, getFacturaId.NEXTVAL, NULL);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Compras.actualizar('Prueba actualizacion id socio', TRUE, idCompra, idSocio -1, idFactura, 'Y');
    Pruebas_Compras.actualizar('Prueba actualizacion idFactura', TRUE, idCompra, idSocio, idFactura-1, 'Y');
    Pruebas_Compras.actualizar('Prueba actualizacion esPagado', TRUE, idCompra, idSocio, idFactura, 'N');
   
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Compras.actualizar('Prueba actualizacion id socio no existe', FALSE, idCompra, idSocio +20, idFactura, 'N');
    Pruebas_Compras.actualizar('Prueba actualizacion id socio no es socio', FALSE, idCompra, idNoSocio, idFactura, 'N');
    Pruebas_Compras.actualizar('Prueba actualizacion facturaId Null', FALSE, idCompra, idSocio, NULL, 'N');
    Pruebas_Compras.actualizar('Prueba actualizacion esPagado incorrecto', FALSE, idCompra, idSocio, idFactura, 'NN');
    Pruebas_Compras.actualizar('Prueba actualizacion esPagado incorrecto', FALSE, idCompra, idSocio, idFactura, 'G');
    Pruebas_Compras.actualizar('Prueba actualizacion esPagado vacio', FALSE, idCompra, idSocio, idFactura, '');
    Pruebas_Compras.actualizar('Prueba actualizacion esPagado Null', FALSE, idCompra, idSocio, idFactura, NULL);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Compras.eliminar('Eliminacion ok', TRUE, idCompra);
    Pruebas_Compras.eliminar('Eliminacion id no existe', FALSE, idCompra);    

END;