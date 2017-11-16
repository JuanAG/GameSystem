--Triggers tabla Personas, codigo 20.00X

    --Comprobar el DNI
    CREATE OR REPLACE TRIGGER checkDNI
        BEFORE INSERT OR UPDATE
        OF DNI
        ON Personas
        FOR EACH ROW
    DECLARE
        DNI_Incorrecto EXCEPTION;
        PRAGMA EXCEPTION_INIT (DNI_Incorrecto, -20000);
        dni VARCHAR(20);
        dniAux VARCHAR(20);
        modDNI INT;
        finalSubString INT;
    BEGIN       
        dni := :NEW.dni;

        IF NOT REGEXP_LIKE(UPPER(dni), '\d{8}([A-Z]{1}|[a-z]{1})') THEN
            RAISE DNI_Incorrecto;
        END IF;
        
        --Veo hasta donde llegan los numeros
        finalSubString := LENGTH(TRIM(dni)) -1;
        
        --Me quedo con los numeros del dni
        dniAux := SUBSTR(:NEW.DNI, 1, finalSubString);
        
        --Calculo el mod de ese numero
        modDNI := MOD(dniAux, 23);
                
        --Obtengo el dni con su letra
        dniAux := getDniConLetra(modDNI, dniAux);
                       
        IF (dniAux <> UPPER(dni))  THEN
            RAISE DNI_Incorrecto;
        END IF;
    EXCEPTION
        WHEN DNI_Incorrecto THEN
            raise_application_error (-20000, 'DNI incorrecto');
    END;
    /    
    
    --Comprobar el mail
    CREATE OR REPLACE TRIGGER checkMail
        BEFORE INSERT OR UPDATE
        OF mail
        ON Personas
        FOR EACH ROW
    DECLARE
        MailIncorrecto EXCEPTION;
        PRAGMA EXCEPTION_INIT (MailIncorrecto, -20001);
    BEGIN
        IF NOT REGEXP_LIKE(UPPER(:NEW.mail), '[A-Z0-9._-]+@[A-Z0-9._-]+\.[A-Z]') THEN
            RAISE MailIncorrecto;
        END IF;
    EXCEPTION
        WHEN MailIncorrecto THEN
            raise_application_error (-20001, 'Mail incorrecto');
    END;
    /        
  
    
    
--Triggers tabla juegos, codigos 20.10X

    
    --Comprobar la plataforma
     CREATE OR REPLACE TRIGGER checkPlataforma
        BEFORE INSERT OR UPDATE
        OF Plataforma
        ON Juegos
        FOR EACH ROW
    DECLARE
        PlataformaIncorrecta EXCEPTION;
        PRAGMA EXCEPTION_INIT (PlataformaIncorrecta, -20100);
        relleno INT;
    BEGIN
        CASE UPPER(:NEW.plataforma) 
            WHEN '3DS' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'PC' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'PS4' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'XBOX' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            ELSE RAISE PlataformaIncorrecta;
        END CASE;
    EXCEPTION
        WHEN PlataformaIncorrecta THEN
              raise_application_error (-20100, 'Plataforma incorrecta');
    END;
    /
    
        
    --Comprobar el genero
    CREATE OR REPLACE TRIGGER checkGenero
       BEFORE INSERT OR UPDATE
       OF Genero
       ON Juegos
       FOR EACH ROW
    DECLARE
       GeneroIncorrecto EXCEPTION;
       PRAGMA EXCEPTION_INIT (GeneroIncorrecto, -20101);
       relleno INT;
    BEGIN
        CASE UPPER(:NEW.genero)   
            WHEN 'ACTION' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'ADVENTURE' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'FIGHTING' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'MISC' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'PLATFORM' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'PUZZLE' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'RACING' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'ROLE-PLAYING' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'SHOOTER' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'SIMULATION' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'SPORTS' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            WHEN 'STRATEGY' THEN SELECT COUNT(*) INTO relleno FROM Dual;
            ELSE RAISE GeneroIncorrecto;
        END CASE;
    EXCEPTION
       WHEN GeneroIncorrecto THEN
          raise_application_error (-20101, 'Genero incorrecto');
    END;
    /
    
  
    
