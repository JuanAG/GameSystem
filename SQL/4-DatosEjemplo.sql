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