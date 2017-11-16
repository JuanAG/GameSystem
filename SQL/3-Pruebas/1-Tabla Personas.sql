CREATE OR REPLACE PACKAGE Pruebas_Personas AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        nombre_ VARCHAR, apellidos_ VARCHAR, direccion_ VARCHAR, CP_ SMALLINT, DNI_ VARCHAR, mail_ VARCHAR, esSocio_ CHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idPersona_ INT,
                        nombre_ VARCHAR, apellidos_ VARCHAR, direccion_ VARCHAR, CP_ SMALLINT, DNI_ VARCHAR, mail_ VARCHAR, esSocio_ CHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idPersona_ INT);
END Pruebas_Personas;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Personas AS

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
                        nombre_ VARCHAR, apellidos_ VARCHAR, direccion_ VARCHAR, CP_ SMALLINT, DNI_ VARCHAR, mail_ VARCHAR, esSocio_ CHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados personas%ROWTYPE;
        idPersonaResultado INTEGER; 
    
    BEGIN
    
        --Insertar persona
        INSERT INTO Personas VALUES (getPersonaId.NEXTVAL, nombre_, apellidos_, direccion_, CP_, DNI_, mail_, esSocio_);
        
        --Me quedo con el id insertado
        idPersonaResultado := getPersonaId.CURRVAL;
        
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Personas P 
        WHERE P.idPersona = idPersonaResultado;
        
        --Compruebo los datos
        IF (TRIM(datosInsertados.nombre) <> TRIM(nombre_) OR
            TRIM(datosInsertados.apellidos) <> TRIM(apellidos_) OR
            TRIM(datosInsertados.direccion) <> TRIM(direccion_) OR
            datosInsertados.cp <> CP_ OR
            TRIM(datosInsertados.dni) <> TRIM(DNI_) OR
            TRIM(datosInsertados.mail) <> TRIM(mail_) OR
            datosInsertados.esSocio <> esSocio_) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK:= FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Persona EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idPersona_ INT,
                        nombre_ VARCHAR, apellidos_ VARCHAR, direccion_ VARCHAR, CP_ SMALLINT, DNI_ VARCHAR, mail_ VARCHAR, esSocio_ CHAR) AS
        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados personas%ROWTYPE;
    
    BEGIN
            
        --Actualizar persona
        UPDATE Personas P
        SET P.nombre = nombre_,
            P.apellidos = apellidos_,
            P.direccion = direccion_,
            P.cp = CP_,
            P.dni = DNI_,
            P.mail = mail_,
            P.esSocio = esSocio_
        WHERE P.idPersona = idPersona_;
                
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Personas P 
        WHERE P.idPersona = idPersona_;
                
         --Compruebo los datos
        IF (TRIM(datosActualizados.nombre) <> TRIM(nombre_) OR
            TRIM(datosActualizados.apellidos) <> TRIM(apellidos_) OR
            TRIM(datosActualizados.direccion) <> TRIM(direccion_) OR
            datosActualizados.cp <> CP_ OR
            TRIM(datosActualizados.dni) <> TRIM(DNI_) OR
            TRIM(datosActualizados.mail) <> TRIM(mail_) OR
            datosActualizados.esSocio <> esSocio_) THEN
            
              actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Persona EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idPersona_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroPersonasPre INT;
        numeroPersonasPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroPersonasPre
        FROM Personas P
        WHERE P.idPersona = idPersona_;
        
        --Borramos esa persona
        DELETE FROM Personas P
        WHERE P.idPersona = idPersona_;
        
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroPersonasPost
        FROM Personas P
        WHERE P.idPersona = idPersona_;
        
        --Comprobamos que sea cero
        IF(numeroPersonasPre = numeroPersonasPost) THEN
            eliminacionOK := FALSE;
        END IF;
        
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            eliminacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Persona EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado));
            ROLLBACK;
    
    END eliminar;

END Pruebas_Personas;
/

--Probamos la tabla Personas
SET SERVEROUTPUT ON;


DECLARE 
    idPersona INT;
