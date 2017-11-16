----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
--------------------------BORRAR--------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

--Eliminamos las tablas
DROP TABLE Fotos;
DROP TABLE Multimedia;
DROP TABLE Compras;
DROP TABLE Ventas;
DROP TABLE Alquileres;
DROP TABLE InventarioProveedores;
DROP TABLE PedidosProveedor;
DROP TABLE Proveedores;
DROP TABLE Inventario;
DROP TABLE Facturas;
DROP TABLE Juegos;
DROP TABLE Login;
DROP TABLE Socios;
DROP TABLE Personas;



--Eliminamos las secuencias
DROP SEQUENCE getPersonaId;
DROP SEQUENCE getJuegoId;
DROP SEQUENCE getFotoId;
DROP SEQUENCE getInventarioId;
DROP SEQUENCE getFacturaId;
DROP SEQUENCE getCompraId;
DROP SEQUENCE getAlquilerId;
DROP SEQUENCE getVentaId;
DROP SEQUENCE getProveedorId;
DROP SEQUENCE getPedidoProveedorId;
DROP SEQUENCE getInventarioProveedorId;


--Funciones
DROP FUNCTION getMargenBeneficios;
DROP FUNCTION getCosteAlquilerDiario;
DROP FUNCTION getEquivalenciaPuntosEuros;
DROP FUNCTION getFechaNoDevuelto;

DROP FUNCTION ASSERT_EQUALS;

DROP FUNCTION getDniConLetra;
DROP FUNCTION getYaExisteEseNombre;
DROP FUNCTION getSocioExiste;

DROP FUNCTION getProveedorMasBarato;
DROP FUNCTION getStockDisponibleVenta;
DROP FUNCTION getStockDisponibleComprarProv;
DROP FUNCTION getRowTypeTablaJuegos;
DROP FUNCTION getTieneFront;
DROP FUNCTION getCuatroFotosPorJuego;
DROP FUNCTION getPrecio;
DROP FUNCTION getPagado;
DROP FUNCTION getPrecioPagadoPorUsuario;
DROP FUNCTION getTiempoAlquiler;
DROP FUNCTION getCalcularPrecioAlquiler;
DROP FUNCTION getCantidadCompradaFactura;
DROP FUNCTION getDescripcionEstadoVenta;

DROP FUNCTION getJuegosParaElSlider;
DROP FUNCTION getTopJuegosNuevos;
DROP FUNCTION getTopNuevosLanzamientos;
DROP FUNCTION getComprasSocio;
DROP FUNCTION getVentasSocio;
DROP FUNCTION getAlquileresSocio;
DROP FUNCTION getFactura;
DROP FUNCTION getAutentificarLogin;
DROP FUNCTION getCantidadJuegosVendidos;
DROP FUNCTION getPrecioMedioPagadoJuego;
DROP FUNCTION getDineroInvertidoEnTenerStock;
DROP FUNCTION getBeneficiosPorVentas;
DROP FUNCTION getComprasTienda;
DROP FUNCTION getCantidadJuegosComprados;
DROP FUNCTION getPrecioMedioVendidoJuego;
DROP FUNCTION getVentasSociosATienda;
DROP FUNCTION getPerdidasPorRecompras;
DROP FUNCTION getIngresosPorAlquiler;
DROP FUNCTION getBeneficios;
DROP FUNCTION getStockJuego;

DROP FUNCTION getBusquedaPorNombre;
DROP FUNCTION getBusquedaPorPlataforma;
DROP FUNCTION getBusquedaPorGenero;
DROP FUNCTION getBusquedaFiltrada;
DROP FUNCTION getBusquedaOrdenada;
DROP FUNCTION getResultadoBusqueda;


--Tipos
DROP TYPE JuegoMostrarSliderTabla;
DROP TYPE JuegoMostrarHomeTabla;
DROP TYPE JuegoCompradosTabla;
DROP TYPE JuegoVendidosTabla;
DROP TYPE JuegoAlquiladosTabla;
DROP TYPE JuegoBusquedaTabla;

DROP TYPE JuegoMostrarSliderObj;
DROP TYPE JuegoMostrarFotoPrecioObj;
DROP TYPE JuegoCompradoObj;
DROP TYPE JuegoVendidoObj;
DROP TYPE JuegoAlquiladoObj;
DROP TYPE JuegoBusquedaObj;

----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
--------------------------TABLAS--------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------


--La tabla personas
CREATE TABLE Personas(
    idPersona INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(250) NOT NULL,
    cp SMALLINT NOT NULL,
    dni VARCHAR(20) NOT NULL,
    mail VARCHAR(250) NOT NULL,
    esSocio CHARACTER(1) DEFAULT 'N' NOT NULL
);

--La tabla login
CREATE TABLE Login(
    idLogin INT PRIMARY KEY, 
    usuario VARCHAR(100) NOT NULL,
    pass VARCHAR(100) NOT NULL
);

--La tabla juegos
CREATE TABLE Juegos(
    idJuego INT PRIMARY KEY,
    nombre VARCHAR2(200) NOT NULL,
    plataforma VARCHAR2(50) NOT NULL,
    genero VARCHAR2(50) NOT NULL,
    descripcion NCLOB NOT NULL,
    pegi INT NOT NULL,
    esEdicionColeccionista CHARACTER(1) DEFAULT 'N' NOT NULL,
    esSeminuevo CHARACTER(1) DEFAULT 'N' NOT NULL,
    esRetro CHARACTER(1) DEFAULT 'N' NOT NULL,
    esDigital CHARACTER(1) DEFAULT 'S' NOT NULL
);

--La tabla multimedia
CREATE TABLE Multimedia(
    idMultimedia INT PRIMARY KEY,
    front CHARACTER(1) DEFAULT 'N' NOT NULL,
    back CHARACTER(1) DEFAULT 'N' NOT NULL,
    youtube CHARACTER(11) DEFAULT 'NULL'
);

--La tabla fotos
CREATE TABLE Fotos(
    idFoto INT PRIMARY KEY,
    idMultimedia INT NOT NULL,
    nombre CHARACTER(7) NOT NULL
);

--La tabla inventario
CREATE TABLE Inventario(
    idInventario INT PRIMARY KEY,
    idJuego INT NOT NULL,
    unidadesEnStock INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

--La tabla facturas
CREATE TABLE Facturas(
    idFactura INT PRIMARY KEY,
    idSocio INT NOT NULL,
    idJuego INT NOT NULL,
    cantidad INTEGER NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fechaPedido DATE NOT NULL,
    fechaEntrega DATE NOT NULL
);

--La tabla compras
CREATE TABLE Compras(
    idCompra INT PRIMARY KEY,
    idFacturaCompra INT NOT NULL,
    esPagado CHARACTER(1) DEFAULT 'N' NOT NULL
);

--La tabla ventas
CREATE TABLE Ventas(
    idVenta INT PRIMARY KEY,
    idFacturaCompra INT NOT NULL,
    descripcionEstado VARCHAR(500) NOT NULL
);

--La tabla alquileres
CREATE TABLE Alquileres(
    idAlquiler INT PRIMARY KEY,
    idFacturaCompra INT NOT NULL,
    tiempoAlquiler INT NOT NULL
);

--La tabla proveedor
CREATE TABLE Proveedores(
    idProveedor INT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    mail VARCHAR(100) NOT NULL,
    cifNif VARCHAR(20) NOT NULL
);

--La tabla pedidosProveedor
CREATE TABLE PedidosProveedor(
    idPedidoProveedor INT PRIMARY KEY,
    idCompraFactura INT NOT NULL,
    idProveedor INT NOT NULL,
    esEntregado CHARACTER(1) DEFAULT 'N' NOT NULL
);

--La tabla socio
CREATE TABLE Socios(
    idSocio INT PRIMARY KEY,
    puntos INT NOT NULL,
    tarjetaEnviada CHARACTER(1) DEFAULT 'N' NOT NULL
);

CREATE TABLE InventarioProveedores(
  idInventarioProveedores INT PRIMARY KEY,
  idProveedor INT NOT NULL,
  idInventario INT NOT NULL
);

--Restricciones unicas
ALTER TABLE Personas ADD CONSTRAINT mailUnico UNIQUE (mail);

ALTER TABLE Login ADD CONSTRAINT loginUnico UNIQUE (usuario);


--Las claves secundarias
ALTER TABLE Socios ADD FOREIGN KEY (idSocio) REFERENCES Personas(idPersona);

ALTER TABLE Login ADD FOREIGN KEY (idLogin) REFERENCES Socios(idSocio);

ALTER TABLE Ventas ADD FOREIGN KEY (idFacturaCompra) REFERENCES Facturas(idFactura);

ALTER TABLE Alquileres ADD FOREIGN KEY (idFacturaCompra) REFERENCES Facturas(idFactura);

ALTER TABLE Compras ADD FOREIGN KEY (idFacturaCompra) REFERENCES Facturas(idFactura);

ALTER TABLE Facturas ADD FOREIGN KEY (idJuego) REFERENCES Juegos(idJuego);
ALTER TABLE Facturas ADD FOREIGN KEY (idSocio) REFERENCES Socios(idSocio);

ALTER TABLE PedidosProveedor ADD FOREIGN KEY (idCompraFactura) REFERENCES Facturas(idFactura);
ALTER TABLE PedidosProveedor ADD FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor);

ALTER TABLE InventarioProveedores ADD CONSTRAINT fkInventarioProReferenciaInven FOREIGN KEY (idInventario) REFERENCES Inventario(idInventario);
ALTER TABLE InventarioProveedores ADD CONSTRAINT fkInventarioProReferenciaProve FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor);

ALTER TABLE Multimedia ADD CONSTRAINT fkMultimediaReferenciaJuegos FOREIGN KEY (idMultimedia) REFERENCES Juegos(idJuego);

ALTER TABLE Inventario ADD CONSTRAINT fkInventarioReferenciaJuegos FOREIGN KEY (idJuego) REFERENCES Juegos(idJuego);

ALTER TABLE Fotos ADD CONSTRAINT fkFotosReferenciaMultimedia FOREIGN KEY (idMultimedia) REFERENCES Multimedia(idMultimedia);


--Los checks
ALTER TABLE Personas ADD CONSTRAINT checkCodigoPostal CHECK (CP > 0  AND CP < 100000);
ALTER TABLE Personas ADD CONSTRAINT checkEsSocio CHECK (esSocio = 'N' OR esSocio = 'Y');

ALTER TABLE Socios ADD CONSTRAINT checkPuntos CHECK (Puntos >= 0);
ALTER TABLE Socios ADD CONSTRAINT checkTarjetaEnviada CHECK (tarjetaEnviada = 'N' OR tarjetaEnviada = 'Y');

ALTER TABLE Login ADD CONSTRAINT checkUsuario CHECK (usuario <> '' AND LENGTH(usuario) > 0);
ALTER TABLE Login ADD CONSTRAINT checkPass CHECK (pass <> '' AND LENGTH(pass) > 0);

ALTER TABLE Juegos ADD CONSTRAINT checkNombre CHECK (nombre <> '' AND LENGTH(nombre) > 0);
ALTER TABLE Juegos ADD CONSTRAINT checkPegi CHECK (pegi > 0 AND pegi <= 18);
ALTER TABLE Juegos ADD CONSTRAINT checkEsEdicionColeccionista CHECK (esEdicionColeccionista = 'N' OR esEdicionColeccionista = 'Y');
ALTER TABLE Juegos ADD CONSTRAINT checkEsSeminuevo CHECK (esSeminuevo = 'N' OR esSeminuevo = 'Y');
ALTER TABLE Juegos ADD CONSTRAINT checkEsRetro CHECK (esRetro = 'N' OR esRetro = 'Y');
ALTER TABLE Juegos ADD CONSTRAINT checkEsDigital CHECK (esDigital = 'N' OR esDigital = 'Y');
    
