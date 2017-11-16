SET SERVEROUTPUT ON;

SELECT F.*
FROM Facturas F
WHERE F.idSocio = 0;

--Cursor para modificar los precios, tal cual esta los encarece un 50%
DECLARE
    idTemp INT;
    precioTemp FLOAT;
    multiplicador FLOAT;
    CURSOR cambiarPrecios (multiplicador IN FLOAT)
    IS
      SELECT F.idFactura, F.Precio, multiplicador
      FROM Facturas F
      WHERE F.idSocio = 0
      FOR UPDATE OF F.Precio;
BEGIN

    OPEN cambiarPrecios(1.5);
    
    LOOP
        FETCH cambiarPrecios INTO idTemp, precioTemp, multiplicador;
        
            EXIT WHEN cambiarPrecios%notfound;
        
            precioTemp := multiplicador * precioTemp;
        
            UPDATE Facturas F
            SET F.precio = precioTemp
            WHERE F.idFactura = idTemp;            
            
    END LOOP;
    
    dbms_output.put_line('Precios actualizados');
    
    CLOSE cambiarPrecios;
    
END;
/


SELECT S.*
FROM Socios S;

--Cursor para incrementar los puntos de los socios en X cantidad siempre que tenga Y puntos como minimo
DECLARE
    idTemp INT;
    puntosTemp INT;
    puntosExtra INT;
    puntosMinimos INT;
    CURSOR incrementarPuntos (puntosExtra IN INT, puntosMinimos IN INT)
    IS
      SELECT S.idSocio, S.puntos, puntosExtra, puntosMinimos
      FROM Socios S
      WHERE S.idSocio <> 0
      FOR UPDATE OF S.Puntos;
BEGIN

    OPEN incrementarPuntos(500, 2000);
    
    LOOP
        FETCH incrementarPuntos INTO idTemp, puntosTemp, puntosExtra, puntosMinimos;
        
            EXIT WHEN incrementarPuntos%notfound;
        
            puntosTemp := puntosExtra + puntosTemp;
        
            UPDATE Socios S
            SET S.puntos = puntosTemp
            WHERE S.idSocio = idTemp AND S.puntos >= puntosMinimos;            
            
    END LOOP;
    
    dbms_output.put_line('Puntos actualizados');
    
    CLOSE incrementarPuntos;
    
END;
/


SELECT *
FROM Socios S
WHERE S.tarjetaEnviada = 'N';

--Cursor para que muestre las direcciones de los socios que aun no han recibido su tarjeta de socio
DECLARE
    idSocio_ INT;
    contador INT := 0;
    nombre VARCHAR(50);
    apellidos VARCHAR(50);
    direccion VARCHAR(250);
    CP INT;
    CURSOR mostrarDatosParaEnviarTarjetas
    IS
      SELECT S.idSocio, P.nombre, P.apellidos, P.direccion, P.CP
      FROM Personas P INNER JOIN Socios S ON P.idPersona = S.idSocio
      WHERE S.idSocio <> 0 AND S.tarjetaEnviada = 'N'
      FOR UPDATE OF S.tarjetaEnviada;
BEGIN

    OPEN mostrarDatosParaEnviarTarjetas;
    
    LOOP
        FETCH mostrarDatosParaEnviarTarjetas INTO idSocio_, nombre, apellidos, direccion, CP;
        
            EXIT WHEN mostrarDatosParaEnviarTarjetas%notfound;
        
            dbms_output.put_line(nombre || ' ' || apellidos || ', ' || direccion || ' ' || CP);
            
            --Hago la actualizacion
            UPDATE Socios S
            SET S.tarjetaEnviada = 'Y'
            WHERE S.idSocio = idSocio_;
            
            contador := contador +1;
            
    END LOOP;
    
    dbms_output.put_line('Cantidad de tarjetas a enviar' || contador);
    
    CLOSE mostrarDatosParaEnviarTarjetas;
    
END;
/