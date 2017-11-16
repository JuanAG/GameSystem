CREATE OR REPLACE PACKAGE Pruebas_Inventario AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idJuego_ INT, unidadesEnStock_ INT, precio_ NUMBER);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idInventario_ INT,
                        idJuego_ INT, unidadesEnStock_ INT, precio_ NUMBER);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idInventario_ INT);
END Pruebas_Inventario;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Inventario AS

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
        
        
    END inicializar;
    
    --Insertar
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                    idJuego_ INT, unidadesEnStock_ INT, precio_ NUMBER) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados inventario%ROWTYPE;
        idInventarioResultado INTEGER;
    
    BEGIN
    
        idInventarioResultado := getInventarioId.NEXTVAL;
        
        --Inserto el inventario
        INSERT INTO Inventario VALUES (idInventarioResultado, idJuego_, unidadesEnStock_, precio_);
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Inventario I 
        WHERE I.idInventario = idInventarioResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idJuego <> idJuego_ OR
            datosInsertados.unidadesEnStock <> unidadesEnStock_ OR
            datosInsertados.precio <> precio_) THEN
          
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Inventario EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idInventario_ INT,
                        idJuego_ INT, unidadesEnStock_ INT, precio_ NUMBER) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados inventario%ROWTYPE;
    
    BEGIN
    
        --Actualizar inventario
        UPDATE Inventario I
        SET I.idJuego = idJuego_,
            I.unidadesEnStock = unidadesEnStock_,
            I.precio = precio_
        WHERE I.idInventario = idInventario_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Inventario I 
        WHERE I.idInventario = idInventario_;
        
         --Compruebo los datos
        IF (datosActualizados.idJuego <> idJuego_ OR
            datosActualizados.unidadesEnStock <> unidadesEnStock_ OR
            datosActualizados.precio <> precio_) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Inventario EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idInventario_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroInventarioPre INT;
        numeroInventarioPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroInventarioPre
        FROM Inventario I
        WHERE I.idInventario = idInventario_;
    
        --Borramos ese registro
        DELETE FROM Inventario I
        WHERE I.idInventario = idInventario_;
        
        --Vemos la cantidad de resultados que han quedado
        SELECT COUNT(*) INTO numeroInventarioPost
        FROM Inventario I
        WHERE I.idInventario = idInventario_;
        
  
        --Comprobamos que haya borrado algo
        IF(numeroInventarioPre = numeroInventarioPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Inventario EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Inventario;
/

SET SERVEROUTPUT ON;
 

DECLARE 
    idInventario INT;
    idJuego INT;
BEGIN

    Pruebas_Inventario.inicializar;
    
    --Obtengo el id del inventario
    idJuego := getJuegoId.CURRVAL;
    
    --Inserciones ok
    Pruebas_Inventario.insertar('Prueba insercion ok', TRUE, idJuego, 50, 9.99);
    
    --Obtengo el id del inventario
    idInventario := getInventarioId.CURRVAL;
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Inventario.insertar('Prueba insercion idJuego no existe', FALSE, idJuego +1, 50, 9.99);
    Pruebas_Inventario.insertar('Prueba insercion idJuego Null', FALSE, NULL, 50, 9.99);
    Pruebas_Inventario.insertar('Prueba insercion unidades en stock negativas', FALSE, idJuego, -1, 9.99);
    Pruebas_Inventario.insertar('Prueba insercion unidades en stock Null', FALSE, idJuego, NULL, 9.99);
    Pruebas_Inventario.insertar('Prueba insercion precio negativo', FALSE, idJuego, 50, -0.01);
    Pruebas_Inventario.insertar('Prueba insercion precio Null', FALSE, idJuego, 50, NULL);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Inventario.actualizar('Prueba actualizacion idJuego', TRUE, idInventario, idJuego-1, 50, 9.99);
    Pruebas_Inventario.actualizar('Prueba actualizacion unidades en stock', TRUE, idInventario, idJuego, 500, 9.99);
    Pruebas_Inventario.actualizar('Prueba actualizacion precio', TRUE, idInventario, idJuego, 50, 15.86);
     
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Inventario.actualizar('Prueba actualizacion idJuego no existe', FALSE, idInventario, idJuego +1, 50, 9.99);
    Pruebas_Inventario.actualizar('Prueba actualizacion idJuego Null', FALSE, idInventario, NULL, 50, 9.99);
    Pruebas_Inventario.actualizar('Prueba actualizacion unidades en stock negativas', FALSE, idInventario, idJuego, -1, 9.99);
    Pruebas_Inventario.actualizar('Prueba actualizacion unidades en stock Null', FALSE, idInventario, idJuego, NULL, 9.99);
    Pruebas_Inventario.actualizar('Prueba actualizacion precio negativo', FALSE, idInventario, idJuego, 50, -9.99);
    Pruebas_Inventario.actualizar('Prueba actualizacion precio Null', FALSE, idInventario, idJuego, 50, NULL);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Inventario.eliminar('Eliminacion ok', TRUE, idInventario);
    Pruebas_Inventario.eliminar('Eliminacion id no existe', FALSE, idInventario);

END;