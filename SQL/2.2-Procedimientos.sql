CREATE OR REPLACE PACKAGE baseDeDatos AS
    PROCEDURE insertarSocio(Nombre_ VARCHAR2, Apellidos_ VARCHAR2, Direccion_ VARCHAR2, CP_ INT, DNI_ VARCHAR2, Mail_ VARCHAR2, 
                            Puntos_ INT, Usuario_ VARCHAR2, Pass_ VARCHAR2);
    PROCEDURE insertarJuego(Nombre_ VARCHAR2, Plataforma_ VARCHAR2, Genero_ VARCHAR2, Descripcion_ NCLOB, Pegi_ INT, Coleccionista_ CHAR, 
                            Seminuevo_ CHAR, Retro_ CHAR, Digital_ CHAR, Front_ CHAR, Back_ CHAR, Youtube_ VARCHAR2, Fotos_ VARCHAR2);
    PROCEDURE insertarCompra(idSocio_ INT, idJuego_ INT, Cantidad_ INT, Precio_ FLOAT, FechaPedido_ DATE, FechaEntrega_ DATE);
    PROCEDURE insertarVenta(idSocio_ INT, idJuego_ INT, Cantidad_ INT, Precio_ FLOAT, FechaPedido_ DATE, FechaEntrega_ DATE, Des_ VARCHAR2);
    PROCEDURE insertarAlquiler(idSocio_ INT, idJuego_ INT, Cantidad_ INT, FechaPedido_ DATE, Tiempo_ INT);
    PROCEDURE cerrarAlquiler(idAlquiler_ INT, FechaEntrega_ DATE);
END baseDeDatos;
/

CREATE OR REPLACE PACKAGE BODY baseDeDatos AS


    PROCEDURE insertarSocio(Nombre_ VARCHAR2, Apellidos_ VARCHAR2, Direccion_ VARCHAR2, CP_ INT, DNI_ VARCHAR2, Mail_ VARCHAR2, 
                            Puntos_ INT, Usuario_ VARCHAR2, Pass_ VARCHAR2) AS
        idAux INT := getPersonaId.NEXTVAL;
    BEGIN
        --Inserto primero la persona
        INSERT INTO Personas VALUES (idAux, Nombre_, Apellidos_, Direccion_, CP_, DNI_, Mail_, 'Y');
        
        --Ahora el socio
        INSERT INTO Socios VALUES (idAux, Puntos_, 'N');
        
        --Y por ultimo el login
        INSERT INTO Login VALUES (idAux, Usuario_, Pass_);
        
        --Doy por valida la inserccion
        COMMIT WORK;
        
    END insertarSocio;
    
    
    
    PROCEDURE insertarJuego(Nombre_ VARCHAR2, Plataforma_ VARCHAR2, Genero_ VARCHAR2, Descripcion_ NCLOB, Pegi_ INT, Coleccionista_ CHAR, 
                            Seminuevo_ CHAR, Retro_ CHAR, Digital_ CHAR, Front_ CHAR, Back_ CHAR, Youtube_ VARCHAR2, Fotos_ VARCHAR2) AS
        idAux INT := getJuegoId.NEXTVAL;
        nombreFotoAux VARCHAR2(7) := '';
        cantidadCaracteresFotos INT := length(Fotos_);
        caracterActual VARCHAR2(1) := '';
    BEGIN
        
        --Inserto el juego
        INSERT INTO Juegos VALUES (idAux, Nombre_, Plataforma_, Genero_, Descripcion_, Pegi_, Coleccionista_, Seminuevo_, Retro_, Digital_);
        
        --Inserto el contenido multimedia
        INSERT INTO Multimedia VALUES (idAux, Front_, Back_, Youtube_);
                
        --Tengo que separar la cadena de las fotos para ver cuantas me vienen
        FOR indice IN 1..cantidadCaracteresFotos
        LOOP
                
              caracterActual := substr(Fotos_,indice,1);
                            
              --Miro si el caracter me interesa
              IF (caracterActual = '#' OR caracterActual = ' ') THEN
              
                  nombreFotoAux := TRIM(nombreFotoAux);
              
                  --Vamos a cambiar a otra foto, compruebo que se deba hacer la insercion
                  IF(nombreFotoAux = '') THEN
                  
                      --No me interesa hacer nada
                      nombreFotoAux := nombreFotoAux;
                      
                  ELSE
                      
                      --Es una foto, se puede hacer la insercion
                      INSERT INTO Fotos VALUES (getFotoId.NEXTVAL, idAux, nombreFotoAux);
                      
                  END IF;
              
                  --Vacio la cadena de la foto 
                  nombreFotoAux := '';
                  
              ELSE
                  
                  --Ese caracter forma parte de la foto
                  nombreFotoAux := nombreFotoAux || caracterActual;
              
              END IF;
        
        END LOOP;
    
        --Doy por valida la inserccion
        COMMIT WORK;
    
    END insertarJuego;
    
    
    
    PROCEDURE insertarCompra(idSocio_ INT, idJuego_ INT, Cantidad_ INT, Precio_ FLOAT, FechaPedido_ DATE, FechaEntrega_ DATE) AS
        idFacturaAux INT := getFacturaId.NEXTVAL;
        idCompraAux INT := getCompraId.NEXTVAL;
        stockDisponible INT := getStockDisponibleVenta(idJuego_);
        Cantidad_Insuficiente EXCEPTION;
        PRAGMA EXCEPTION_INIT (Cantidad_Insuficiente, -20061);
    BEGIN
    
        --Compruebo que haya stock para esa compra
        IF (Cantidad_ > stockDisponible) THEN
        
            RAISE Cantidad_Insuficiente;
            
        ELSE
        
            --Inserto la factura
            INSERT INTO Facturas VALUES (idFacturaAux, idSocio_, idJuego_, Cantidad_, Precio_, FechaPedido_, FechaEntrega_);
            
            --Inserto la compra
            INSERT INTO Compras VALUES (idCompraAux, idFacturaAux, 'N');
            
            --Doy por valida la inserccion
            COMMIT WORK;
        
        END IF;
        
        EXCEPTION
        WHEN Cantidad_Insuficiente THEN
        
            raise_application_error (-20061, 'Cantidad no disponible');
    
    END insertarCompra;
    
    
    
    PROCEDURE insertarVenta(idSocio_ INT, idJuego_ INT, Cantidad_ INT, Precio_ FLOAT, FechaPedido_ DATE, FechaEntrega_ DATE, Des_ VARCHAR2) AS
        idFacturaAux INT := getFacturaId.NEXTVAL;
        idVentaAux INT := getVentaId.NEXTVAL;
        puntosAux INT;
    BEGIN
    
        --Inserto la factura
        INSERT INTO Facturas VALUES (idFacturaAux, idSocio_, idJuego_, Cantidad_, Precio_, FechaPedido_, FechaEntrega_);
        
        --Inserto la venta
        INSERT INTO Ventas VALUES (idVentaAux, idFacturaAux, Des_);
        
        --Veo cuantos puntos tiene
        SELECT S.puntos INTO puntosAux
        FROM Socios S
        WHERE S.idSocio = idSocio_;
        
        --Calculo cuantos puntos son
        puntosAux := puntosAux + (Precio_*getEquivalenciaPuntosEuros)/10;
        
        --Actualizo los puntos del usuario
        UPDATE Socios S
        SET S.puntos = puntosAux
        WHERE S.idSocio = idSocio_;
      
        --Doy por valida la inserccion
        COMMIT WORK;
    
    END insertarVenta;
    
    
    PROCEDURE insertarAlquiler(idSocio_ INT, idJuego_ INT, Cantidad_ INT, FechaPedido_ DATE, Tiempo_ INT) AS
        idFacturaAux INT := getFacturaId.NEXTVAL;
        idAlquilerAux INT := getAlquilerId.NEXTVAL;
    BEGIN
    
        --Inserto la factura
        INSERT INTO Facturas VALUES (idFacturaAux, idSocio_, idJuego_, Cantidad_, 0.00, FechaPedido_, getFechaNoDevuelto);
        
        --Inserto el alquiler
        INSERT INTO Alquileres VALUES (idAlquilerAux, idFacturaAux, Tiempo_);
        
        --Doy por valida la inserccion
        COMMIT WORK;   
    
    END insertarAlquiler;
    
    
    
    PROCEDURE cerrarAlquiler(idAlquiler_ INT, FechaEntrega_ DATE) AS
        idFacturaAux INT;
        tiempoAlquilerAux INT; 
        precioAux FLOAT;
    BEGIN
    
        --Obtengo el idFactura
        SELECT A.idFacturaCompra INTO idFacturaAux
        FROM Alquileres A
        WHERE A.idAlquiler = idAlquiler_;
        
        --Actualizo la factura
        UPDATE Facturas F
        SET F.fechaEntrega = FechaEntrega_
        WHERE F.idFactura = idFacturaAux;
    
        --Calculo el tiempo de alquiler
        tiempoAlquilerAux := getTiempoAlquiler(idFacturaAux);
                
        --Calculo el precio
        precioAux := tiempoAlquilerAux * getCosteAlquilerDiario;
            
        --Actualizo el alquiler
        UPDATE Alquileres A
        SET A.tiempoAlquiler = tiempoAlquilerAux
        WHERE A.idAlquiler = idAlquiler_;
        
        --Actualizo el precio que ha supuesto ese alquiler
        UPDATE Facturas F
        SET F.precio = precioAux
        WHERE F.idFactura = idFacturaAux;
        
        --Doy por valida la inserccion
        COMMIT WORK;
    
    END cerrarAlquiler;
    

