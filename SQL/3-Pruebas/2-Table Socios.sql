CREATE OR REPLACE PACKAGE Pruebas_Socios AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        puntos_ INT, tarjetaEnviada_ CHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idSocio_ INT,
                        puntos_ INT, tarjetaEnviada_ CHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idSocio_ INT);
END Pruebas_Socios;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Socios AS

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
                        puntos_ INT, tarjetaEnviada_ CHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados socios%ROWTYPE;
        idSocioResultado INTEGER; 
        mailInsertar VARCHAR(50);
    
    BEGIN
    
        --Obtengo el id a insertar
        idSocioResultado := getPersonaId.NEXTVAL;
        
        mailInsertar := 'mail' || idSocioResultado || '@ja.es';
    
        --Insertar persona (tabla probada en su propio script de pruebas)
        INSERT INTO Personas VALUES (idSocioResultado, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', mailInsertar, 'Y');
        
        --Inserto el socio
        INSERT INTO Socios VALUES (idSocioResultado, puntos_, tarjetaEnviada_);  

        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Socios S 
        WHERE S.idSocio = idSocioResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idSocio <> idSocioResultado OR 
            datosInsertados.puntos <> puntos_ OR
            datosInsertados.tarjetaEnviada <> tarjetaEnviada_) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Socio EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idSocio_ INT,
                        puntos_ INT, tarjetaEnviada_ CHAR) AS
        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados socios%ROWTYPE;
    
    BEGIN
    
        --Actualizar socio
        UPDATE Socios S
        SET S.puntos = puntos_,
            S.tarjetaEnviada = tarjetaEnviada_
        WHERE S.idSocio = idSocio_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Socios S 
        WHERE S.idSocio = idSocio_;
        
         --Compruebo los datos
        IF (datosActualizados.puntos <> puntos_ OR
            datosActualizados.tarjetaEnviada <> tarjetaEnviada_) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Socio EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idSocio_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroSociosPre INT;
        numeroSociosPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroSociosPre
        FROM Socios S
        WHERE S.idSocio = idSocio_;
    
        --Borramos ese Socio
        DELETE FROM Socios S
        WHERE S.idSocio = idSocio_;
        
       --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroSociosPost
        FROM Socios S
        WHERE S.idSocio = idSocio_;
        
        --Comprobamos que sea cero
        IF(numeroSociosPre = numeroSociosPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Socio EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Socios;
/

--Probamos la tabla Socios
SET SERVEROUTPUT ON;


DECLARE 
    idSocio INT;
BEGIN

    Pruebas_Socios.inicializar;
    
    --Inserciones ok
    Pruebas_Socios.insertar('Prueba insercion', TRUE, 100, 'Y');
    
    --Obtengo el id de ese socio
    idSocio := getPersonaId.CURRVAL;
    
    Pruebas_Socios.insertar('Prueba insercion ok', TRUE, 100, 'N');
    Pruebas_Socios.insertar('Prueba insercion ok', TRUE, 0, 'N');
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Socios.insertar('Prueba insercion puntos negativos', FALSE, -1, 'N');
    Pruebas_Socios.insertar('Prueba insercion puntos Null', FALSE, NULL, 'N');
    Pruebas_Socios.insertar('Prueba insercion tarjeta enviada caracter no valido', FALSE, 10, 'Z');
    Pruebas_Socios.insertar('Prueba insercion tarjeta enviada Null', FALSE, 10, NULL);
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Socios.actualizar('Prueba actualizar los puntos', TRUE, idSocio, 1500, 'Y');
    Pruebas_Socios.actualizar('Prueba actualizar la tarjeta enviada', TRUE, idSocio, 1500, 'N');
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Socios.actualizar('Prueba actualizar los puntos negativos', FALSE, idSocio, -1, 'N');
    Pruebas_Socios.actualizar('Prueba actualizar los puntos Null', FALSE, idSocio, NULL, 'N');
    Pruebas_Socios.actualizar('Prueba actualizar tarjeta enviada caracter no valido', FALSE, idSocio, 1500, 'D');
    Pruebas_Socios.actualizar('Prueba actualizar tarjeta enviada Null', FALSE, idSocio, 1500, NULL);
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Socios.eliminar('Eliminacion ok', TRUE, idSocio);
    Pruebas_Socios.eliminar('Eliminacion id no existe', FALSE, idSocio);

END;