ALTER TABLE Multimedia ADD CONSTRAINT checkFront CHECK (front = 'N' OR front = 'Y');
ALTER TABLE Multimedia ADD CONSTRAINT checkBack CHECK (back = 'N' OR back = 'Y');
    
ALTER TABLE Facturas ADD CONSTRAINT checkPrecio CHECK (precio >= 0);
ALTER TABLE Facturas ADD CONSTRAINT checkCantidad CHECK (cantidad > 0);

ALTER TABLE Compras ADD CONSTRAINT checkEsPagado CHECK (esPagado = 'N' OR esPagado = 'Y');
    
ALTER TABLE Ventas ADD CONSTRAINT checkDescripcionEstado CHECK (descripcionEstado <> '' AND LENGTH(descripcionEstado) >= 1);

ALTER TABLE Alquileres ADD CONSTRAINT checkTiempoAlquiler CHECK (tiempoAlquiler > 0);
    
ALTER TABLE Proveedores ADD CONSTRAINT checkNombreProveedor CHECK (nombre <> '' AND LENGTH(nombre) >= 1);
ALTER TABLE Proveedores ADD CONSTRAINT checkCif CHECK (cifNif <> '' AND LENGTH(cifNif) >= 1);

ALTER TABLE Inventario ADD CONSTRAINT checkUnidadesEnStock CHECK (unidadesEnStock >= 0);
ALTER TABLE Inventario ADD CONSTRAINT checkPrecioInventario CHECK (precio >= 0);
    
ALTER TABLE PedidosProveedor ADD CONSTRAINT checkEsEntregado CHECK (esEntregado = 'N' OR esEntregado = 'Y');
   
   
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
------------------------SECUENCIAS------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------


CREATE SEQUENCE getPersonaId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
  
CREATE SEQUENCE getJuegoId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
  
CREATE SEQUENCE getFotoId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
  
CREATE SEQUENCE getInventarioId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
  
CREATE SEQUENCE getFacturaId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
  
CREATE SEQUENCE getCompraId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
  
CREATE SEQUENCE getAlquilerId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
  
CREATE SEQUENCE getVentaId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
  
CREATE SEQUENCE getProveedorId
    MINVALUE -9999999999999 
    START WITH -1
    INCREMENT BY -1
    NOCACHE;
  
CREATE SEQUENCE getPedidoProveedorId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
CREATE SEQUENCE getInventarioProveedorId
    MINVALUE 1  
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    

----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
--------------------------TIPOS---------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

    
CREATE OR REPLACE TYPE JuegoMostrarSliderObj AS OBJECT
(
  idJuego INT,
  Nombre VARCHAR2(200),
  Front CHARACTER(1),
  Fotos VARCHAR2(50),
  Precio DECIMAL(10,2),
  Plataforma VARCHAR2(50)
);
/

CREATE OR REPLACE TYPE JuegoMostrarFotoPrecioObj AS OBJECT
(
  idJuego INT,
  Nombre VARCHAR2(200),
  Front CHARACTER(1),
  Precio DECIMAL(10,2),
  Plataforma VARCHAR2(50)
);
/

CREATE OR REPLACE TYPE JuegoCompradoObj AS OBJECT
(
  idJuego INT,
  Nombre VARCHAR2(200),
  Front CHARACTER(1),
  Precio DECIMAL(10,2),
  Plataforma VARCHAR2(50),
  Cantidad INT,
  pagado CHARACTER(1)
);
/

CREATE OR REPLACE TYPE JuegoVendidoObj AS OBJECT
(
  idJuego INT,
  Nombre VARCHAR2(200),
  Front CHARACTER(1),
  Precio DECIMAL(10,2),
  Plataforma VARCHAR2(50),
  Cantidad INT,
  descripcion VARCHAR(500)
);
/

CREATE OR REPLACE TYPE JuegoAlquiladoObj AS OBJECT
(
  idJuego INT,
  Nombre VARCHAR2(200),
  Front CHARACTER(1),
  Precio DECIMAL(10,2),
  Plataforma VARCHAR2(50),
  Cantidad INT,
  tiempoAlquiler VARCHAR(15)
);
/

CREATE OR REPLACE TYPE JuegoBusquedaObj AS OBJECT
(
  idJuego INT,
  nombre VARCHAR2(200),
  plataforma VARCHAR2(50),
  genero VARCHAR2(50),
  pegi INT,
  coleccionista CHARACTER(1),
  seminuevo CHARACTER(1),
  retro CHARACTER(1),
  digital CHARACTER(1), 
  front CHARACTER(1),
  precio DECIMAL(10,2),
  stock INT
); 
/

CREATE OR REPLACE TYPE JuegoMostrarSliderTabla AS TABLE OF JuegoMostrarSliderObj;
/

CREATE OR REPLACE TYPE JuegoMostrarHomeTabla AS TABLE OF JuegoMostrarFotoPrecioObj;
/

CREATE OR REPLACE TYPE JuegoCompradosTabla AS TABLE OF JuegoCompradoObj;
/

CREATE OR REPLACE TYPE JuegoVendidosTabla AS TABLE OF JuegoVendidoObj;
/

CREATE OR REPLACE TYPE JuegoAlquiladosTabla AS TABLE OF JuegoAlquiladoObj;
/

CREATE OR REPLACE TYPE JuegoBusquedaTabla AS TABLE OF JuegoBusquedaObj;
/

----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
--------------------CONSTANTES MAGICAS--------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

CREATE OR REPLACE FUNCTION getMargenBeneficios RETURN FLOAT AS 
    respuesta FLOAT;
BEGIN
    
    RETURN 1.5;
    
END getMargenBeneficios;
/

CREATE OR REPLACE FUNCTION getCosteAlquilerDiario RETURN FLOAT AS

BEGIN

    RETURN 2.0;

END getCosteAlquilerDiario;
/

CREATE OR REPLACE FUNCTION getEquivalenciaPuntosEuros RETURN INT AS

BEGIN

    RETURN 100;
    
END getEquivalenciaPuntosEuros;
/

CREATE OR REPLACE FUNCTION getFechaNoDevuelto RETURN DATE AS
BEGIN

    RETURN TO_DATE('2100-01-01', 'YYYY-MM-DD');
    
END getFechaNoDevuelto;
/



----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
---------------------------UTIL---------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------



CREATE OR REPLACE FUNCTION ASSERT_EQUALS(a1 IN BOOLEAN, a2 IN BOOLEAN) RETURN VARCHAR AS
BEGIN

    IF(a1 = a2) THEN
        RETURN 'TRUE';
    ELSE
        RETURN 'FALSE';
    END IF;

END ASSERT_EQUALS;
/





----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
-------------------------TRIGGERS-------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------



CREATE OR REPLACE FUNCTION getDniConLetra(modDNI IN INT, dniSinLetra IN INT) RETURN VARCHAR AS
BEGIN
    --Devuelve el DNI con la letra que tiene que tener asignada   
    RETURN dniSinLetra || 
    
    CASE modDNI
        WHEN 0 THEN 'T'
        WHEN 1 THEN 'R'
        WHEN 2 THEN 'W'
        WHEN 3 THEN 'A'
        WHEN 4 THEN 'G'
        WHEN 5 THEN 'M'
        WHEN 6 THEN 'Y'
        WHEN 7 THEN 'F'
        WHEN 8 THEN 'P'
        WHEN 9 THEN 'D'
        WHEN 10 THEN 'X'
        WHEN 11 THEN 'B'
        WHEN 12 THEN 'N'
        WHEN 13 THEN 'J'
        WHEN 14 THEN 'Z'
        WHEN 15 THEN 'S'
        WHEN 16 THEN 'Q'
        WHEN 17 THEN 'V'
        WHEN 18 THEN 'H'
        WHEN 19 THEN 'L'
        WHEN 20 THEN 'C'
        WHEN 21 THEN 'K'
        WHEN 22 THEN 'E'
    END;

END getDniConLetra;
/

CREATE OR REPLACE FUNCTION getYaExisteEseNombre(idJuego_ IN INT, Nombre_ IN CHARACTER) RETURN INT AS 
    respuesta INT;
    cantidad INT;
    nombre2 CHARACTER(7);
BEGIN
    --Devuelve la cantidad de fotos que tienen ese nombre para un juego concreto
    
    respuesta := 0;

    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Fotos F
    WHERE F.idMultimedia = idJuego_;
    IF cantidad > 0 THEN
          SELECT COUNT(*) INTO respuesta
          FROM Fotos F
          WHERE F.idMultimedia = idJuego_ AND TRIM(F.Nombre) LIKE TRIM(Nombre_);                       
    END IF;
    
    RETURN respuesta;
    
END getYaExisteEseNombre;
/

CREATE OR REPLACE FUNCTION getSocioExiste(idSocio_ IN INT) RETURN INT AS 
    Socios INT;
    Proveedores INT;
    cantidad INT;
BEGIN
    --Devuelve la cantidad de socios que existen con esa id
    
    --Los socios con ese id
    SELECT COUNT(*) INTO Socios
    FROM Socios S
    WHERE S.idSocio = idSocio_;
    
    --Los proveedores que tengan ese id
    SELECT COUNT(*) INTO Proveedores
    FROM Proveedores P
    WHERE P.idProveedor = idSocio_;
          
    cantidad := Socios + Proveedores;
            
    RETURN cantidad;
    
END getSocioExiste;
/





----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
-------------------------HELPERS--------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------



CREATE OR REPLACE FUNCTION getProveedorMasBarato(idJuego_ IN INT) RETURN INT AS
    respuesta INT;
BEGIN
    --Devuelve cual es el proveedor mas barato para ese juego

    SELECT COUNT(*) INTO respuesta
    FROM Inventario I INNER JOIN InventarioProveedores IP ON I.idInventario = IP.idInventario
    WHERE I.idJuego = 1;
    
    IF (respuesta > 0) THEN
    
        SELECT A.idProveedor INTO respuesta
        FROM (
              SELECT IP.idProveedor, I.precio, ROWNUM resultado
              FROM Inventario I INNER JOIN InventarioProveedores IP ON I.idInventario = IP.idInventario
              WHERE I.idJuego = 1
              ORDER BY I.precio ASC
              ) A
        WHERE A.resultado = 1;
    
    END IF;
    
    RETURN respuesta;

END getProveedorMasBarato;
/
        
CREATE OR REPLACE FUNCTION getStockDisponibleVenta(idJuego_ IN INT) RETURN INT AS 
    cantidad INT;
    juegosComprados INT;
    juegosVendidos INT;
    juegosRecomprados INT;
    juegosEnAlquiler INT;
