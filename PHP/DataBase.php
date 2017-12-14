<?php

require_once 'MagicConstants.php';

/**
 * Get the data for the slider from the database, name, price, 4 photos, front and all that stuff to make the slider
 */
function getDataToSlider()
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $select = oci_parse($connection, 'SELECT * FROM TABLE (getJuegosParaElSlider('.getSliderNumberOfGames().'))');
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getDataToTopNewGames()
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $select = oci_parse($connection, 'SELECT * FROM TABLE (getTopJuegosNuevos('.getNumberOfTopNewGames().'))');
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getDataToTopFutureGames()
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $select = oci_parse($connection, 'SELECT * FROM TABLE (getTopNuevosLanzamientos('.getNumberOfTopFutureGames().'))');
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getDataToQuickSearchGames($searchStringBD)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $aux = 'SELECT * FROM TABLE (getBusquedaPorNombre(\''.$searchStringBD.'\'))';
        $select = oci_parse($connection, $aux);
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getGameData1($id)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        $query = 'SELECT * FROM Juegos J INNER JOIN Multimedia M ON M.idMultimedia = J.idJuego WHERE J.idJuego=:id';
        // Parse the select
        $select = oci_parse($connection, $query);
        oci_bind_by_name($select, ':id', $id);
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getGameData2($id)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $select = oci_parse($connection, 'SELECT Nombre FROM Fotos WHERE idMultimedia ='.$id);
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getGameStock($id)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        $query = 'SELECT getStockJuego(:id) STOCK FROM Dual';
        // Parse the select
        $select = oci_parse($connection, $query);
        oci_bind_by_name($select, ':id', $id);
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getGamePrice($id)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        $query = 'SELECT getPrecio(:id) PRICE FROM Dual';
        // Parse the select
        $select = oci_parse($connection, $query);
        oci_bind_by_name($select, ':id', $id);
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getCountMails($mail)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $select = oci_parse($connection, 'SELECT COUNT(*) COUNT FROM Personas WHERE mail = \''.$mail.'\'');
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function setUser($name, $lastName, $address, $cp, $dni, $mail, $login, $pass){
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        $points = getDefaultPoints();
        $pass = md5($pass);

        $select = "SELECT getPersonaId.NEXTVAL FROM Dual";

        $select = oci_parse($connection, $select);
        oci_execute($select);
        oci_fetch_all($select, $id);
        $id = $id['NEXTVAL'][0];

        $insert1 = "INSERT INTO Personas VALUES (".$id.",'".$name."' , '".$lastName."', '".$address."', ".$cp.", '".$dni."', '".$mail."', 'Y')";
        $insert2 = "INSERT INTO Socios VALUES (".$id.", ".$points.", 'N')";
        $insert3 = "INSERT INTO Login VALUES (".$id.", '".$login."', '".$pass."')";

        $insert1 = oci_parse($connection, $insert1);
        oci_execute($insert1);

        $insert2 = oci_parse($connection, $insert2);
        oci_execute($insert2);

        $insert3 = oci_parse($connection, $insert3);
        oci_execute($insert3);

        oci_close($connection);
    }
}

function getCorrectLogin($loginUser, $pass)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        $pass = md5($pass);
        $aux = "SELECT getAutentificarLogin('".$loginUser."', '".$pass."') res FROM Dual";
        // Parse the select
        $select = oci_parse($connection, $aux);
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getQueryResults($name, $pegiInferior, $pegisuperior, $priceInferior, $priceSuperior, $atributos, $genres, $platforms, $asc, $orderby)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        $aux = "SELECT * FROM TABLE(getResultadoBusqueda(".$name.", ".$pegiInferior.", ".$pegisuperior.", ".$priceInferior.", ".$priceSuperior.", ".$atributos;
        $aux = $aux.", ".$genres.", ".$platforms.", ".$asc.",".$orderby."))";
        // Parse the select
        $select = oci_parse($connection, $aux);
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getCountUsers($loginUser)
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $select = oci_parse($connection, 'SELECT COUNT(*) COUNT FROM Login WHERE usuario = \''.$loginUser.'\'');
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

