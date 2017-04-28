<?php

header('Content-Type: text/html; charset=utf-8');

include 'PHP/AuxFunctions.php';

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

?>

<!DOCTYPE html>

<?php /*getCookieLogin($user, $pass);*/?>

<html>
    <head>
        <title>
            <?php echo GameSystemTitleHome; ?>
        </title>
        <link rel="icon" type="image/png" href="/Images/favicon16.png" sizes="16x16" />
        <link rel="icon" type="image/png" href="/Images/favicon32.png" sizes="32x32" />
        <link rel="stylesheet" type="text/css" href="CSS/main.css">
    </head>
    <body>
        <div id="header" class="fullWidth">
        <ul id="menu" class="">
            <li>
                <a href="search.php?plataform=pc">
                    <img id="pcIcon" class="" src="/Images/Icons/pcIcon.png" />
                    <span>
                        <?php echo PC; ?>
                    </span>
                </a>
            </li>
            <li>
                <a href="search.php?plataform=3ds">
                    <img id="3dsIcon" class="" src="/Images/Icons/3dsIcon.png" />
                    <span>
                        <?php echo DS; ?>
                    </span>
                </a>
            </li>
            <li>
                <a href="search.php?plataform=ps4">
                    <img id="`s4Icon" class="" src="/Images/Icons/psIcon.png" />
                    <span>
                        <?php echo PS4; ?>
                    </span>
                </a>
            </li>
            <li>
                <a href="search.php?plataform=xbox">
                    <img id="xboxIcon" class="" src="/Images/Icons/xboxIcon.png" />
                    <span>
                        <?php echo XboxOne; ?>
                    </span>
                </a>
            </li>
        </ul>
        </div>
    </body>
</html>