BEGIN 
    --Devuelve la cantidad de stock que hay para que vendamos ese juego
    
    --Obtenemos las compras que hemos realizado de ese juego
    SELECT COUNT(*) INTO juegosComprados
    FROM Facturas F 
    WHERE F.idSocio = 0 AND F.idJuego = idJuego_ AND F.FechaEntrega <= sysdate;
        
    IF juegosComprados > 0 THEN
        
        SELECT SUM(F.Cantidad) INTO juegosComprados
        FROM Facturas F
        WHERE F.idSocio = 0 AND F.idJuego = idJuego_ AND F.FechaEntrega <= sysdate
        GROUP BY F.idJuego;
                    
    END IF;
    
    --Obtenemos la cantidad que hay en alquiler
    SELECT COUNT(*) INTO juegosEnAlquiler
    FROM Facturas F INNER JOIN Alquileres A ON A.idFacturaCompra = F.idFactura
    WHERE F.idSocio <> 0 AND F.idJuego = idJuego_ AND F.FechaEntrega > sysdate;
        
    IF juegosEnAlquiler > 0 THEN
          
        SELECT SUM(F.Cantidad) INTO juegosEnAlquiler
        FROM Facturas F INNER JOIN Alquileres A ON A.idFacturaCompra = F.idFactura
        WHERE F.idSocio <> 0 AND F.idJuego = idJuego_ AND F.FechaEntrega > sysdate
        GROUP BY F.idJuego;
                  
    END IF;
    
    --Obtenemos las ventas que hemos tenido de ese juego
    SELECT COUNT(*) INTO juegosVendidos
    FROM Facturas F INNER JOIN Compras P ON P.idFacturaCompra = F.idFactura
    WHERE F.idSocio <> 0 AND F.idJuego = idJuego_ AND F.FechaPedido <= sysdate;
        
    IF juegosVendidos > 0 THEN
        
        SELECT SUM(F.Cantidad) INTO juegosVendidos
        FROM Facturas F INNER JOIN Compras P ON P.idFacturaCompra = F.idFactura
        WHERE F.idSocio <> 0 AND F.idJuego = idJuego_ AND F.FechaPedido <= sysdate
        GROUP BY F.idJuego;
                  
    END IF;
    
    --Obtenemos los juegos que hemos comprado
    SELECT COUNT(*) INTO juegosRecomprados
    FROM Facturas F INNER JOIN Ventas V ON V.idFacturaCompra = F.idFactura
    WHERE F.idSocio <> 0 AND F.idJuego = idJuego_ AND F.FechaEntrega <= sysdate;
        
    IF juegosRecomprados > 0 THEN
        
        SELECT SUM(F.Cantidad) INTO juegosRecomprados
        FROM Facturas F INNER JOIN Ventas V ON V.idFacturaCompra = F.idFactura
        WHERE F.idSocio <> 0 AND F.idJuego = idJuego_ AND F.FechaEntrega <= sysdate
        GROUP BY F.idJuego;
                  
    END IF;    
    
    cantidad := juegosComprados - juegosVendidos + juegosRecomprados - juegosEnAlquiler;
    
    RETURN cantidad;
    
END getStockDisponibleVenta;
/

CREATE OR REPLACE FUNCTION getStockDisponibleComprarProv(idJuego_ IN INT) RETURN INT AS 
    cantidad INT;
BEGIN
    --Devuelve la cantidad que podemos comprarle a los proveedores de ese juego concreto

    --Obtenemos la cantidad de juegos que tienen en stock
    SELECT COUNT(*) INTO cantidad
    FROM Inventario I 
    WHERE I.idJuego = idJuego_;
    IF cantidad > 0 THEN
        SELECT SUM(I.UnidadesEnStock) INTO cantidad
        FROM Inventario I 
        WHERE I.idJuego = idJuego_
        GROUP BY I.idJuego;
    END IF;
    
    RETURN cantidad;
    
END getStockDisponibleComprarProv;
/

CREATE OR REPLACE FUNCTION getRowTypeTablaJuegos(idJuego_ IN INT) RETURN Juegos%ROWTYPE AS 
    respuesta Juegos%ROWTYPE;
    cantidad INT;
BEGIN
    --Devuelve el juego especificado con el formato que tiene en la tabla juegos

    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Juegos J 
    WHERE J.idJuego = idJuego_;
    IF cantidad > 0 THEN
        SELECT * INTO respuesta
        FROM Juegos J 
        WHERE J.idJuego = idJuego_;
    END IF;
    
    RETURN respuesta;
    
END getRowTypeTablaJuegos;
/

CREATE OR REPLACE FUNCTION getTieneFront(idJuego_ IN INT) RETURN CHARACTER AS 
    respuesta CHARACTER;
    cantidad INT;
BEGIN
    --Devuelve el front de ese juego en concreto
    
    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Juegos J INNER JOIN Multimedia M ON J.idJuego = M.idMultimedia
    WHERE J.idJuego = idJuego_;
    IF cantidad > 0 THEN
          SELECT M.front INTO respuesta
          FROM Juegos J INNER JOIN Multimedia M ON J.idJuego = M.idMultimedia
          WHERE J.idJuego = idJuego_;
    END IF;
    
    RETURN TRIM(respuesta);
    
END getTieneFront;
/

CREATE OR REPLACE FUNCTION getCuatroFotosPorJuego(idJuego_ IN INT) RETURN VARCHAR AS 
    respuesta CHARACTER(200);
    cantidad INT;
    cantidadFotosAux INT;
    cantidadFotosEnTotal INT;
    numAleatorio INT;
    nombreFotoAux CHARACTER(7);
    condicionDeSalida INT;
    numeroLimiteIter INT := 100;
BEGIN
    --Devuelve una cadena con cuatro fotos de ese juego al azar

    --Las fotos 
    SELECT COUNT(F.idMultimedia) INTO cantidadFotosAux
    FROM Fotos F
    WHERE F.idMultimedia = idJuego_;
    --Cosas
    cantidadFotosEnTotal := cantidadFotosAux;
          
    --Me aseguro de que hay al menos 4 fotos
    IF (cantidadFotosAux > 4) THEN
        cantidadFotosAux := 4;
    END IF;
          
    FOR Z in 1 .. cantidadFotosAux LOOP 
    
        --Calculo un numero aleatorio
        SELECT ran INTO numAleatorio
        FROM (
              SELECT round(dbms_random.VALUE(1,cantidadFotosEnTotal)) AS ran
              FROM Dual
              );
                            
        --Obtengo el nombre de esa foto
        SELECT nombre INTO nombreFotoAux
        FROM (
              SELECT Nombre, ROWNUM AS rNum
              FROM (
                    SELECT DISTINCT F.Nombre
                    FROM Fotos F
                    WHERE F.idMultimedia = idJuego_ 
                    ORDER BY F.Nombre ASC
                    )
              WHERE ROWNUM <= numAleatorio
              )
        WHERE rNum >= numAleatorio;
                  
        --La condicion de salida
        condicionDeSalida := 1;
                  
        --Miro que esa foto no se haya seleccionado hasta ahora
        WHILE condicionDeSalida = 1 AND numeroLimiteIter > 0
        LOOP
            
            --Presuponemos que no lo voy a encontrar
            condicionDeSalida := 0;
            
            --Veo si forma parte del array                 
            SELECT COUNT(*) INTO condicionDeSalida
            FROM Dual
            WHERE respuesta LIKE '%' || TRIM(nombreFotoAux) || '%' AND respuesta <> nombreFotoAux;
                                                    
            --Significa que hay uno repetido
            IF condicionDeSalida = 1 THEN
            
                --Calculo un numero aleatorio
                SELECT ran INTO numAleatorio
                FROM (
                      SELECT round(dbms_random.VALUE(1,cantidadFotosEnTotal)) AS ran
                      FROM Dual
                      );
                                                                      
                --Obtengo el nombre de esa foto
                SELECT TRIM(nombre) INTO nombreFotoAux
                FROM (
                      SELECT Nombre, ROWNUM AS rNum
                      FROM (
                            SELECT DISTINCT F.Nombre
                            FROM Fotos F
                            WHERE F.idMultimedia = idJuego_ 
                            ORDER BY F.Nombre ASC
                            )
                      WHERE ROWNUM <= numAleatorio
                      )
                WHERE rNum >= numAleatorio;
                          
                numeroLimiteIter := numeroLimiteIter -1;
                
            ELSE
            
                --Esa cadena no la tengo en el resultado por lo que la incluyo
                respuesta := TRIM(respuesta) || '#' || TRIM(nombreFotoAux);
            
            END IF;
            
        END LOOP;
        
    END LOOP; 
  
    RETURN TRIM(respuesta);
    
END getCuatroFotosPorJuego;
/

CREATE OR REPLACE FUNCTION getPrecio(idJuego_ IN INT) RETURN FLOAT AS 
    respuesta DECIMAL (10, 2);
    cantidad INT;
BEGIN
    --Devuelve el precio*beneficios mas reciente que hemos pagado por ese juego concreto

    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Facturas F
    WHERE idSocio = 0 AND F.idJuego = idJuego_;
    IF cantidad > 0 THEN
    
          SELECT aux.Precio INTO respuesta
          FROM (
                SELECT *
                FROM Facturas F
                WHERE F.idJuego = idJuego_ AND idSocio = 0
                ORDER BY F.FechaPedido DESC
                ) aux
          WHERE ROWNUM <= 1;
                    
    END IF;
    
    --Aplico los beneficios
    respuesta := getMargenBeneficios * respuesta;
        
    RETURN ROUND(respuesta, 2);
    
END getPrecio;
/

CREATE OR REPLACE FUNCTION getPagado(idFacturaCompra_ IN INT) RETURN CHARACTER AS 
    respuesta CHARACTER (1);
    cantidad INT;
BEGIN
    --Devuelve si esa compra del socio ha sido pagada o no

    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Compras C
    WHERE C.idFacturaCompra = idFacturaCompra_;
    IF cantidad > 0 THEN
    
        SELECT C.esPagado INTO respuesta
        FROM Compras C
        WHERE C.idFacturaCompra = idFacturaCompra_;
                    
    END IF;
            
    RETURN TRIM(respuesta);
    
END getPagado;
/

CREATE OR REPLACE FUNCTION getPrecioPagadoPorUsuario(idFactura_ IN INT) RETURN FLOAT AS 
    respuesta DECIMAL (10, 2) := 0.0;
    cantidad INT;
BEGIN
    --Devuelve el precio que pago un usuario por un producto

    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Facturas F
    WHERE F.idFactura = idFactura_;
    IF cantidad > 0 THEN    
          
            SELECT F.Precio INTO respuesta
            FROM Facturas F
            WHERE F.idFactura = idFactura_;
                    
    END IF;
    
    RETURN ROUND(respuesta, 2);
    
END getPrecioPagadoPorUsuario;
/

CREATE OR REPLACE FUNCTION getTiempoAlquiler(idFactura_ IN INT) RETURN INT AS 
    respuesta INT := 0;
    cantidad INT;
    fechaDevolucion DATE;
    fechaAlquiler DATE;
BEGIN
    --Devuelve el tiempo en dias que ha tenido alquilado un juego

    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Facturas F
    WHERE F.idFactura = idFactura_;
    IF cantidad > 0 THEN    
          
            SELECT F.FechaEntrega INTO fechaDevolucion
            FROM Facturas F
            WHERE F.idFactura = idFactura_;
            
            SELECT F.FechaPedido INTO fechaAlquiler
            FROM Facturas F
            WHERE F.idFactura = idFactura_;
          
            --Si lo ha devuelto
            IF fechaDevolucion = getFechaNoDevuelto THEN
            
                fechaDevolucion := sysdate;
            
            END IF;
          
            respuesta := fechaDevolucion - fechaAlquiler;
                    
    END IF;
    
    RETURN respuesta;
    
END getTiempoAlquiler;
/

CREATE OR REPLACE FUNCTION getCalcularPrecioAlquiler(idFactura_ IN INT) RETURN FLOAT AS 
    respuesta DECIMAL (10, 2) := 0.0;