/**
 * Get the data for the slider from the database, name, price, 4 photos, front and all that stuff to make the slider
 */
function getDataFromFunction()
{
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {

        // Parameters for the function
        $p = getSliderNumberOfGames();

        $select = oci_parse($connection, 'BEGIN :res := myfunc(:p); END;');
        oci_bind_by_name($select, ':p', $p);
        oci_bind_by_name($select, ':res', $res, 40);

        oci_execute($select);
        oci_free_statement($select);
        oci_close($connection);
    }
}

function getDataFromDatabase($query)
{
    //$connection = oci_connect("GAMESYSTEM", "GameSystem", 'localhost/XE');
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $select = oci_parse($connection, $query);
        // Do the select
        oci_execute($select);
        // Get the data
        oci_fetch_all($select, $res);
        // var_dump($res);
        // Close the connection
        oci_close($connection);
        return $res;
    }
}

function getDataFromDatabaseNoReturn($query)
{
    //$connection = oci_connect("GAMESYSTEM", "GameSystem", 'localhost/XE');
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {
        // Parse the select
        $select = oci_parse($connection, $query);
        // Do the select
        oci_execute($select);
        // Close the connection
        oci_close($connection);
    }
}

function setTransactions($idUser, $idGame, $price, $units, $op){
    $respuesta = 0;
    $connection = oci_connect(getDataBaseUser(), getDataBasePass(), getDataBaseHost());
    if (!$connection) {
        $m = oci_error();
        //echo $m['message'], "n";
    }
    else {

        // Get both ids
        $select1 = "SELECT getFacturaId.NEXTVAL FROM Dual";
        $selectCompra = "SELECT getCompraId.NEXTVAL FROM Dual";
        $selectVenta = "SELECT getVentaId.NEXTVAL FROM Dual";
        $selectAlquiler = "SELECT getAlquilerId.NEXTVAL FROM Dual";

        $idFactura = getDataFromDatabase($select1);
        $idFactura = $idFactura['NEXTVAL'][0];

        $idTransactcion = 0;
        $insertInto = "";

        // It is a compra
        if($op == 1){
            $idTransactcion = getDataFromDatabase($selectCompra);
            $idTransactcion = $idTransactcion['NEXTVAL'][0];
            $insertInto = "INSERT INTO Compras VALUES (".$idTransactcion.", ".$idFactura.", 'Y')";
        }
        else if($op == 2){
            $idTransactcion = getDataFromDatabase($selectVenta);
            $idTransactcion = $idTransactcion['NEXTVAL'][0];
            $insertInto = "INSERT INTO Ventas VALUES (".$idTransactcion.", ".$idFactura.", 'Sin descripcion del estado')";
        }
        else if($op == 3){
            $idTransactcion = getDataFromDatabase($selectAlquiler);
            $idTransactcion = $idTransactcion['NEXTVAL'][0];
            $insertInto = "INSERT INTO Alquileres VALUES (".$idTransactcion.", ".$idFactura.", 1)";
        }

        $insertFactura = "INSERT INTO Facturas VALUES (".$idFactura.", ".$idUser.", ".$idGame.", ".$units.", ".$price;
        $insertFactura = $insertFactura.", sysdate, sysdate)";

        $insertFactura = oci_parse($connection, $insertFactura);
        oci_execute($insertFactura);
        $error = oci_error($insertFactura);

        // If there are no error we do the other insert
        if(!$error){

            $insertInto = oci_parse($connection, $insertInto);
            oci_execute($insertInto);
            $error2 = oci_error($insertInto);

            if(!$error2){
                $respuesta = 1;
            }
        }

        oci_close($connection);

        return $respuesta;
    }

}