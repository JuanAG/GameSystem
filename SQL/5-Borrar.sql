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