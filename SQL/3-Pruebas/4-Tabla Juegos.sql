CREATE OR REPLACE PACKAGE Pruebas_Juegos AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        nombre_ VARCHAR, plataforma_ VARCHAR, genero_ VARCHAR, descripcion_ VARCHAR, pegi_ SMALLINT, esColeccionista_ CHAR, esSeminuevo_ CHAR, esRetro_ CHAR, esDigital_ CHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idJuego_ INT,
                        nombre_ VARCHAR, plataforma_ VARCHAR, genero_ VARCHAR, descripcion_ VARCHAR, pegi_ SMALLINT, esColeccionista_ CHAR, esSeminuevo_ CHAR, esRetro_ CHAR, esDigital_ CHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idJuego_ INT);
END Pruebas_Juegos;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Juegos AS

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
                        nombre_ VARCHAR, plataforma_ VARCHAR, genero_ VARCHAR, descripcion_ VARCHAR, pegi_ SMALLINT, esColeccionista_ CHAR, esSeminuevo_ CHAR, esRetro_ CHAR, esDigital_ CHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados juegos%ROWTYPE;
        idJuegoResultado INTEGER; 
    
    BEGIN
    
        --Insertar juego
        INSERT INTO Juegos VALUES (getJuegoId.NEXTVAL, nombre_, plataforma_, genero_, descripcion_, pegi_, esColeccionista_, esSeminuevo_, esRetro_, esDigital_);
        
        --Me quedo con el id insertado
        idJuegoResultado := getJuegoId.CURRVAL;
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Juegos J 
        WHERE J.idJuego = idJuegoResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idJuego <> idJuegoResultado OR 
            TRIM(datosInsertados.nombre) <> TRIM(nombre_) OR
            TRIM(datosInsertados.plataforma) <> TRIM(plataforma_) OR
            TRIM(datosInsertados.genero) <> TRIM(genero_) OR
            TRIM(datosInsertados.descripcion) <> TRIM(descripcion_) OR
            datosInsertados.pegi <> pegi_ OR
            datosInsertados.esEdicionColeccionista <> esColeccionista_ OR
            datosInsertados.esSeminuevo <> esSeminuevo_ OR
            datosInsertados.esRetro <> esRetro_ OR
            datosInsertados.esDigital <> esDigital_) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Juego EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idJuego_ INT,
                        nombre_ VARCHAR, plataforma_ VARCHAR, genero_ VARCHAR, descripcion_ VARCHAR, pegi_ SMALLINT, esColeccionista_ CHAR, esSeminuevo_ CHAR, esRetro_ CHAR, esDigital_ CHAR) AS
        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados juegos%ROWTYPE;
    
    BEGIN
    
        --Actualizar juegos
        UPDATE Juegos J
        SET J.nombre = nombre_,
            J.plataforma = plataforma_,
            J.genero = genero_,
            J.descripcion = descripcion_,
            J.pegi = pegi_,
            J.esEdicionColeccionista = esColeccionista_,
            J.esSeminuevo = esSeminuevo_,
            J.esRetro = esRetro_,
            J.esDigital = esDigital_
        WHERE J.idJuego = idJuego_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Juegos J 
        WHERE J.idJuego = idJuego_;
        
         --Compruebo los datos
        IF (TRIM(datosActualizados.nombre) <> TRIM(nombre_) OR
            TRIM(datosActualizados.plataforma) <> TRIM(plataforma_) OR
            TRIM(datosActualizados.genero) <> TRIM(genero_) OR
            TRIM(datosActualizados.descripcion) <> TRIM(descripcion_) OR
            datosActualizados.pegi <> pegi_ OR
            datosActualizados.esEdicionColeccionista <> esColeccionista_ OR
            datosActualizados.esSeminuevo <> esSeminuevo_ OR
            datosActualizados.esRetro <> esRetro_ OR
            datosActualizados.esDigital <> esDigital_) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Juego EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idJuego_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroJuegosPre INT;
        numeroJuegosPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroJuegosPre
        FROM Juegos J
        WHERE J.idJuego = idJuego_;
        
        --Borramos esa juego
        DELETE FROM Juegos J
        WHERE J.idJuego = idJuego_;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroJuegosPost
        FROM Juegos J
        WHERE J.idJuego = idJuego_;
        
        --Comprobamos que sea cero
        IF(numeroJuegosPre = numeroJuegosPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Juego EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Juegos;
/

--Probamos la tabla Juegos
SET SERVEROUTPUT ON;

 

DECLARE 
    idJuego INT;
BEGIN

    Pruebas_Juegos.inicializar;
    
    --Inserciones ok
    Pruebas_Juegos.insertar('Prueba insercion ok', TRUE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion ok', TRUE, 'Nombre', 'PC', 'Action', 'Description', 18,  'N', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion ok', TRUE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'N', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion ok', TRUE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'N', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion ok', TRUE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'Y', 'N');
    
    --Obtengo el id de ese juego
    idJuego := getJuegoId.CURRVAL;
    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Juegos.insertar('Prueba insercion nombre Null', FALSE, NULL, 'PC', 'Action', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion nombre vacio', FALSE, '', 'PC', 'Action', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion plataforma Null', FALSE, 'Nombre', NULL, 'Action', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion plataforma no existe', FALSE, 'Nombre', 'Plataforma', 'Action', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion genero Null', FALSE, 'Nombre', 'PC', NULL, 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion genero no existe', FALSE, 'Nombre', 'PC', 'Genero', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion descripcion Null', FALSE, 'Nombre', 'PC', 'Action', NULL, 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion descripcion vacia', FALSE, 'Nombre', 'PC', 'Action', '', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion pegi cero', FALSE, 'Nombre', 'PC', 'Action', 'Descripcion', 0, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion pegi negativo', FALSE, 'Nombre', 'PC', 'Action', 'Descripcion', -1, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion pegi superior al maximo', FALSE, 'Nombre', 'PC', 'Action', 'Descripcion', 19,  'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion esEdicionColeccionista Null', FALSE, 'Nombre', 'PC', 'Action', 'Description', 18,  NULL, 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion esEdicionColeccionista invalido', FALSE, 'Nombre', 'PC', 'Action', 'Description', 18, 'Q', 'Y', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion esSeminuevo Null', FALSE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', NULL, 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion esSeminuevo invalido', FALSE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Z', 'Y', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion esRetro Null', FALSE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', NULL, 'Y');
    Pruebas_Juegos.insertar('Prueba insercion esRetro invalido', FALSE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'P', 'Y');
    Pruebas_Juegos.insertar('Prueba insercion esDigital Null', FALSE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'Y', NULL);
    Pruebas_Juegos.insertar('Prueba insercion esDigital invalido', FALSE, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'Y', 'T');
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Juegos.actualizar('Prueba actualizacion nombre', TRUE, idJuego, 'Nombre actualizado', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion plataforma', TRUE, idJuego, 'Nombre', 'PS4', 'Action', 'Description', 18,  'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion genero', TRUE, idJuego, 'Nombre', 'PC', 'Misc', 'Description', 18,  'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion descripcion', TRUE, idJuego, 'Nombre', 'PC', 'Action', 'Description actualizada', 18,  'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion pegi', TRUE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 15,  'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esEdicionColeccionista', TRUE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'N', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esSeminuevo', TRUE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'N', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esRetro', TRUE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'N', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esDigital', TRUE, idJuego ,'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'Y', 'N');
    
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Juegos.actualizar('Prueba actualizacion nombre Null', FALSE, idJuego, NULL, 'PC', 'Action', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion nombre vacio', FALSE, idJuego, '', 'PC', 'Action', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion plataforma Null', FALSE, idJuego, 'Nombre', NULL, 'Action', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion plataforma no existe', FALSE, idJuego, 'Nombre', 'Plataforma', 'Action', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion genero Null', FALSE, idJuego, 'Nombre', 'PC', NULL, 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion genero no existe', FALSE, idJuego, 'Nombre', 'PC', 'Genero', 'Description', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion descripcion Null', FALSE, idJuego, 'Nombre', 'PC', 'Action', NULL, 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion descripcion vacia', FALSE, idJuego, 'Nombre', 'PC', 'Action', '', 18, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion pegi cero', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Descripcion', 0, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion pegi negativo', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Descripcion', -1, 'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion pegi superior al maximo', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Descripcion', 19,  'Y', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esEdicionColeccionista Null', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  NULL, 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esEdicionColeccionista invalido', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18, 'Q', 'Y', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esSeminuevo Null', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', NULL, 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esSeminuevo invalido', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Z', 'Y', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esRetro Null', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', NULL, 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esRetro invalido', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'P', 'Y');
    Pruebas_Juegos.actualizar('Prueba actualizacion esDigital Null', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'Y', NULL);
    Pruebas_Juegos.actualizar('Prueba actualizacion esDigital invalido', FALSE, idJuego, 'Nombre', 'PC', 'Action', 'Description', 18,  'Y', 'Y', 'Y', 'T');
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Juegos.eliminar('Eliminacion ok', TRUE, idJuego);
    Pruebas_Juegos.eliminar('Eliminacion id no existe', FALSE, idJuego);

END;