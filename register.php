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

//include 'myfile.php';
?>

<html>
    <head>
        <title>
            <?php echo GameSystemTitleRegister ?>
        </title>
    </head>
    <body>
        <form action="register.php" method="post">
            <p>Name: <input type="text" name="name" /></p>
            <p>Mail: <input type="text" name="mail" /></p>
            <p><input type="submit" /></p>
        </form>
        <?php
            echo htmlspecialchars($_POST['name']);
            echo '<br/>';
            echo $_POST['mail'];
            echo '<br/>';
        ?>
    </body>
</html>