<!DOCTYPE html>

<html>
    <head>
        <title>
            <?php echo "Modificaciones y borrados de la base de datos" ?>
        </title>
        <link rel="stylesheet" type="text/css" href="CSS/extra.css">
    </head>
    <body>

<?php

error_reporting(0);

require 'PHP/DataBase.php';

    // Do the sql thing

    if(isset($_POST['mod'])){
        $idModificar = $_POST['mod'];
        $nuevoNombre = $_POST['nuevoNombre'];

        getDataFromDatabaseNoReturn("UPDATE Juegos SET Nombre = '".$nuevoNombre."' WHERE idJuego = ".$idModificar);
    }

    if(isset($_POST['borrar'])){
        $idBorrar = $_POST['borrar'];

        getDataFromDatabaseNoReturn("DELETE FROM Compras WHERE idCompra = ".$idBorrar);
    }

    $answer = "<div>";

        $answer = $answer."<p>Modificacion nombre del juego</p>";

        $answer = $answer."<table class=\"datos\" >";

            $datos = getDataFromDatabase("SELECT * FROM  Juegos ORDER BY idJuego ASC");

            $answer = $answer."<tr>";
                $answer = $answer."<th>idJuego</th>";
                $answer = $answer."<th>Nombre</th>";
                $answer = $answer."<th>Plataforma</th>";
            $answer = $answer."</tr>";

            for($i = 0; $i < 5; $i++){
                $id = $datos['IDJUEGO'][$i];
                $nombre = $datos['NOMBRE'][$i];
                $answer = $answer."<form method=\"post\" action=\"extra.php\">";
                    $answer = $answer."<tr>";
                        $answer = $answer."<td>".$id."</td>";
                        $answer = $answer."<td><input type=\"text\" class=\"expand\" name=\"nuevoNombre\" value=\"".$nombre."\"></td>";
                        $answer = $answer."<td>".$datos['PLATAFORMA'][$i]."</td>";
                        $answer = $answer."<td><button type=\"submit\" class=\"linkButton\" name=\"mod\" value=\"".$id."\" >Modificar</button></td>";
                    $answer = $answer."</tr>";
                $answer = $answer."</form>";
            }

        $answer = $answer."</table>";

    $answer = $answer."</div>";

    echo $answer;



    $answer2 = "<div id=\"borrarTransaccion\">";

        $answer2 = $answer2."<p>Borrar compras</p>";

        $datos = getDataFromDatabase("SELECT * FROM Compras ORDER BY idCompra DESC");

        $answer2 = $answer2."<table class=\"datos\" >";

            $answer2 = $answer2."<tr>";
                $answer2 = $answer2."<th>idCompra</th>";
                $answer2 = $answer2."<th>idFactura</th>";
            $answer2 = $answer2."</tr>";

            for($i = 0; $i < 5; $i++){
                $id = $datos['IDCOMPRA'][$i];
                $answer2 = $answer2."<form method=\"post\" action=\"extra.php\">";
                    $answer2 = $answer2."<tr>";
                        $answer2 = $answer2."<td>".$id."</td>";
                        $answer2 = $answer2."<td>".$datos['IDFACTURACOMPRA'][$i]."</td>";
                        $answer2 = $answer2."<td><button type=\"submit\" class=\"linkButton\" name=\"borrar\" value=\"".$id."\" >Borrar</button></td>";
                    $answer2 = $answer2."</tr>";
                $answer2 = $answer2."</form>";
            }

         $answer2 = $answer2."</table>";

    $answer2 = $answer2."</form>";

    echo $answer2;

?>

    </body>
</html>