--Triggers tabla fotos, codigos 20.20X

    
    --Comprobar juego existe
    CREATE OR REPLACE TRIGGER checkJuegoAsociado
        BEFORE INSERT OR UPDATE
        OF idMultimedia
        ON Fotos
        FOR EACH ROW
    DECLARE
        cantidadJuegosId INT;
        IdIncorrecto EXCEPTION;
        PRAGMA EXCEPTION_INIT (IdIncorrecto, -20200);
    BEGIN
        SELECT COUNT(*) INTO cantidadJuegosId
        FROM Juegos J
        WHERE J.idJuego = :NEW.idMultimedia;
        IF (cantidadJuegosId = 0) THEN
              RAISE IdIncorrecto;
        END IF;
    EXCEPTION
        WHEN IdIncorrecto THEN
              raise_application_error (-20200, 'Id incorrecto');
    END;
    /

    --Comprobar nombre
    CREATE OR REPLACE TRIGGER checkNombreFoto
        BEFORE INSERT
        ON Fotos
        FOR EACH ROW
    DECLARE
        aux INT;
        NombreIncorrecto EXCEPTION;
        PRAGMA EXCEPTION_INIT (NombreIncorrecto, -20201);
    BEGIN
    
        aux := getYaExisteEseNombre(:NEW.idMultimedia, :NEW.Nombre);
        
        IF (LENGTH(:NEW.nombre) <= 0) OR (:NEW.nombre = NULL) OR (:NEW.nombre = '') OR  (TRIM(:NEW.nombre) NOT LIKE '_%.jpg') OR (aux >= 1) THEN
              RAISE NombreIncorrecto;
        END IF;
    EXCEPTION
        WHEN NombreIncorrecto THEN
              raise_application_error (-20201, 'Nombre incorrecto');
    END;
    /
    


--Triggers tabla Facturas, codigos 20.30X


    --Comprobar que sea socio
    CREATE OR REPLACE TRIGGER checkProveedorOSocio
        BEFORE INSERT OR UPDATE
        OF idSocio
        ON Facturas
        FOR EACH ROW
    DECLARE
        cantidadDeSociosEnFacturas INT;
        SocioNoExiste EXCEPTION;
        PRAGMA EXCEPTION_INIT (SocioNoExiste, -20300);
    BEGIN
    
        --Hago la consulta para confirmar que es o un socio o un proveedor
        cantidadDeSociosEnFacturas := getSocioExiste(:NEW.idSocio);
 
        IF(cantidadDeSociosEnFacturas = 0) THEN
            RAISE SocioNoExiste;
        END IF;
    EXCEPTION
        WHEN SocioNoExiste THEN
            raise_application_error (-20300, 'Hace falta ser socio');
    END;
    / 

    --Comprobar fechaEntrega
    CREATE OR REPLACE TRIGGER checkFechaEntrega
        BEFORE INSERT OR UPDATE
        OF FechaEntrega
        ON Facturas
        FOR EACH ROW
    DECLARE
        FechaIncorecta EXCEPTION;
        PRAGMA EXCEPTION_INIT (FechaIncorecta, -20301);
    BEGIN
        IF (:NEW.fechaPedido > :NEW.fechaEntrega) THEN
            RAISE FechaIncorecta;
        END IF;
    EXCEPTION
        WHEN FechaIncorecta THEN
            raise_application_error (-20301, 'La fecha de entrega no puede ser anterior a la del pedido');
    END;
    /



--Triggers tabla proveedores, codigos 20.40X

    
  --Comprobar el mail
  CREATE OR REPLACE TRIGGER checkMailProveedor
        BEFORE INSERT OR UPDATE
        OF mail
        ON Proveedores
        FOR EACH ROW
    DECLARE
        MailIncorrecto EXCEPTION;
        PRAGMA EXCEPTION_INIT (MailIncorrecto, -20400);
    BEGIN
        IF NOT REGEXP_LIKE(UPPER(:NEW.mail), '[A-Z0-9._-]+@[A-Z0-9._-]+\.[A-Z]') THEN
            RAISE MailIncorrecto;
        END IF;
    EXCEPTION
        WHEN MailIncorrecto THEN
            raise_application_error (-20400, 'Mail incorrecto');
    END;
    /