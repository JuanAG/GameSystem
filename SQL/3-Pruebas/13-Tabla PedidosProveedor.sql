CREATE OR REPLACE PACKAGE Pruebas_PedidosProveedor AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idCompraFactura_ INT, idProveedor_ INT, esEntregado_ CHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idPedidosProveedor_ INT,
                        idCompraFactura_ INT, idProveedor_ INT, esEntregado_ CHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idPedidosProveedor_ INT);
END Pruebas_PedidosProveedor;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_PedidosProveedor AS

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
        
        INSERT INTO Personas VALUES (0, 'Nosotros', ' ', ' ', 41500, '12345678z', 'gamesystem@gamesystem.shop','Y');
        INSERT INTO Socios VALUES (0, 0, 'N');
        
        --Insertar el proveeedor
        INSERT INTO Proveedores VALUES (getProveedorId.NEXTVAL, 'Proveedor 1', 'mail@proveedor1.com', 'cifNif');
        INSERT INTO Proveedores VALUES (getProveedorId.NEXTVAL, 'Proveedor 2', 'mail@proveedor2.com', 'cifNif');
        
        INSERT INTO Inventario VALUES (1, getJuegoId.CURRVAL, 500, 3.95);
        INSERT INTO Inventario VALUES (2, getJuegoId.CURRVAL -1, 100, 3.95);
        
        --Insertar facturas
        INSERT INTO Facturas VALUES (getFacturaId.NEXTVAL, 0, getJuegoId.CURRVAL, 1, 1.00, sysdate, sysdate);
        INSERT INTO Facturas VALUES (getFacturaId.NEXTVAL, 0, getJuegoId.CURRVAL -1, 1, 1.00, sysdate, sysdate);
                
        
    END inicializar;
    
    --Insertar
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idCompraFactura_ INT, idProveedor_ INT, esEntregado_ CHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados pedidosProveedor%ROWTYPE;
        idPedidoProveedorResultado INTEGER;
    
    BEGIN
    
        idPedidoProveedorResultado := getPedidoProveedorId.NEXTVAL;
        
        --Inserto el pedido al proveedor
        INSERT INTO PedidosProveedor VALUES (idPedidoProveedorResultado, idCompraFactura_, idProveedor_, esEntregado_);
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM PedidosProveedor PP 
        WHERE PP.idPedidoProveedor = idPedidoProveedorResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idCompraFactura <> idCompraFactura_ OR
            datosInsertados.idProveedor <> idProveedor_ OR
            datosInsertados.esEntregado <> esEntregado_) THEN
          
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de PedidosProveedor EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idPedidosProveedor_ INT,
                        idCompraFactura_ INT, idProveedor_ INT, esEntregado_ CHAR) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados pedidosProveedor%ROWTYPE;
    
    BEGIN
    
        --Actualizar pedidosProveedor
        UPDATE PedidosProveedor PP
        SET PP.idCompraFactura = idCompraFactura_,
            PP.idProveedor = idProveedor_,
            PP.esEntregado = esEntregado_
        WHERE PP.idPedidoProveedor = idPedidosProveedor_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM PedidosProveedor PP 
        WHERE PP.idPedidoProveedor = idPedidosProveedor_;
        
         --Compruebo los datos
        IF (datosActualizados.idCompraFactura <> idCompraFactura_ OR
            datosActualizados.idProveedor <> idProveedor_ OR
            datosActualizados.esEntregado <> esEntregado_) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de PedidosProveedor EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idPedidosProveedor_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroPedidosProveedorPre INT;
        numeroPedidosProveedorPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroPedidosProveedorPre
        FROM PedidosProveedor PP
        WHERE PP.idPedidoProveedor = idPedidosProveedor_;
    
        --Borramos ese registro
        DELETE FROM PedidosProveedor PP
        WHERE PP.idPedidoProveedor = idPedidosProveedor_;
        
        --Vemos la cantidad de resultados que han quedado
        SELECT COUNT(*) INTO numeroPedidosProveedorPost
        FROM PedidosProveedor PP
        WHERE PP.idPedidoProveedor = idPedidosProveedor_;
        
  
        --Comprobamos que haya borrado algo
        IF(numeroPedidosProveedorPre = numeroPedidosProveedorPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de PedidosProveedor EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_PedidosProveedor;
/

SET SERVEROUTPUT ON;
 

DECLARE 
    idPedidosProveedor INT;
    idJuego INT;
    idFactura INT;
    idProveedor INT;
BEGIN

    Pruebas_PedidosProveedor.inicializar;
    
    --Obtengo los ids
    idJuego := getJuegoId.CURRVAL;
    idFactura := getFacturaId.CURRVAL;
    idProveedor := getProveedorId.CURRVAL;
    
    --Inserciones ok
    Pruebas_PedidosProveedor.insertar('Prueba insercion ok', TRUE, idFactura, idProveedor, 'Y');
    Pruebas_PedidosProveedor.insertar('Prueba insercion ok', TRUE, idFactura, idProveedor, 'N');
    
    --Obtengo el id del PedidoProveedor
    idPedidosProveedor := getPedidoProveedorId.CURRVAL;
    
    --Inserciones que no cumplen los requisitos
    Pruebas_PedidosProveedor.insertar('Prueba insercion idFactura no existe', FALSE, idFactura+1, idProveedor, 'Y');
    Pruebas_PedidosProveedor.insertar('Prueba insercion idFactura Null', FALSE, NULL, idProveedor, 'Y');
    Pruebas_PedidosProveedor.insertar('Prueba insercion idProveedor no existe', FALSE, idFactura, idProveedor-1, 'Y');
    Pruebas_PedidosProveedor.insertar('Prueba insercion idProveedor Null', FALSE, idFactura, NULL, 'Y');
    Pruebas_PedidosProveedor.insertar('Prueba insercion esEntregado invalido', FALSE, idFactura, idProveedor, 'Q');
    Pruebas_PedidosProveedor.insertar('Prueba insercion esEntrgado vacio', FALSE, idFactura, idProveedor, '');
    Pruebas_PedidosProveedor.insertar('Prueba insercion esEntreegado Null', FALSE, idFactura, idProveedor, NULL);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion idFactura', TRUE, idPedidosProveedor, idFactura-1, idProveedor, 'N');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion idProveedor', TRUE, idPedidosProveedor, idFactura, idProveedor+1, 'N');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion esEntregado', TRUE, idPedidosProveedor, idFactura, idProveedor, 'Y');
     
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion idFactura no existe', FALSE, idPedidosProveedor, idFactura+1, idProveedor, 'Y');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion idFactura Null', FALSE, idPedidosProveedor, NULL, idProveedor, 'Y');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion idProveedor no existe', FALSE, idPedidosProveedor, idFactura, idProveedor-1, 'Y');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion idProveedor Null', FALSE, idPedidosProveedor, idFactura, NULL, 'Y');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion esEntregado invalido', FALSE, idPedidosProveedor, idFactura, idProveedor, 'Q');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion esEntregado vacio', FALSE, idPedidosProveedor, idFactura, idProveedor, '');
    Pruebas_PedidosProveedor.actualizar('Prueba actualizacion esEntregado Null', FALSE, idPedidosProveedor, idFactura, idProveedor, NULL);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_PedidosProveedor.eliminar('Eliminacion ok', TRUE, idPedidosProveedor);
    Pruebas_PedidosProveedor.eliminar('Eliminacion id no existe', FALSE, idPedidosProveedor);

END;