BEGIN
    --Devuelve el precio que esta costando o ha costado un alquiler
    
    respuesta := getTiempoAlquiler(idFactura_) * getCosteAlquilerDiario;
    
    RETURN ROUND(respuesta, 2);
    
END getCalcularPrecioAlquiler;
/

CREATE OR REPLACE FUNCTION getCantidadCompradaFactura(idFactura_ IN INT) RETURN INT AS 
    respuesta INT;
    cantidad INT;
BEGIN
    --Devuelve la cantidad de juegos que se han comprado en esa factura

    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Facturas F
    WHERE F.idFactura = idFactura_;
    IF cantidad > 0 THEN
    
          SELECT F.cantidad INTO respuesta
          FROM Facturas F
          WHERE F.idFactura = idFactura_;
                    
    END IF;
    
    RETURN respuesta;
    
END getCantidadCompradaFactura;
/

CREATE OR REPLACE FUNCTION getDescripcionEstadoVenta(idFacturaCompra_ IN INT) RETURN VARCHAR AS 
    respuesta VARCHAR(500);
    cantidad INT;
BEGIN
    --Devuelve el estado que consta de la venta que nos hizo a nosotros del juego

    --Obtenemos la cantidad de datos de la respuesta
    SELECT COUNT(*) INTO cantidad
    FROM Ventas V
    WHERE V.idFacturaCompra = idFacturaCompra_;
    IF cantidad > 0 THEN
    
          SELECT V.descripcionEstado INTO respuesta
          FROM Ventas V
          WHERE V.idFacturaCompra = idFacturaCompra_;
                    
    END IF;
    
    RETURN TRIM(respuesta);
    
END getDescripcionEstadoVenta;
/





----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
---------------------------WEB----------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------



CREATE OR REPLACE FUNCTION getJuegosParaElSlider (cantidadJuegos IN INT) RETURN JuegoMostrarSliderTabla PIPELINED AS
    idJuegoAux INT := 1;
    tablaJuego Juegos%ROWTYPE;
    arrayFotos VARCHAR(200);
    caratula CHARACTER(1);
    precio DECIMAL(10,2);
