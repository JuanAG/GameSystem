<?php

function getClientLanguage()
{
// Get the proper language for the client
    $language = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
    switch ($language) {
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
}

