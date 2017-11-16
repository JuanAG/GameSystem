CREATE OR REPLACE PACKAGE Pruebas_Multimedia AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        front_ CHAR, back_ CHAR, youtube_ CHARACTER);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idMultimedia_ INT,
                        front_ CHAR, back_ CHAR, youtube_ CHARACTER);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idMultimedia_ INT);
END Pruebas_Multimedia;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Multimedia AS

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
                    front_ CHAR, back_ CHAR, youtube_ CHARACTER) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados multimedia%ROWTYPE;
        idMultimediaResultado INTEGER; 
    
    BEGIN
    
        --Obtengo el id a insertar
        idMultimediaResultado := getJuegoId.NEXTVAL;
        
        --Insertar juego
        INSERT INTO Juegos VALUES (idMultimediaResultado, 'Nombre', 'PC', 'Action', 'Descripcion', 12, 'Y', 'Y', 'Y', 'Y');
        
        --Inserto el contenido multimedia
        INSERT INTO Multimedia VALUES (idMultimediaResultado, front_, back_, youtube_);
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Multimedia M 
        WHERE M.idMultimedia = idMultimediaResultado;
        
        --Compruebo los datos
        IF (datosInsertados.front <> front_ OR
            datosInsertados.back <> back_ OR
            TRIM(datosInsertados.youtube) <> TRIM(youtube_)) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Multimedia EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idMultimedia_ INT,
                        front_ CHAR, back_ CHAR, youtube_ CHARACTER) AS
                        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados multimedia%ROWTYPE;
    
    BEGIN
    
        --Actualizar multimedia
        UPDATE Multimedia M
        SET M.front = front_,
            M.back = back_,
            M.youtube = youtube_
        WHERE M.idMultimedia = idMultimedia_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Multimedia M 
        WHERE M.idMultimedia = idMultimedia_;
        
         --Compruebo los datos
        IF (datosActualizados.front <> front_ OR
            datosActualizados.back <> back_ OR
            TRIM(datosActualizados.youtube) <> TRIM(youtube_)) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Multimedia EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idMultimedia_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroMultimediaPre INT;
        numeroMultimediaPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroMultimediaPre
        FROM Multimedia M
        WHERE M.idMultimedia = idMultimedia_;
    
        --Borramos ese registro
        DELETE FROM Multimedia M
        WHERE idMultimedia_ = M.idMultimedia;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroMultimediaPost
        FROM Multimedia M
        WHERE M.idMultimedia = idMultimedia_;
        
        --Comprobamos que sea cero
        IF(numeroMultimediaPre = numeroMultimediaPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE; 
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Multimedia EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Multimedia;
/

--Probamos la tabla Multimedia
SET SERVEROUTPUT ON;
 

DECLARE 
    idMultimedia INT;
BEGIN

    Pruebas_Multimedia.inicializar;
    
    --Inserciones ok
    Pruebas_Multimedia.insertar('Prueba insercion ok', TRUE, 'Y', 'Y', 'Youtube');
    Pruebas_Multimedia.insertar('Prueba insercion ok', TRUE, 'N', 'Y', 'Youtube');
    Pruebas_Multimedia.insertar('Prueba insercion ok', TRUE, 'Y', 'N', 'Youtube');
    Pruebas_Multimedia.insertar('Prueba insercion ok', TRUE, 'Y', 'Y', NULL);
    
    --Obtengo el id de ese multimedia
    idMultimedia := getJuegoId.CURRVAL;
    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Multimedia.insertar('Prueba insercion front Null', FALSE, NULL, 'Y', 'Youtube');
    Pruebas_Multimedia.insertar('Prueba insercion front no valido', FALSE, 'S', 'Y', 'Youtube');
    Pruebas_Multimedia.insertar('Prueba insercion back Null', FALSE, 'Y', NULL, 'Youtube');
    Pruebas_Multimedia.insertar('Prueba insercion back no valido', FALSE, 'Y', 'S', 'Youtube');
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Multimedia.actualizar('Prueba actualizacion front', TRUE, idMultimedia, 'N', 'Y', 'Youtube');
    Pruebas_Multimedia.actualizar('Prueba actualizacion back', TRUE, idMultimedia, 'Y', 'N', 'Youtube');
    Pruebas_Multimedia.actualizar('Prueba actualizacion youtube', TRUE, idMultimedia, 'Y', 'Y', 'YoutubeAct');
    
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Multimedia.actualizar('Prueba actualizacion front a Null', FALSE, idMultimedia, NULL, 'Y', 'Youtube');
    Pruebas_Multimedia.actualizar('Prueba actualizacion front a no valido', FALSE, idMultimedia, 'S', 'Y', 'Youtube');
    Pruebas_Multimedia.actualizar('Prueba actualizacion back a Null', FALSE, idMultimedia, 'Y', NULL, 'Youtube');
    Pruebas_Multimedia.actualizar('Prueba actualizacion front a no valido', FALSE, idMultimedia, 'Y', 'S', 'Youtube');
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Multimedia.eliminar('Eliminacion ok', TRUE, idMultimedia);
    Pruebas_Multimedia.eliminar('Eliminacion id no existe', FALSE, idMultimedia);

END;