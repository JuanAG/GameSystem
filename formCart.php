<?php

session_start();

if(isset($_POST['quantity']) && isset($_POST['buy'])){
    $_SESSION['Compras'][] = $_POST['id'];
    $_SESSION['ComprasCantidad'][] = $_POST['quantity'];
}

if(isset($_POST['quantity']) && isset($_POST['sell'])){
    $_SESSION['Ventas'][] = $_POST['id'];
    $_SESSION['SellCantidad'][] = $_POST['quantity'];
}

if(isset($_POST['quantity']) && isset($_POST['rent'])){
    $_SESSION['Rents'][] = $_POST['id'];
    $_SESSION['RentsCantidad'][] = $_POST['quantity'];
}

// Only check the data received, make the jQuery Ajax call