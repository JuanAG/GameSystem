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