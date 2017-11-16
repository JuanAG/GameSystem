CREATE OR REPLACE PACKAGE Pruebas_Fotos AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        idMultimedia_ INT, nombre_ VARCHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idFoto_ INT,
                        idMultimedia_ INT, nombre_ VARCHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idFoto_ INT);
END Pruebas_Fotos;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Fotos AS

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
        INSERT INTO Juegos VALUES (getJuegoId.NEXTVAL, 'Nombre', 'PC', 'Action', 'Descripcion', 12, 'Y', 'Y', 'Y', 'Y');
        INSERT INTO Juegos VALUES (getJuegoId.NEXTVAL, 'Nombre', 'PC', 'Action', 'Descripcion', 12, 'Y', 'Y', 'Y', 'Y');
        
        --Inserto el contenido multimedia
        INSERT INTO Multimedia VALUES (getJuegoId.CURRVAL, 'Y', 'N', 'youtube');
        INSERT INTO Multimedia VALUES (getJuegoId.CURRVAL-1, 'Y', 'N', 'youtube');
        
        
    END inicializar;
    
    --Insertar
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                    idMultimedia_ INT, nombre_ VARCHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados fotos%ROWTYPE;
        idFotoResultado INTEGER; 
    
    BEGIN
    
        idFotoResultado := getFotoId.NEXTVAL;
        
        --Inserto la foto
        INSERT INTO Fotos VALUES (idFotoResultado, idMultimedia_, nombre_);
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Fotos F 
        WHERE F.idFoto = idFotoResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idMultimedia <> idMultimedia_ OR
            TRIM(datosInsertados.nombre) <> TRIM(nombre_)) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Fotos EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idFoto_ INT,
                        idMultimedia_ INT, nombre_ VARCHAR) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados fotos%ROWTYPE;
    
    BEGIN
    
        --Actualizar fotos
        UPDATE Fotos F
        SET F.idMultimedia = idMultimedia_,
            F.nombre = nombre_
        WHERE F.idFoto = idFoto_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Fotos F 
        WHERE F.idFoto = idFoto_;
        
         --Compruebo los datos
        IF (datosActualizados.idMultimedia <> idMultimedia_ OR
            TRIM(datosActualizados.nombre) <> TRIM(nombre_)) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Fotos EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idFoto_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroFotosPre INT;
        numeroFotosPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroFotosPre
        FROM Fotos F
        WHERE F.idFoto = idFoto_;
        
        --Borramos ese registro
        DELETE FROM Fotos F
        WHERE F.idFoto = idFoto_;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroFotosPost
        FROM Fotos F
        WHERE F.idFoto = idFoto_;
        
        --Comprobamos que sea cero
        IF(numeroFotosPre = numeroFotosPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Fotos EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Fotos;
/

--Probamos la tabla Fotos
SET SERVEROUTPUT ON;

DECLARE 
    idFoto INT;
    idJuego INT;
BEGIN

    Pruebas_Fotos.inicializar;
    
    --Obtengo el id de juego
    idJuego := getJuegoId.CURRVAL;
    
    --Inserciones ok
    Pruebas_Fotos.insertar('Prueba insercion ok', TRUE, idJuego, 'Nom.jpg');
    
    --Obtengo el id de esa foto
    idFoto := getFotoId.CURRVAL;    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Fotos.insertar('Prueba insercion id juego no existente', FALSE, -5, 'Nom.jpg');
    Pruebas_Fotos.insertar('Prueba insercion nombre Null', FALSE, idJuego, NULL);
    Pruebas_Fotos.insertar('Prueba insercion nombre vacio', FALSE, idJuego, '');
    Pruebas_Fotos.insertar('Prueba insercion nombre sin extension', FALSE, idJuego, 'Nombre');
    Pruebas_Fotos.insertar('Prueba insercion nombre con extension no valida', FALSE, idJuego, 'N.jp');
    Pruebas_Fotos.insertar('Prueba insercion nombre con solo extension', FALSE, idJuego, '.jpg');
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Fotos.actualizar('Prueba actualizacion id juego', TRUE, idFoto, idJuego-1, 'Nom.jpg');
    Pruebas_Fotos.actualizar('Prueba actualizacion nombre', TRUE, idFoto, idJuego, 'NAc.jpg');
      
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Fotos.actualizar('Prueba actualizacion id juego no existente', FALSE, idFoto, idJuego+1, 'Nom.jpg');
    Pruebas_Fotos.actualizar('Prueba actualizacion nombre a Null', FALSE, idFoto, idJuego, NULL);
    Pruebas_Fotos.actualizar('Prueba actualizacion nombre vacio', FALSE, idFoto, idJuego, '');
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Fotos.eliminar('Eliminacion ok', TRUE, idFoto);
    Pruebas_Fotos.eliminar('Eliminacion id no existe', FALSE, idFoto);    

END;