END baseDeDatos;
/

SET SERVEROUTPUT ON;

DECLARE 

BEGIN

    --Insertamos un socio
    baseDeDatos.insertarSocio('Nombre Procedimiento', 'Apellidos', 'Direccion_', 41500, '12345678z', 'proc@game.es', 0, 'usser', 'pass');
    
    --Insertamos un juego
    baseDeDatos.insertarJuego('Juego 6', 'PC', 'Action', 'Marketing...', 13, 'N', 'N', 'Y', 'Y', 'Y', 'N', 'Youtube_', '1.jpg#2.jpg#3.jpg#');
    
    --Insertamos una compra
    baseDeDatos.insertarCompra(1, 1, 1, 2.99, sysdate, sysdate +10);
    
    --Insertamos una venta
    baseDeDatos.insertarVenta(1, 1, 1, 1.99, sysdate, sysdate, 'Gran juego mejor socio');
    
    --Insertamos un alquiler
    baseDeDatos.insertarAlquiler(1, 1, 1, sysdate-10, 2);
    
    --Cerramos ese alquiler
    baseDeDatos.cerrarAlquiler(getAlquilerId.CURRVAL, sysdate - 3);

END;

--SELECT * FROM Personas P INNER JOIN Socios S ON S.idSocio = P.idPersona INNER JOIN Login L ON L.idLogin = P.idPersona
--SELECT * FROM Juegos J INNER JOIN Multimedia M ON M.idMultimedia = J.idJuego INNER JOIN Fotos F ON F.idMultimedia = M.idMultimedia
--SELECT * FROM Alquileres A INNER JOIN Facturas F ON F.idFactura = A.idFacturaCompra