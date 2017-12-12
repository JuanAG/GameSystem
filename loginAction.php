<?php

require_once 'PHP/DataBase.php';

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

if(isset($_POST['login']) && $_POST['login'] != null) {

        // After all the checks if they are ok we set the cookie
        $res = getCorrectLogin($_POST['login'], $_POST['pass']);

        if($res['RES'][0] == $_POST['login']."1"){

            // Cookies Remenber me
            if(isset($_POST['remenberMe'])){
                setcookie("loginUser", $_POST['login'], time()+getCookieTime(), '/');
            }
            else{
                setcookie("loginUser", $_POST['login'], null, '/');
            }

            echo formLoginThanks;

        }
        else if(getCountUsers($_POST['login']) != 0){
            echo "<p class='error'>".formInvalidLogin."</p>";
        }
        else {
            echo "<p class='error'>".formLoginUserNotExist."</p>";
        }

    }

   return 0;