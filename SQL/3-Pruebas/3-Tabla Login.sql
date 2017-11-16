CREATE OR REPLACE PACKAGE Pruebas_Login AS
    PROCEDURE inicializar;
    PROCEDURE insertar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, 
                        usuario_ VARCHAR, pass_ VARCHAR);
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idLogin_ INT,
                        usuario_ VARCHAR, pass_ VARCHAR);
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idLogin_ INT);
END Pruebas_Login;
/

CREATE OR REPLACE PACKAGE BODY Pruebas_Login AS

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
                        usuario_ VARCHAR, pass_ VARCHAR) AS
                        
        insercionOK BOOLEAN := TRUE;
        datosInsertados login%ROWTYPE;
        idLoginResultado INTEGER; 
    
    BEGIN
    
        --Obtengo el id a insertar
        idLoginResultado := getPersonaId.NEXTVAL;
    
        --Insertar persona (tabla probada en su propio script de pruebas)
        INSERT INTO Personas VALUES (idLoginResultado, 'Nombre', 'Apellidos', 'Direccion', 41500, '12345678z', 'mail@ja.es', 'Y');
        
        --Inserto el socio (tabla probada en su propio script de pruebas)
        INSERT INTO Socios VALUES (idLoginResultado, 0, 'N');  

    
        --Insertar Login
        INSERT INTO Login VALUES (idLoginResultado, usuario_, pass_);
        
               
        --Guardo en datosInsertados la insercion realizada
        SELECT * INTO datosInsertados 
        FROM Login L
        WHERE L.idLogin = idLoginResultado;
        
        --Compruebo los datos
        IF (datosInsertados.idLogin <> idLoginResultado OR 
            TRIM(datosInsertados.usuario) <> TRIM(usuario_) OR
            TRIM(datosInsertados.pass) <> TRIM(pass_)) THEN
            
            insercionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(insercionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            insercionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Insercion de Login EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(insercionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END insertar;

    --Actualizar
    PROCEDURE actualizar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idLogin_ INT,
                        usuario_ VARCHAR, pass_ VARCHAR) AS
        
        actualizacionOK BOOLEAN := TRUE;
        datosActualizados login%ROWTYPE;
    
    BEGIN
    
        --Actualizar Login
        UPDATE Login L
        SET L.usuario = usuario_,
            L.pass = pass_
        WHERE L.idLogin = idLogin_;
        
        --Guardo en datosActualizados los nuevos datos
        SELECT * INTO datosActualizados 
        FROM Login L 
        WHERE L.idLogin = idLogin_;
        
         --Compruebo los datos
        IF (TRIM(datosActualizados.usuario) <> TRIM(usuario_) OR
            TRIM(datosActualizados.pass) <> TRIM(pass_)) THEN
            
            actualizacionOK := FALSE;
            
        END IF;
        COMMIT WORK;
        
        --Muestro el resultado de la prueba
        DBMS_OUTPUT.put_line(nombrePrueba || ': ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado));
        
        EXCEPTION
        WHEN OTHERS THEN
            actualizacionOK := FALSE;
            DBMS_OUTPUT.put_line(nombrePrueba || ' Update de Login EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(actualizacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
        
    END actualizar;
    
    --Eliminar
    PROCEDURE eliminar(nombrePrueba VARCHAR2, resultadoEsperado BOOLEAN, idLogin_ INT) AS
    
        eliminacionOK BOOLEAN := TRUE;
        numeroSociosPre INT;
        numeroSociosPost INT;
        
    BEGIN
    
        --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroSociosPre
        FROM Login P
        WHERE P.idLogin = idLogin_;
    
        --Borramos ese login
        DELETE FROM Login P
        WHERE P.idLogin = idLogin_;
        
       --Vemos la cantidad de resultados con esa id
        SELECT COUNT(*) INTO numeroSociosPost
        FROM Login P
        WHERE P.idLogin = idLogin_;
        
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
            DBMS_OUTPUT.put_line(nombrePrueba || ' Delete de Login EXCEPTION DISPARADA, resultado ' || ASSERT_EQUALS(eliminacionOK, resultadoEsperado) || SQLCODE);
            ROLLBACK;
    
    END eliminar;

END Pruebas_Login;
/

--Probamos la tabla Login
SET SERVEROUTPUT ON;


DECLARE 
    idLogin INT;
BEGIN

    Pruebas_Login.inicializar;
    
    --Inserciones ok
    Pruebas_Login.insertar('Prueba insercion', TRUE, 'Usuario2017', 'pass');
    
    --Obtengo el id de ese login
    idLogin := getPersonaId.CURRVAL;
    
    
    --Inserciones que no cumplen los requisitos
    Pruebas_Login.insertar('Prueba insercion usuario Null', FALSE, NULL, 'Pass');
    Pruebas_Login.insertar('Prueba insercion pass Null', FALSE, 'Usuario', NULL);
    Pruebas_Login.insertar('Prueba insercion usuario vacio', FALSE, '', 'Pass');
    Pruebas_Login.insertar('Prueba insercion pass vacio', FALSE, 'Usuario', '');
    Pruebas_Login.insertar('Prueba insercion usuario ya existente', FALSE, 'Usuario2017', 'pass');
    dbms_output.put_line('');
    
    
    --Actualizaciones ok
    dbms_output.put_line('--Actualizaciones validas');
    Pruebas_Login.actualizar('Prueba actualizar el usuario', TRUE, idLogin, 'Usuario actualizado', 'Pass');
    Pruebas_Login.actualizar('Prueba actualizar el pass', TRUE, idLogin, 'Usuario', 'Pass actualizado');
    
    
    --Actualizaciones que no cumplen los requisitos
    dbms_output.put_line('--Actualizaciones no validas');
    Pruebas_Login.actualizar('Prueba actualizar el usuario a Null', FALSE, idLogin, NULL, 'Pass');
    Pruebas_Login.actualizar('Prueba actualizar el pass a Null', FALSE, idLogin, 'Usuario', NULL);
    Pruebas_Login.actualizar('Prueba actualizar el usuario vacio', FALSE, idLogin, '', 'Pass');
    Pruebas_Login.actualizar('Prueba actualizar el pass vacio', FALSE, idLogin, 'Usuario', '');
    dbms_output.put_line('');

    
    --Eliminaciones
    Pruebas_Login.eliminar('Eliminacion ok', TRUE, idLogin);
    Pruebas_Login.eliminar('Eliminacion id no existe', FALSE, idLogin);

END;