BEGIN
    --Devuelve x juegos con 4 fotos cada uno y su frontal con todos los datos necesarios para meterlo en el slider

    FOR X IN 1 .. cantidadJuegos
    LOOP
        
        --Obtenemos el idJuego de los mas vendidos por orden, de uno en uno
        SELECT idJuego INTO idJuegoAux
        FROM (
              SELECT idJuego, ROWNUM AS rNum
              FROM (
                    SELECT DISTINCT F.idJuego, SUM(F.cantidad) AS cantidad
                    FROM Facturas F INNER JOIN Compras C ON F.idFactura = C.idFacturaCompra
                    GROUP BY F.idJuego
                    ORDER BY cantidad DESC
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
                      
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                          
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
                        
        --Las fotos del juego
        arrayFotos := getCuatroFotosPorJuego(idJuegoAux);
                        
        --Calculo el precio de ese juego
        precio := getPrecio(idJuegoAux);
                        
        PIPE ROW( JuegoMostrarSliderObj(idJuegoAux, TRIM(tablaJuego.Nombre), caratula, arrayFotos, precio, TRIM(tablaJuego.plataforma)) );   
    
    END LOOP;
    
    RETURN;
    
END getJuegosParaElSlider;
/

CREATE OR REPLACE FUNCTION getTopJuegosNuevos (cantidadJuegos IN INT) RETURN JuegoMostrarHomeTabla PIPELINED AS
    idJuegoAux INT := 1;
    tablaJuego Juegos%ROWTYPE;
    caratula CHARACTER;
    precio DECIMAL(10,2);
BEGIN
    --Devuelve x juegos que son los mas recientes que hemos comprado o reabastecido

    FOR X IN 1 .. cantidadJuegos
    LOOP
        
        --Obtenemos el idJuego de los mas recientes por orden, de uno en uno
        SELECT idJuego INTO idJuegoAux
        FROM (
              SELECT idJuego, ROWNUM AS rNum
              FROM (
                    SELECT *
                    FROM Facturas F 
                    WHERE F.idSocio = 0
                    ORDER BY F.FechaEntrega DESC
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
            
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                  
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
                
        --Calculo el precio de ese juego
        precio := getPrecio(idJuegoAux);
                
        PIPE ROW( JuegoMostrarFotoPrecioObj(idJuegoAux, tablaJuego.Nombre, caratula, precio, tablaJuego.plataforma) );   
    
    END LOOP;
    
    RETURN;
    
END getTopJuegosNuevos;
/

CREATE OR REPLACE FUNCTION getTopNuevosLanzamientos (cantidadJuegos IN INT) RETURN JuegoMostrarHomeTabla PIPELINED AS
    idJuegoAux INT := 1;
    tablaJuego Juegos%ROWTYPE;
    caratula CHARACTER;
    precio DECIMAL(10,2);
BEGIN
    --Devuelve x juegos que aun no han sido entregados y estamos pendientes de recibir

    FOR X IN 1 .. cantidadJuegos
    LOOP
        
        --Obtenemos el idJuego de los mas nuevos por orden, de uno en uno
        SELECT idJuego INTO idJuegoAux
        FROM (
              SELECT idJuego, ROWNUM AS rNum
              FROM (
                    SELECT *
                    FROM Facturas F INNER JOIN PedidosProveedor PP ON F.idFactura = PP.idCompraFactura
                    WHERE F.idSocio = 0 AND PP.esEntregado = 'N'
                    ORDER BY F.FechaPedido DESC
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
            
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                  
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
                
        --Calculo el precio de ese juego
        precio := getPrecio(idJuegoAux);
                
        PIPE ROW( JuegoMostrarFotoPrecioObj(idJuegoAux, tablaJuego.Nombre, caratula, precio, tablaJuego.plataforma) );   
    
    END LOOP;
    
    RETURN;
    
END getTopNuevosLanzamientos;
/

CREATE OR REPLACE FUNCTION getComprasSocio(idSocio_ IN INT) RETURN JuegoCompradosTabla PIPELINED AS
    idJuegoAux INT := 1;
    idFacturaAux INT := 1;
    tablaJuego Juegos%ROWTYPE;
    caratula CHARACTER;
    precio DECIMAL(10,2);
    cantidadDeCompras INT;
    cantidadAux INT;
    pagadoSoN CHARACTER(1);
BEGIN
    --Devuelve las compras que ha efectuado un socio

    SELECT COUNT(*) INTO cantidadDeCompras
    FROM Compras C INNER JOIN Facturas F ON C.idFacturaCompra = F.idFactura
    WHERE F.idSocio = idSocio_;
        
    IF (cantidadDeCompras = 0) THEN
        RETURN;
    END IF;

    FOR X IN 1 .. cantidadDeCompras
    LOOP
        
        --Obtenemos el idFactura por orden, de uno en uno
        SELECT idFactura INTO idFacturaAux
        FROM (
              SELECT idFactura, cantidad, ROWNUM AS rNum
              FROM (
                    SELECT F.*, C.*
                    FROM Compras C INNER JOIN Facturas F ON C.idFacturaCompra = F.idFactura
                    WHERE F.idSocio = idSocio_  
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
            
        SELECT F.idJuego INTO idJuegoAux
        FROM Facturas F
        WHERE F.idFactura = idFacturaAux;
          
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                  
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
        
        --Obtengo el precio 
        precio := getPrecioPagadoPorUsuario(idFacturaAux);
        
        --Obtengo la cantidad de juegos comprados
        cantidadAux := getCantidadCompradaFactura(idFacturaAux);
        
        --Obtengo si el juego esta pagado
        pagadoSoN := getPagado(idFacturaAux);
                               
        PIPE ROW( JuegoCompradoObj(idJuegoAux, TRIM(tablaJuego.Nombre), caratula, precio, tablaJuego.plataforma, cantidadAux, pagadoSoN) );   
    
    END LOOP;
    
    RETURN;
    
END getComprasSocio;
/

CREATE OR REPLACE FUNCTION getVentasSocio(idSocio_ IN INT) RETURN JuegoVendidosTabla PIPELINED AS
    idJuegoAux INT := 1;
    idFacturaAux INT := 1;
    tablaJuego Juegos%ROWTYPE;
    caratula CHARACTER;
    precio DECIMAL(10,2);
    cantidadDeVentas INT;
    cantidadAux INT;
    descripcion VARCHAR(500);
BEGIN
    --Devuelve las juegos que nos ha vendido a nosotros un socio

    SELECT COUNT(*) INTO cantidadDeVentas
    FROM Ventas V INNER JOIN Facturas F ON V.idFacturaCompra = F.idFactura
    WHERE F.idSocio = idSocio_;
        
    IF (cantidadDeVentas = 0) THEN
        RETURN;
    END IF;

    FOR X IN 1 .. cantidadDeVentas
    LOOP
        
        --Obtenemos el idJuego de los mas vendidos por orden, de uno en uno
        SELECT idFactura INTO idFacturaAux
        FROM (
              SELECT idFactura, cantidad, ROWNUM AS rNum
              FROM (
                    SELECT F.*, V.*
                    FROM Ventas V INNER JOIN Facturas F ON V.idFacturaCompra = F.idFactura
                    WHERE F.idSocio = idSocio_  
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
            
        SELECT F.idJuego INTO idJuegoAux
        FROM Facturas F
        WHERE F.idFactura = idFacturaAux;
          
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                  
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
        
        --Obtengo el precio 
        precio := getPrecioPagadoPorUsuario(idFacturaAux);
        
        --Obtengo la cantidad de juegos vendidos
        cantidadAux := getCantidadCompradaFactura(idFacturaAux);
        
        --Obtengo la descripcion
        descripcion := getDescripcionEstadoVenta(idFacturaAux);
                               
        PIPE ROW( JuegoVendidoObj(idJuegoAux, tablaJuego.Nombre, caratula, precio, tablaJuego.plataforma, cantidadAux, descripcion) );   
    
    END LOOP;
    
    RETURN;
    
END getVentasSocio;
/

CREATE OR REPLACE FUNCTION getAlquileresSocio(idSocio_ IN INT) RETURN JuegoAlquiladosTabla PIPELINED AS
    idJuegoAux INT := 1;
    idFacturaAux INT := 1;
    tablaJuego Juegos%ROWTYPE;
    caratula CHARACTER;
    precio DECIMAL(10,2);
    cantidadDeAlquileres INT;
    cantidadAux INT;
    tiempoDeAlquiler VARCHAR(15);
BEGIN
    --Devuelve los alquileres que ha efectuado un socio

    SELECT COUNT(*) INTO cantidadDeAlquileres
    FROM Alquileres A INNER JOIN Facturas F ON A.idFacturaCompra = F.idFactura
    WHERE F.idSocio = idSocio_;
        
    IF (cantidadDeAlquileres = 0) THEN
        RETURN;
    END IF;

    FOR X IN 1 .. cantidadDeAlquileres
    LOOP
        
        --Obtenemos el idJuego de los mas vendidos por orden, de uno en uno
        SELECT idFactura INTO idFacturaAux
        FROM (
              SELECT idFactura, cantidad, ROWNUM AS rNum
              FROM (
                    SELECT F.*, A.*
                    FROM Alquileres A INNER JOIN Facturas F ON A.idFacturaCompra = F.idFactura
                    WHERE F.idSocio = idSocio_ 
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
            
        SELECT F.idJuego INTO idJuegoAux
        FROM Facturas F
        WHERE F.idFactura = idFacturaAux;
          
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                  
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
        
        --Obtengo el precio 
        precio := getCalcularPrecioAlquiler(idFacturaAux);
        
        --Obtengo la cantidad de juegos alquilados
        cantidadAux := getCantidadCompradaFactura(idFacturaAux);
        
        --Obtengo el tiempo de alquiler
        tiempoDeAlquiler := TO_CHAR(getTiempoAlquiler(idFacturaAux));
                               
        PIPE ROW( JuegoAlquiladoObj(idJuegoAux, tablaJuego.Nombre, caratula, precio, tablaJuego.plataforma, cantidadAux, tiempoDeAlquiler) );   
    
    END LOOP;
    
    RETURN;
    
END getAlquileresSocio;
/

CREATE OR REPLACE FUNCTION getFactura(idSocio_ IN INT) RETURN JuegoCompradosTabla PIPELINED AS
    idJuegoAux INT := 1;
    idFacturaAux INT := 1;
    tablaJuego Juegos%ROWTYPE;
    caratula CHARACTER;
    precio DECIMAL(10,2);
    cantidadDePagosPendiente INT;
    cantidadAux INT;
    pagadoSoN CHARACTER(1);
BEGIN
    --Devuelve los juegos que aun estan pendientes de pagar de un socio

    SELECT COUNT(*) INTO cantidadDePagosPendiente
    FROM Compras C INNER JOIN Facturas F ON C.idFacturaCompra = F.idFactura
    WHERE F.idSocio = idSocio_ AND C.esPagado = 'N';
        
    IF (cantidadDePagosPendiente = 0) THEN
        RETURN;
    END IF;

    FOR X IN 1 .. cantidadDePagosPendiente
    LOOP
        
        --Obtenemos el idFactura por orden, de uno en uno
        SELECT idFactura INTO idFacturaAux
        FROM (
              SELECT idFactura, cantidad, ROWNUM AS rNum
              FROM (
                    SELECT F.*, C.*
                    FROM Compras C INNER JOIN Facturas F ON C.idFacturaCompra = F.idFactura
                    WHERE F.idSocio = idSocio_ AND C.esPagado = 'N'
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
            
        SELECT F.idJuego INTO idJuegoAux
        FROM Facturas F
        WHERE F.idFactura = idFacturaAux;
          
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                  
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
        
        --Obtengo el precio 
        precio := getPrecioPagadoPorUsuario(idFacturaAux);
        
        --Obtengo la cantidad de juegos comprados
        cantidadAux := getCantidadCompradaFactura(idFacturaAux);
        
        --Obtengo si el juego esta pagado
        pagadoSoN := getPagado(idFacturaAux);
                               
        PIPE ROW( JuegoCompradoObj(idJuegoAux, tablaJuego.Nombre, caratula, precio, tablaJuego.plataforma, cantidadAux, pagadoSoN) );   
    
    END LOOP;
    
    RETURN;
    
END getFactura;
/

CREATE OR REPLACE FUNCTION getAutentificarLogin(usuario_ IN VARCHAR, pass_ IN VARCHAR) RETURN VARCHAR AS 
    respuesta VARCHAR(120) := '';
    cantidad INT;
BEGIN
    --Devuelve el nombre de usuario||1  si es valido o '' si no es un login correcto

    --Ver si existe eso
    SELECT COUNT(*) INTO cantidad
    FROM Login L
    WHERE L.Usuario = usuario_ AND L.Pass = pass_;
    IF cantidad > 0 THEN
    
          SELECT L.idLogin INTO cantidad
          FROM Login L
          WHERE L.Usuario = usuario_ AND L.Pass = pass_;
          
          respuesta := usuario_ || TO_CHAR(cantidad);
                    
    END IF;
    
    RETURN respuesta;
    
END getAutentificarLogin;
/

CREATE OR REPLACE FUNCTION getCantidadJuegosVendidos(idJuego_ IN INT, fechaDesde IN DATE, fechaHasta IN DATE) RETURN INT AS 
    respuesta INT;
    cantidad INT;
BEGIN
    --Devuelve los juegos que nosotros hemos vendido en ese rango

    --Ver si existe eso
    SELECT COUNT(*) INTO cantidad
    FROM Compras C INNER JOIN Facturas F ON F.idFactura = C.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta AND F.idJuego = idJuego_ AND F.idSocio <> 0;
    IF cantidad > 0 THEN
    
          SELECT cantidad INTO respuesta
          FROM (
                SELECT F.idJuego, SUM(F.cantidad) cantidad
                FROM Compras C INNER JOIN Facturas F ON F.idFactura = C.idFacturaCompra
                WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta AND F.idJuego = idJuego_ AND F.idSocio <> 0
                GROUP BY F.idJuego
              );
              
    END IF;
    
    RETURN respuesta;
    
END getCantidadJuegosVendidos;
/

CREATE OR REPLACE FUNCTION getPrecioMedioPagadoJuego(idJuego_ IN INT, fechaDesde IN DATE, fechaHasta IN DATE) RETURN FLOAT AS 
    respuesta FLOAT := 0.0;
    cantidad INT;
BEGIN
    --Devuelve el precio medio que hemos pagado por un juego en ese rango de fechas

    --Ver si existe eso
    SELECT COUNT(*) INTO cantidad
    FROM Compras C INNER JOIN Facturas F ON F.idFactura = C.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta AND F.idJuego = idJuego_ AND F.idSocio <> 0;
    IF cantidad > 0 THEN
              
          SELECT SUM(totalFila) INTO respuesta
          FROM
                (
                SELECT F.cantidad * F.precio totalFila
                FROM Facturas F INNER JOIN Compras C ON F.idFactura = C.idFacturaCompra
                WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta AND F.idJuego = idJuego_ AND F.idSocio <> 0
                );                    
    END IF;
    
    RETURN ROUND(respuesta/cantidad, 2);
    
END getPrecioMedioPagadoJuego;
/

CREATE OR REPLACE FUNCTION getDineroInvertidoEnTenerStock(fechaDesde IN DATE, fechaHasta IN DATE) RETURN FLOAT AS 
    respuesta FLOAT := 0.0;
    cantidad INT;
BEGIN
    --Devuelve la cantidad de dinero que hemos invertido en tener stock

    --Ver si existe eso
    SELECT COUNT(*) INTO cantidad
    FROM Facturas F
    WHERE F.idSocio = 0 AND F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta;
    IF cantidad > 0 THEN
              
          SELECT SUM(totalFila) INTO respuesta
          FROM
                (
                SELECT F.cantidad * F.precio totalFila
                FROM Facturas F
                WHERE F.idSocio = 0 AND F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta
                );
                
    END IF;
    
    RETURN ROUND(respuesta, 2);
    
END getDineroInvertidoEnTenerStock;
/

CREATE OR REPLACE FUNCTION getBeneficiosPorVentas(fechaDesde IN DATE, fechaHasta IN DATE) RETURN FLOAT AS 
    respuesta FLOAT := 0.0;
    cantidad INT;
BEGIN
    --Devuelve los beneficios por ventas de juegos que hemos tenido

    --Ver si existe eso
    SELECT COUNT(*) INTO cantidad
    FROM Facturas F INNER JOIN Compras C ON F.idFactura = C.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta;

    IF cantidad > 0 THEN
              
          SELECT SUM(totalFila) INTO respuesta
          FROM
                (
                SELECT F.cantidad * F.precio totalFila
                FROM Facturas F INNER JOIN Compras C ON F.idFactura = C.idFacturaCompra
                WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta
                );
                
    END IF;
    
    RETURN ROUND(respuesta, 2);
    
END getBeneficiosPorVentas;
/

CREATE OR REPLACE FUNCTION getComprasTienda(fechaDesde IN DATE, fechaHasta IN DATE) RETURN JuegoCompradosTabla PIPELINED AS
    idJuegoAux INT;
    tablaJuego Juegos%ROWTYPE;
    caratula CHARACTER;
    precio DECIMAL(10,2);
    cantidadDeCompras INT;
    cantidadAux INT;
BEGIN
    --Devuelve las compras que hemos realizado en un rango de fechas

    SELECT COUNT(*) INTO cantidadDeCompras
    FROM Compras C INNER JOIN Facturas F ON F.idFactura = C.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta;
        
    IF (cantidadDeCompras = 0) THEN
        RETURN;
    END IF;

    FOR X IN 1 .. cantidadDeCompras
    LOOP
        
        --Obtenemos el idJuego por orden, de uno en uno
        SELECT idJuego INTO idJuegoAux
        FROM (
              SELECT idJuego, cantidad, ROWNUM AS rNum
              FROM (
                    SELECT F.idJuego, SUM(F.cantidad) cantidad
                    FROM Compras C INNER JOIN Facturas F ON F.idFactura = C.idFacturaCompra
                    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta
                    GROUP BY F.idJuego
                    ORDER BY F.idJuego ASC
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
          
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                  
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
        
        --Obtengo el precio 
        precio := getPrecioMedioPagadoJuego(idJuegoAux, fechaDesde, fechaHasta);
        
        --Obtengo la cantidad de juegos comprados en la fecha dada
        cantidadAux := getCantidadJuegosVendidos(idJuegoAux, fechaDesde, fechaHasta);
                               
        PIPE ROW( JuegoCompradoObj(idJuegoAux, tablaJuego.Nombre, caratula, precio, tablaJuego.plataforma, cantidadAux, 'N') );   
    
    END LOOP;
    
    RETURN;
    
END getComprasTienda;
/

CREATE OR REPLACE FUNCTION getCantidadJuegosComprados(idJuego_ IN INT, fechaDesde IN DATE, fechaHasta IN DATE) RETURN INT AS 
    respuesta INT;
    cantidad INT;
BEGIN
    --Devuelve la cantidad de juegos que han salido gratis gracias a los puntos

    --Ver si existe eso
    SELECT COUNT(*) INTO cantidad
    FROM Ventas V INNER JOIN Facturas F ON F.idFactura = V.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta AND F.idJuego = idJuego_ AND F.idSocio <> 0;
    IF cantidad > 0 THEN
    
          SELECT cantidad INTO respuesta
          FROM (
                SELECT F.idJuego, SUM(F.cantidad) cantidad
                FROM Ventas V INNER JOIN Facturas F ON F.idFactura = V.idFacturaCompra
                WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta AND F.idJuego = idJuego_ AND F.idSocio <> 0
                GROUP BY F.idJuego
          );
                    
    END IF;
    
    RETURN respuesta;
    
END getCantidadJuegosComprados;
/

CREATE OR REPLACE FUNCTION getPrecioMedioVendidoJuego(idJuego_ IN INT, fechaDesde IN DATE, fechaHasta IN DATE) RETURN FLOAT AS 
    respuesta FLOAT := 0.0;
    cantidad INT;
BEGIN
    --Devuelve el precio medio por el que hemos vendido ese juego en ese rango de fechas

    --Ver si existe eso
    SELECT COUNT(*) INTO cantidad
    FROM Ventas V INNER JOIN Facturas F ON F.idFactura = V.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta AND F.idJuego = idJuego_ AND F.idSocio <> 0;
    
    IF cantidad > 0 THEN
        
          SELECT SUM(totalFila) INTO respuesta
          FROM
                (
                SELECT F.cantidad * F.precio totalFila
                FROM Facturas F INNER JOIN Ventas V ON F.idFactura = V.idFacturaCompra
                WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta AND F.idJuego = idJuego_ AND F.idSocio <> 0
                );
                    
    END IF;
    
    RETURN ROUND(respuesta/cantidad, 2);
    
END getPrecioMedioVendidoJuego;
/

CREATE OR REPLACE FUNCTION getVentasSociosATienda(fechaDesde IN DATE, fechaHasta IN DATE) RETURN JuegoCompradosTabla PIPELINED AS
    idJuegoAux INT;
    tablaJuego Juegos%ROWTYPE;
    caratula CHARACTER;
    precio DECIMAL(10,5);
    cantidadDeVentas INT;
    cantidadAux INT;
BEGIN
    --Devuelve los juegos que los socios nos han vendido en ese rango de fechas

    SELECT COUNT(*) INTO cantidadDeVentas
    FROM Ventas V INNER JOIN Facturas F ON F.idFactura = V.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta;
        
    IF (cantidadDeVentas = 0) THEN
        RETURN;
    END IF;

    FOR X IN 1 .. cantidadDeVentas
    LOOP
        
        --Obtenemos el idJuego por orden, de uno en uno
        SELECT idJuego INTO idJuegoAux
        FROM (
              SELECT idJuego, cantidad, ROWNUM AS rNum
              FROM (
                    SELECT F.idJuego, SUM(F.cantidad) cantidad
                    FROM Ventas V INNER JOIN Facturas F ON F.idFactura = V.idFacturaCompra
                    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta
                    GROUP BY F.idJuego
                    ORDER BY F.idJuego ASC
                    )
              WHERE ROWNUM <= X
              )
        WHERE rNum >= X;
          
        tablaJuego := getRowTypeTablaJuegos(idJuegoAux);
                  
        --Obtengo si tiene front
        caratula := getTieneFront(idJuegoAux);
        
        --Obtengo el precio 
        precio := getPrecioMedioVendidoJuego(idJuegoAux, fechaDesde, fechaHasta)/getEquivalenciaPuntosEuros;
        
        --Obtengo la cantidad de juegos que he comprado en la fecha dada a otros usuarios
        cantidadAux := getCantidadJuegosComprados(idJuegoAux, fechaDesde, fechaHasta);
                               
        PIPE ROW( JuegoCompradoObj(idJuegoAux, tablaJuego.Nombre, caratula, precio, tablaJuego.plataforma, cantidadAux, 'N') );   
    
    END LOOP;
    
    RETURN;
    
END getVentasSociosATienda;
/

CREATE OR REPLACE FUNCTION getPerdidasPorRecompras(fechaDesde IN DATE, fechaHasta IN DATE) RETURN FLOAT AS
    respuesta DECIMAL(10,2) := 0.0;
    cantidadDeRecompras INT;
BEGIN
    --Devuelve las perdidas que han generado las recompras de los socios en ese rango de fechas

    SELECT COUNT(*) INTO cantidadDeRecompras
    FROM Ventas V INNER JOIN Facturas F ON F.idFactura = V.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta;
        
    IF (cantidadDeRecompras > 0) THEN
    
        SELECT SUM(totalFila) INTO respuesta
        FROM
              (
              SELECT F.cantidad * F.precio totalFila
              FROM Ventas V INNER JOIN Facturas F ON F.idFactura = V.idFacturaCompra
              WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta
              );
              
    END IF;
    
    RETURN ROUND(respuesta, 2);
    
END getPerdidasPorRecompras;
/

CREATE OR REPLACE FUNCTION getIngresosPorAlquiler(fechaDesde IN DATE, fechaHasta IN DATE) RETURN FLOAT AS
    respuesta DECIMAL(10,2) := 0.0;
    cantidadDeAlquileres INT;
BEGIN
    --Devuelve los ingresos  por alquileres ya finalizados en ese rango de fechas

    SELECT COUNT(*) INTO cantidadDeAlquileres
    FROM Alquileres A INNER JOIN Facturas F ON F.idFactura = A.idFacturaCompra
    WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta;
        
    IF (cantidadDeAlquileres > 0) THEN
    
        SELECT SUM(totalFila) INTO respuesta
        FROM
              (
              SELECT F.cantidad * F.precio totalFila
              FROM Alquileres A INNER JOIN Facturas F ON F.idFactura = A.idFacturaCompra
              WHERE F.FechaPedido >= fechaDesde AND F.FechaEntrega <= fechaHasta
              );
              
    END IF;
    
    RETURN ROUND(respuesta, 2);
    
END getIngresosPorAlquiler;
/

CREATE OR REPLACE FUNCTION getBeneficios(fechaDesde IN DATE, fechaHasta IN DATE) RETURN FLOAT AS 
    respuesta FLOAT := 0.0;
    cantidad INT;
BEGIN
    --Devuelve los beneficios totales que hemos tenido contando las ventas, los alquileres, las perdidas por recomprar y el gasto por stock
    
    --Sumo los ingresos por las ventas a usuarios
     respuesta := respuesta + getBeneficiosPorVentas(fechaDesde, fechaHasta);
    
    --Sumo los ingresos por alquiler
    respuesta := respuesta + getIngresosPorAlquiler(fechaDesde, fechaHasta);
    
    --Resto lo que ha costado tener stock
    respuesta := respuesta - getDineroInvertidoEnTenerStock(fechaDesde, fechaHasta);
    
    --Resto lo que me han costado las recompras a los usuarios
    respuesta := respuesta - getPerdidasPorRecompras(fechaDesde, fechaHasta);
    
    RETURN ROUND(respuesta, 2);
    
END getBeneficios;
/

CREATE OR REPLACE FUNCTION getStockJuego(idJuego_ IN INT) RETURN INT AS
    respuesta INT := getStockDisponibleVenta(idJuego_);
    estaPendienteDeLlegar INT;
BEGIN
    --Devuelve el stock que hay de ese juego para mostrar en la compra, positivo es que hay, 0 se permite reservar y -1 es agotado

    IF(respuesta <= 0) THEN
        
        --Veo si tengo algun pedido pendiente de que me llegue
        SELECT COUNT(*) INTO estaPendienteDeLlegar
        FROM Facturas F
        WHERE idSocio = 0 AND F.fechaEntrega = getFechaNoDevuelto AND F.idJuego = idJuego_;
        
        IF estaPendienteDeLlegar >= 1 THEN
        
            respuesta := 0;
          
        ELSE
        
            respuesta := -1;
            
        END IF;
    
    END IF;
    
    RETURN respuesta;
    
END getStockJuego;
/





----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
------------------------BUSQUEDAS-------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------



CREATE OR REPLACE FUNCTION getBusquedaPorNombre(nombre_ IN VARCHAR) RETURN JuegoBusquedaTabla AS
    resultado JuegoBusquedaTabla;
BEGIN
    --Busco solo segun el nombre del juego
     
    --Realizo la consulta y la guardo en la tabla
    SELECT JuegoBusquedaObj(A.idJuego, A.nombre, A.plataforma, A.genero, A.pegi, A.coleccionista, 
                            A.seminuevo, A.retro, A.digital, A.front, A.precio, A.stock)   
    BULK COLLECT INTO resultado
    FROM 
        (
          SELECT  J.idJuego, J.nombre, J.plataforma, J.genero, J.pegi, J.esEdicionColeccionista coleccionista, J.esSeminuevo seminuevo,
                  J.esRetro retro, J.esDigital digital, R2.front, R2.precio *getMargenBeneficios precio, getStockJuego(R2.idJuego) stock
          FROM Juegos J INNER JOIN (  
                                        --Obtener ademas el front y filtrar por el nombre
                                        SELECT R.idJuego, R.fechaPedido, R.precio, M.front 
                                        FROM (
                                              --Obtener el ultimo precio de cada juego
                                              SELECT DISTINCT F.idJuego, F.fechaPedido, F.Precio
                                              FROM Facturas F
                                              WHERE F.fechaPedido = (
                                                                        --Obtener la ultima fecha de cada juego comprado
                                                                        SELECT MAX(F_.fechaPedido)
                                                                        FROM Facturas F_
                                                                        WHERE F_.idJuego = F.idJuego AND F_.idSocio = 0
                                                                    )
                                                                    AND F.idSocio = 0                                          
                                              ORDER BY F.fechaPedido DESC
                                              ) 
                                              R INNER JOIN Multimedia M ON M.idMultimedia = R.idJuego
                                                INNER JOIN Juegos J ON J.idJuego = M.idMultimedia
                                        WHERE J.nombre LIKE '%' || UPPER(nombre_) || '%'
                                      )
                                      R2 ON J.idJuego = R2.idJuego
          ) A;
   
   RETURN resultado;
   
END getBusquedaPorNombre;
/

CREATE OR REPLACE FUNCTION getBusquedaPorPlataforma(plataforma_ IN VARCHAR) RETURN JuegoBusquedaTabla AS
    tresDS CHAR(1);
    pc CHAR(1);
    ps4 CHAR(1);
    xbox CHAR(1);
    resultado JuegoBusquedaTabla;
BEGIN
    --La entrada son 4 bits, cada uno corresponde a una plataforma, el orden es tresDS, PC, PS4, Xbox
   
    --Obtengo las plataformas por las que filtrar
    tresDS := SUBSTR(plataforma_, 1, 1);
    pc := SUBSTR(plataforma_, 2, 1);
    ps4 := SUBSTR(plataforma_, 3, 1);
    xbox := SUBSTR(plataforma_, 4, 1);
     
   
    --Realizo la consulta y la guardo en la tabla
    SELECT JuegoBusquedaObj(A.idJuego, A.nombre, A.plataforma, A.genero, A.pegi, A.coleccionista, 
                            A.seminuevo, A.retro, A.digital, A.front, A.precio, A.stock)   
    BULK COLLECT INTO resultado
    FROM 
        (
          SELECT J.idJuego, J.nombre, J.plataforma, J.genero, J.pegi, J.esEdicionColeccionista coleccionista, J.esSeminuevo seminuevo, 
                 J.esRetro retro, J.esDigital digital, R2.front, R2.precio *getMargenBeneficios precio, getStockJuego(J.idJuego) stock
          FROM Juegos J INNER JOIN (  
                                        --Obtener ademas el front
                                        SELECT R.idJuego, R.fechaPedido, R.precio, M.front 
                                        FROM (
                                              --Obtener el ultimo precio de cada juego
                                              SELECT DISTINCT F.idJuego, F.fechaPedido, F.Precio
                                              FROM Facturas F
                                              WHERE F.fechaPedido = (
                                                                        --Obtener la ultima fecha de cada juego comprado
                                                                        SELECT MAX(F_.fechaPedido)
                                                                        FROM Facturas F_
                                                                        WHERE F_.idJuego = F.idJuego AND F_.idSocio = 0
                                                                    )
                                                                    AND F.idSocio = 0
                                              ORDER BY F.fechaPedido DESC
                                              ) 
                                              R INNER JOIN Multimedia M ON M.idMultimedia = R.idJuego
                                      )
                                      R2 ON J.idJuego = R2.idJuego
          --Aplicamos el filtro de las plataformas
          WHERE ( tresDS = '1' AND UPPER(J.plataforma) = UPPER('3DS') OR
                  pc = '1' AND UPPER(J.plataforma) = UPPER('PC') OR
                  ps4 = '1' AND UPPER(J.plataforma) = UPPER('PS4') OR
                  xbox = '1' AND UPPER(J.plataforma) = UPPER('Xbox'))
          ) A;
       
 
   RETURN resultado;
   
END getBusquedaPorPlataforma;
/

--La busqueda por genero
CREATE OR REPLACE FUNCTION getBusquedaPorGenero(genero_ IN VARCHAR, resultadoAnterior IN JuegoBusquedaTabla) RETURN JuegoBusquedaTabla AS
    accion CHAR(1);
    aventura CHAR(1);
    lucha CHAR(1);
    misc CHAR(1);
    plataformas CHAR(1);
    puzles CHAR(1);
    carreras CHAR(1);
    rpg CHAR(1);
    disparos CHAR(1);
    simulador CHAR(1);
    deportes CHAR(1);
    estrategia CHAR(1);
    resultado JuegoBusquedaTabla;
BEGIN
    --El filtro son bits que corresponden a la plataforma a filtrar, el orden es el de abajo

    --Obtengo las plataformas por las que filtrar
    accion := SUBSTR(genero_, 1, 1);
    aventura := SUBSTR(genero_, 2, 1);
    lucha := SUBSTR(genero_,3, 1);
    misc := SUBSTR(genero_, 4, 1);
    plataformas := SUBSTR(genero_, 5, 1);
    puzles := SUBSTR(genero_, 6, 1);
    carreras := SUBSTR(genero_, 7, 1);
    rpg := SUBSTR(genero_, 8, 1);
    disparos := SUBSTR(genero_, 9, 1);
    simulador := SUBSTR(genero_, 10, 1);
    deportes := SUBSTR(genero_, 11, 1);
    estrategia := SUBSTR(genero_, 12, 1);
    

    --Realizo la consulta y la guardo en la tabla
    SELECT JuegoBusquedaObj(A.idJuego, A.nombre, A.plataforma, A.genero, A.pegi, A.coleccionista, 
                            A.seminuevo, A.retro, A.digital, A.front, A.precio, A.stock)   
    BULK COLLECT INTO resultado
    FROM TABLE (resultadoAnterior) A
    WHERE ( accion = '1' AND UPPER(A.genero) = UPPER('Action') OR
            aventura = '1' AND UPPER(A.genero) = UPPER('Adventure') OR
            lucha = '1' AND UPPER(A.genero) = UPPER('Fighting') OR
            misc = '1' AND UPPER(A.genero) = UPPER('Misc') OR
            plataformas = '1' AND UPPER(A.genero) = UPPER('Platform') OR
            puzles = '1' AND UPPER(A.genero) = UPPER('Puzzle') OR
            carreras = '1' AND UPPER(A.genero) = UPPER('Racing') OR
            rpg = '1' AND UPPER(A.genero) = UPPER('Role-Playing') OR
            disparos = '1' AND UPPER(A.genero) = UPPER('Shooter') OR
            simulador = '1' AND UPPER(A.genero) = UPPER('Simulation') OR
            deportes = '1' AND UPPER(A.genero) = UPPER('Sports') OR
            estrategia = '1' AND UPPER(A.genero) = UPPER('Strategy'));

    RETURN resultado;

END getBusquedaPorGenero;
/

--La consulta con los where aplicados
CREATE OR REPLACE FUNCTION getBusquedaFiltrada( nombre_ IN VARCHAR, pegiInferior_ IN INT, pegiSuperior_ IN INT, 
                                                precioInferior IN FLOAT, precioSuperior IN FLOAT, atributos_ IN VARCHAR,
                                                resAnt IN JuegoBusquedaTabla) RETURN JuegoBusquedaTabla AS
    nombreAux VARCHAR(20) := nombre_;
    pegiInferiorAux INT := pegiInferior_;
    pegiSuperiorAux INT := pegiSuperior_;
    precioInferiorAux FLOAT := precioInferior;
    precioSuperiorAux FLOAT := precioSuperior;
    coleccionista_ CHAR(1);
    seminuevo_ CHAR(1);
    retro_ CHAR(1);
    digital_ CHAR(1);
    resultado JuegoBusquedaTabla;
BEGIN    
    --Aplico los filtros y restricciones al precio, pegi y los atributos que me interesen

      --Veo si hay que buscar por un nombre
    IF (nombre_ = NULL) THEN    
        nombreAux := '';
    END IF;
        
    --Veo si hay que filtrar por pegi
    IF (pegiInferior_ = 0.0 AND pegiSuperior_ = 0.0) THEN    
        pegiInferiorAux := 0;
        pegiSuperiorAux := 99;
    END IF;

    --Veo si hay que filtrar por precio
    IF (precioInferior = 0 AND precioSuperior = 0) THEN
        precioInferiorAux := 0.0;
        precioSuperiorAux := 99999999.99;
    END IF;
    
    --Obtengo los atributos por los que filtrar
    coleccionista_ := SUBSTR(atributos_, 1, 1);
    seminuevo_ := SUBSTR(atributos_, 2, 1);
    retro_ := SUBSTR(atributos_,3, 1);
    digital_ := SUBSTR(atributos_, 4, 1);
  
    --Obtengo las plataformas y generos ya filtados y hago la nueva consulta
    SELECT JuegoBusquedaObj(A.idJuego, A.nombre, A.plataforma, A.genero, A.pegi, A.coleccionista, 
                            A.seminuevo, A.retro, A.digital, A.front, A.precio, A.stock) 
    BULK COLLECT INTO resultado
    FROM TABLE(resAnt) A
    WHERE (
            --El nombre
            (A.nombre LIKE '%' || UPPER(nombreAux) || '%' ) AND
            --Pegi
            (A.pegi >= pegiInferiorAux AND A.pegi <= pegiSuperiorAux) AND
            --Precio
            (A.precio >= precioInferiorAux AND A.precio <= precioSuperiorAux) AND
            --Si es coleccionista
            (A.coleccionista = coleccionista_) AND
            --Si es seminuevo
            (A.seminuevo = seminuevo_) AND
            --Si es retro
            (A.retro = retro_) AND
            --Si es digital
            (A.digital = digital_)
        );

    RETURN resultado;

END getBusquedaFiltrada;
/

--La consulta ordenada
CREATE OR REPLACE FUNCTION getBusquedaOrdenada(ascSoN IN CHAR, orderBy IN VARCHAR, resAnt IN JuegoBusquedaTabla) RETURN JuegoBusquedaTabla AS
    resultado JuegoBusquedaTabla;
BEGIN    
    --Ordena la consulta, es 1 hot, cada bit representa un orden, nombre, pegi, precio, plataforma, genero y ascSoN = Y

    --Veo cual es el orden
    IF (ascSoN = 'Y') THEN
    
          --Realizo la consulta y la guardo en la tabla
          SELECT JuegoBusquedaObj(A.idJuego, A.nombre, A.plataforma, A.genero, A.pegi, A.coleccionista, 
                                  A.seminuevo, A.retro, A.digital, A.front, A.precio, A.stock)   
          BULK COLLECT INTO resultado
          FROM TABLE (resAnt) A
          ORDER BY 
              --Veo porque se ordena
              DECODE(orderBy, '10000', A.Nombre) ASC,
              DECODE(orderBy, '01000', A.pegi) ASC,
              DECODE(orderBy, '00100', A.precio) ASC,
              DECODE(orderBy, '00010', A.plataforma) ASC,
              DECODE(orderBy, '00001', A.genero) ASC;
                
      ELSE
      --Realizo la consulta y la guardo en la tabla
          SELECT JuegoBusquedaObj(A.idJuego, A.nombre, A.plataforma, A.genero, A.pegi, A.coleccionista, 
                                  A.seminuevo, A.retro, A.digital, A.front, A.precio, A.stock)   
          BULK COLLECT INTO resultado
          FROM TABLE (resAnt) A
          ORDER BY 
                      --Veo porque se ordena
                      DECODE(orderBy, '10000', A.Nombre) DESC,
                      DECODE(orderBy, '01000', A.pegi) DESC,
                      DECODE(orderBy, '00100', A.precio) DESC,
                      DECODE(orderBy, '00010', A.plataforma) DESC,
                      DECODE(orderBy, '00001', A.genero) DESC;      
      
      END IF;

    RETURN resultado;

END getBusquedaOrdenada;
/

--La funcion de busqueda general  
CREATE OR REPLACE FUNCTION getResultadoBusqueda(nombre_ IN VARCHAR, pegiInferior_ IN INT, pegiSuperior_ IN INT, 
                                                precioInferior IN FLOAT, precioSuperior IN FLOAT, atributos_ IN VARCHAR,
                                                genero_ IN VARCHAR, plataforma_ IN VARCHAR, ascSoN IN CHAR,
                                                orderBy IN VARCHAR) RETURN JuegoBusquedaTabla AS
    resultado JuegoBusquedaTabla;
BEGIN
    --La consulta general que unifica todas las demas

    SELECT JuegoBusquedaObj(A.idJuego, A.nombre, A.plataforma, A.genero, A.pegi, A.coleccionista, 
                            A.seminuevo, A.retro, A.digital, A.front, A.precio, A.stock)
    BULK COLLECT INTO resultado
    FROM TABLE (
        getBusquedaOrdenada(ascSoN, orderBy, (
            getBusquedaFiltrada(nombre_, pegiInferior_, pegiSuperior_, precioInferior, precioSuperior, atributos_, (
                getBusquedaPorGenero(genero_, 
                    getBusquedaPorPlataforma(plataforma_))))))) A;          
    
    RETURN resultado;

END getResultadoBusqueda;
/




----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
------------------------TRIGGERS--------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------


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
    
      
      
      
      
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
--------------------------DATOS---------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
    
    
INSERT INTO Personas VALUES (0, 'Nosotros', ' ', ' ', 41500, '12345678z', 'gamesystem@gamesystem.shop','Y');
INSERT INTO Personas VALUES (1, 'Chuck', 'Norris', 'Texas', 00001, '12345678z', 'walker@gamesystem.shop','Y');
INSERT INTO Personas VALUES (2, 'Alana', 'del Mar', 'Valencia', 24645, '12345678z', 'alana@gamesystem.shop','Y');
INSERT INTO Personas VALUES (3, 'Francisco', 'Tobar', 'Malaga', 20739, '12345678z', 'fran@gamesystem.shop','Y');
INSERT INTO Personas VALUES (4, 'Azucena', 'Garcia', 'Madrid', 45795, '12345678z', 'azu@gamesystem.shop','Y');
INSERT INTO Personas VALUES (5, 'Lucia', 'Frau', 'Granada', 98745, '12345678z', 'frau@gamesystem.shop','Y');
INSERT INTO Personas VALUES (6, 'Paco', 'Martinez', 'Murcia', 65415, '12345678z', 'paco@gamesystem.shop','Y');
INSERT INTO Personas VALUES (7, 'Alex', 'Caparros', 'Tarragona', 74124, '12345678z', 'alex@gamesystem.shop','Y');
INSERT INTO Personas VALUES (8, 'Carmen', 'Guzman', 'Badajoz', 32454, '12345678z', 'carmen@gamesystem.shop','Y');
INSERT INTO Personas VALUES (9, 'Martina', 'Olivera', 'Salamanca', 95145, '12345678z', 'martina@gamesystem.shop','Y');
INSERT INTO Personas VALUES (10, 'Carlos', 'Matamoros', 'Cordoba', 51244, '12345678z', 'carlos@gamesystem.shop','Y');


INSERT INTO Socios VALUES (0, 0, 'N');
INSERT INTO Socios VALUES (1, 1000, 'Y');
INSERT INTO Socios VALUES (2, 1500, 'N');
INSERT INTO Socios VALUES (3, 2000, 'N');
INSERT INTO Socios VALUES (4, 3500, 'N');

INSERT INTO Login VALUES (0, 'admin', '****');
INSERT INTO Login VALUES (1, 'walker', '*****');
INSERT INTO Login VALUES (2, 'alana', '*****');
INSERT INTO Login VALUES (3, 'fran', '****');
INSERT INTO Login VALUES (4, 'lucia', '*****');

--5 juegos
INSERT INTO Juegos VALUES (1, 'Deus Ex', 'PC', 'Action', 'Descripcion', 13, 'Y', 'N', 'Y', 'N');
INSERT INTO Juegos VALUES (2, 'Dota 2', 'PC', 'Strategy', 'Descripcion', 7, 'N', 'N', 'N', 'Y');
INSERT INTO Juegos VALUES (3, 'GTA5', 'PS4', 'Action', 'Descripcion', 18, 'N', 'N', 'N', 'N');
INSERT INTO Juegos VALUES (4, 'Ark', 'PC', 'Simulation', 'Descripcion', 16, 'N', 'N', 'N', 'Y');
INSERT INTO Juegos VALUES (5, 'Rocket League', 'Xbox', 'Racing', 'Descripcion', 3, 'N', 'N', 'N', 'Y');

--Los proveedores
INSERT INTO Proveedores VALUES (-1,'Steam', 'steam@steam.com', 'A1234567A');
INSERT INTO Proveedores VALUES (-2,'Game', 'game@game.es', 'B0123456B');

--El inventario de los proveedores
INSERT INTO Inventario VALUES (1, 1, 100, 3.95);
INSERT INTO Inventario VALUES (2, 3, 75, 30.95);
INSERT INTO Inventario VALUES (3, 5, 88, 6.95);
INSERT INTO Inventario VALUES (4, 1, 46, 4.95);
INSERT INTO Inventario VALUES (5, 2, 29, 7.95);
INSERT INTO Inventario VALUES (6, 3, 82, 23.95);
INSERT INTO Inventario VALUES (7, 4, 115, 18.95);

INSERT INTO InventarioProveedores VALUES (1, -1, 1);
INSERT INTO InventarioProveedores VALUES (2, -1, 2);
INSERT INTO InventarioProveedores VALUES (3, -1, 3);
INSERT INTO InventarioProveedores VALUES (4, -2, 4);
INSERT INTO InventarioProveedores VALUES (5, -2, 5);
INSERT INTO InventarioProveedores VALUES (6, -2, 6);
INSERT INTO InventarioProveedores VALUES (7, -2, 7);

--Nuestras compras para obtener el stock de los juegos
INSERT INTO Facturas VALUES (0, 0, 1, 5, 4.95, sysdate-5, sysdate-4);
INSERT INTO Facturas VALUES (1, 0, 2, 10, 9.95, sysdate-5, sysdate-2);
INSERT INTO Facturas VALUES (2, 0, 3, 15, 39.95, sysdate-5, sysdate-1);
INSERT INTO Facturas VALUES (3, 0, 4, 12, 29.95, sysdate-5, sysdate+1);
INSERT INTO Facturas VALUES (4, 0, 5, 8, 19.95, sysdate-5, sysdate);
INSERT INTO Facturas VALUES (5, 0, 5, 8, 19.95, sysdate-5, TO_DATE('2100-01-01', 'YYYY-MM-DD'));
INSERT INTO Facturas VALUES (6, 0, 3, 8, 19.95, sysdate, TO_DATE('2100-01-01', 'YYYY-MM-DD'));
INSERT INTO Facturas VALUES (7, 0, 2, 8, 19.95, sysdate-2, TO_DATE('2100-01-01', 'YYYY-MM-DD'));

--Formalizo la compra con el proveedor
INSERT INTO PedidosProveedor VALUES (1, 0, -1, 'Y');
INSERT INTO PedidosProveedor VALUES (2, 1, -2, 'Y');
INSERT INTO PedidosProveedor VALUES (3, 2, -1, 'Y');
INSERT INTO PedidosProveedor VALUES (4, 3, -2, 'Y');
INSERT INTO PedidosProveedor VALUES (5, 4, -1, 'Y');
INSERT INTO PedidosProveedor VALUES (6, 5, -1, 'N');
INSERT INTO PedidosProveedor VALUES (7, 6, -1, 'N');
INSERT INTO PedidosProveedor VALUES (8, 7, -2, 'N');


--Las transacciones de los socios
INSERT INTO Facturas VALUES (8, 2, 2, 3, 15.08, sysdate, sysdate+10);
INSERT INTO Facturas VALUES (9, 1, 3, 2, 9.94, sysdate, sysdate+12);
INSERT INTO Facturas VALUES (10, 1, 1, 2, 11.28, sysdate, sysdate+13);
INSERT INTO Facturas VALUES (11, 3, 3, 1, 18.18, sysdate, sysdate+15);
INSERT INTO Facturas VALUES (12, 4, 1, 2, 14.82, sysdate, sysdate+13);
INSERT INTO Facturas VALUES (13, 1, 2, 3, 19.64, sysdate, sysdate+12);
INSERT INTO Facturas VALUES (14, 2, 1, 2, 14.42, sysdate, sysdate+11);
INSERT INTO Facturas VALUES (15, 2, 4, 1, 15.48, sysdate, sysdate+17);
INSERT INTO Facturas VALUES (16, 3, 3, 2, 19.04, sysdate, sysdate+16);
INSERT INTO Facturas VALUES (17, 4, 5, 3, 17.36, sysdate, sysdate+15);

INSERT INTO Facturas VALUES (18, 2, 3, 1, 4.82, sysdate-77, sysdate);
INSERT INTO Facturas VALUES (19, 1, 5, 1, 5.52, sysdate-52, sysdate);
INSERT INTO Facturas VALUES (20, 4, 1, 1, 4.74, sysdate-32, sysdate);
INSERT INTO Facturas VALUES (21, 2, 5, 1, 2.64, sysdate-49, sysdate);
INSERT INTO Facturas VALUES (22, 4, 1, 1, 3.76, sysdate-1, sysdate);

INSERT INTO Facturas VALUES (23, 1, 4, 1, 2.50, sysdate-77, sysdate-76);
INSERT INTO Facturas VALUES (24, 4, 3, 1, 3.00, sysdate-40, sysdate-39);
INSERT INTO Facturas VALUES (25, 1, 4, 1, 2.00, sysdate, sysdate+10);
INSERT INTO Facturas VALUES (26, 1, 5, 1, 2.00, sysdate, TO_DATE('2100-01-01', 'YYYY-MM-DD'));


INSERT INTO Compras VALUES (1, 8, 'N');
INSERT INTO Compras VALUES (2, 9, 'Y');
INSERT INTO Compras VALUES (3, 10, 'Y');
INSERT INTO Compras VALUES (4, 11, 'N');
INSERT INTO Compras VALUES (5, 12, 'N');
INSERT INTO Compras VALUES (6, 13, 'N');
INSERT INTO Compras VALUES (7, 14, 'Y');
INSERT INTO Compras VALUES (8, 15, 'N');
INSERT INTO Compras VALUES (9, 16, 'Y');
INSERT INTO Compras VALUES (10, 17, 'Y');

INSERT INTO Ventas VALUES (1, 18, 'Buen estado');
INSERT INTO Ventas VALUES (2, 19, 'Con manual aunque el disco esta dañado');
INSERT INTO Ventas VALUES (3, 20, 'Sin abrir, impecable');
INSERT INTO Ventas VALUES (4, 21, 'Id online baneada');
INSERT INTO Ventas VALUES (5, 22, 'En japones');

INSERT INTO Alquileres VALUES (1, 23, 1);
INSERT INTO Alquileres VALUES (2, 24, 3);
INSERT INTO Alquileres VALUES (3, 25, 2);
INSERT INTO Alquileres VALUES (4, 26, 2);


--Completamos los juegos
INSERT INTO Multimedia VALUES (1, 'Y', 'Y', '');
INSERT INTO Multimedia VALUES (2, 'Y', 'N', '');
INSERT INTO Multimedia VALUES (3, 'Y', 'Y', '');
INSERT INTO Multimedia VALUES (4, 'Y', 'N', '');
INSERT INTO Multimedia VALUES (5, 'N', 'Y', '');

INSERT INTO Fotos VALUES (1, 1, '1.jpg');
INSERT INTO Fotos VALUES (2, 1, '2.jpg');
INSERT INTO Fotos VALUES (3, 2, '1.jpg');
INSERT INTO Fotos VALUES (4, 2, '2.jpg');
INSERT INTO Fotos VALUES (5, 2, '3.jpg');
INSERT INTO Fotos VALUES (6, 3, '1.jpg');
INSERT INTO Fotos VALUES (7, 3, '2.jpg');
INSERT INTO Fotos VALUES (8, 4, '1.jpg');
INSERT INTO Fotos VALUES (9, 4, '2.jpg');
INSERT INTO Fotos VALUES (10, 5, '1.jpg');
INSERT INTO Fotos VALUES (11, 5, '2.jpg');
INSERT INTO Fotos VALUES (12, 5, '3.jpg');
INSERT INTO Fotos VALUES (13, 5, '4.jpg');
INSERT INTO Fotos VALUES (14, 5, '5.jpg');
INSERT INTO Fotos VALUES (15, 5, '6.jpg');
INSERT INTO Fotos VALUES (16, 5, '7.jpg');

--Actualizamos las secuencias hasta donde deban estar para no insertar claves primarias duplicadas
DECLARE
    maxIdAlquiler INT;
    maxIdCompra INT;
    maxIdFactura INT;
    maxIdFotoId INT;
    maxIdInventario INT;
    maxIdInventarioProveedor INT;
    maxIdJuego INT;
    maxIdPedidoProveedor INT;
    maxIdPersona INT;
    maxIdProveedor INT;
    maxIdVenta INT;
    aux INT;
BEGIN

    SELECT MAX(idAlquiler) INTO maxIdAlquiler FROM Alquileres;
    SELECT MAX(idCompra) INTO maxIdCompra FROM Compras;
    SELECT MAX(idFactura) INTO maxIdFactura FROM Facturas;
    SELECT MAX(idFoto) INTO maxIdFotoId FROM Fotos;
    SELECT MAX(idInventario) INTO maxIdInventario FROM Inventario;
    SELECT MAX(idInventarioProveedores) INTO maxIdInventarioProveedor FROM InventarioProveedores;
    SELECT MAX(idJuego) INTO maxIdJuego FROM Juegos;
    SELECT MAX(idPedidoProveedor) INTO maxIdPedidoProveedor FROM PedidosProveedor;
    SELECT MAX(idPersona) INTO maxIdPersona FROM Personas;
    SELECT MAX(idProveedor) INTO maxIdProveedor FROM Proveedores;
    SELECT MAX(idVenta) INTO maxIdVenta FROM Ventas;
    
    FOR indice IN 0..maxIdAlquiler LOOP aux := getAlquilerId.NEXTVAL; END LOOP;    
    FOR indice IN 0..maxIdCompra LOOP aux := getCompraId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdFactura LOOP aux := getFacturaId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdFotoId LOOP aux := getFotoId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdInventario LOOP aux := getInventarioId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdInventarioProveedor LOOP aux := getInventarioProveedorId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdJuego LOOP aux := getJuegoId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdPedidoProveedor LOOP aux := getPedidoProveedorId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdPersona LOOP aux := getPersonaId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdProveedor LOOP aux := getProveedorId.NEXTVAL; END LOOP;
    FOR indice IN 0..maxIdVenta LOOP aux := getVentaId.NEXTVAL; END LOOP;

END;