BEGIN

    Pruebas_Personas.inicializar;
    
    --Inserciones ok
    Pruebas_Personas.insertar('Prueba insercion Ok', TRUE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion Ok', TRUE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail0@ja.es', 'N');
    
    --Obtengo el id de esa persona
    idPersona := getPersonaId.CURRVAL; 
    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Personas.insertar('Prueba insercion nombre Null', FALSE, NULL, 'Apellidos', 'Direccion', 41500, '12345678z', 'mail1@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion apellidos Null', FALSE, 'Nombre', NULL, 'Direccion', 41500, '12345678z', 'mail2@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion direccion Null', FALSE, 'Nombre', 'Apellidos', NULL, 41500, '12345678z', 'mail3@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion codigo postal Null', FALSE, 'Nombre', 'Apellidos', 'Direccion', NULL, '12345678z', 'mail4@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion codigo postal negativo', FALSE, 'Nombre', 'Apellidos', 'Direccion', -5, '12345678z', 'mail5@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion codigo postal cero', FALSE, 'Nombre', 'Apellidos', 'Direccion', 0, '12345678z', 'mail6@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion codigo postal igual a 100.000', FALSE, 'Nombre', 'Apellidos', 'Direccion', 100000, '12345678z', 'mail7@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion dni Null', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, NULL, 'mail8@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion dni letra incorrecta', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678y', 'mail9@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion dni sin letra', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678', 'mail10@ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion mail Null', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', NULL, 'Y');
    Pruebas_Personas.insertar('Prueba insercion mail repetido', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail_@ja.es', NULL);
    Pruebas_Personas.insertar('Prueba insercion mail sin arroba', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail11ja.es', 'Y');
    Pruebas_Personas.insertar('Prueba insercion mail sin punto', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail12@jaes', 'Y');
    Pruebas_Personas.insertar('Prueba insercion esSocio Null', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail13@ja.es', NULL);
    Pruebas_Personas.insertar('Prueba insercion esSocio incorrecto', FALSE, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail14@ja.es', 'Q');
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Personas.actualizar('Prueba actualizar el nombre', TRUE, idPersona, 'Nombre actualizado', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail15@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar los apellidos', TRUE, idPersona, 'Nombre', 'Apellidos actualizados', 'Direccion', 41500, '12345678z', 'mail16@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar la direccion', TRUE, idPersona, 'Nombre', 'Apellidos', 'Direccion actualizada', 41500, '12345678z', 'mail17@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el codigo postal', TRUE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345678z', 'mail18@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el dni', TRUE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345679s', 'mail19@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el mail', TRUE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345678z', 'mailactualizado@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar esSocio', TRUE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345678z', 'mail20@ja.es', 'N');
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Personas.actualizar('Prueba actualizar el nombre a Null', FALSE, idPersona, NULL, 'Apellidos', 'Direccion', 45100, '12345678z', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el apellido a Null', FALSE, idPersona, 'Nombre', NULL, 'Direccion', 45100, '12345678z', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar la direccion a Null', FALSE, idPersona, 'Nombre', 'Apellidos', NULL, 45100, '12345678z', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el codigo postal a Null', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', NULL, '12345678z', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el codigo postal a negativo', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', -5, '12345678z', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el codigo postal a cero', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 0, '12345678z', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el codigo postal a 100.000', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 100000, '12345678z', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el dni a Null', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, NULL, 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el dni letra incorrecta', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345678y', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el dni sin letra', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345678', 'mail@ja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el mail a Null', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345678z', NULL, 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el mail sin arroba', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345678z', 'mailja.es', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar el mail sin punto', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 45100, '12345678z', 'mail@jaes', 'Y');
    Pruebas_Personas.actualizar('Prueba actualizar esSocio Null', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail13@ja.es', NULL);
    Pruebas_Personas.actualizar('Prueba actualizar esSocio incorrecto', FALSE, idPersona, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail13@ja.es', 'Q');
    dbms_output.put_line('');
    
    
    --Eliminaciones
    Pruebas_Personas.eliminar('Eliminacion ok', TRUE, idPersona);
    Pruebas_Personas.eliminar('Eliminacion id no existe', FALSE, idPersona);

END;