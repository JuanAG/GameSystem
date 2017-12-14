<?php

error_reporting(0);

require_once 'PHP/MagicConstants.php';
require_once 'PHP/DataBase.php';
require 'PHP/checks.php';

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

return checkForm();

function checkForm()
{
    $login = $_POST['login'];
    $pass = $_POST['pass'];
    $remenberMe = $_POST['remenberMe'];

    $answer = "<div id=\"formInfoInt\" class=\"formErrors hide\">";
    $failed = 0;

    if (isset($_POST['login'])) {
        $login = $_POST['login'];
        if ($login == "") {
            $error = formEl . formLogin . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkLoginValid2($login);
            if ($error != "ok") {
                $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
                $failed = 1;
            }
        }
    }

    if (isset($_POST['pass'])) {
        $pass = $_POST['pass'];
        if ($pass == "") {
            $error = formLa . formPass . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkPassValid($pass);
            if ($error != "ok") {
                $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
                $failed = 1;
            }
        }
    }

    $answer = $answer . "<div>";

    if($failed == 0){
        $answer = $answer."<p>";
    }

    echo $answer;

    return 0;
}

?>