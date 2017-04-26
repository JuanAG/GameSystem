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

?>

<!DOCTYPE html>
<html>
    <head>
        <title>
            <?php echo Error404Title;?>
        </title>
        <link rel="icon" type="image/png" href="/Images/favicon16.png" sizes="16x16" />
        <link rel="icon" type="image/png" href="/Images/favicon32.png" sizes="32x32" />
        <link rel="stylesheet" type="text/css" href="CSS/error.css">
    </head>
    <body>
        <div id="errorPage" class="matrix">
            <div id="emptyForCenter" class="midCenter">
                <div id="backgroundImage" class=""></div>
                <div id="textError" class="errorContentText">
                    <h2>
                        <?php echo PageNotFound;?>
                    </h2>
                    <p>
                        <?php echo Error404Description;?>
                    </p>
                    <a href="/">
                        <?php
                            echo Error404Message;
                        ?>
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>