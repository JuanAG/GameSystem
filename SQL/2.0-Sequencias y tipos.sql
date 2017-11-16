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