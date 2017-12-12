<?php

header('Content-Type: text/html; charset=utf-8');

// Get the proper language for the client
$language = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
switch ($language){
    case "es": // Spanish
        include("Locale/Spanish.php");
        break;
    case "en": //English
        include("Locale/English.php");
        break;
    default: // It will be english for default
        include("Locale/English.php");
        break;
}

echo CheckingConnection;
echo '<br/>';
echo '<br/>';

// Create connection to Oracle
$conn = oci_connect("GAMESYSTEM", "GameSystem", 'localhost/XE');

if (!$conn) {
    $m = oci_error();
    echo $m['message'], "n";
    exit;
} else {
    echo ConnectionSuccessful; }

// Close the Oracle connection
oci_close($conn); ?>