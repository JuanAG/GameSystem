<?php

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

return checkForm2();

function checkForm2()
{

    $name = $_POST['name'];
    $lastName = $_POST['lastName'];
    $address = $_POST['address'];
    $cp = $_POST['cp'];
    $dni = $_POST['dni'];
    $mail = $_POST['mail'];
    $login = $_POST['login'];
    $pass = $_POST['pass'];
    $remenberMe = $_POST['remenberMe'];

    $answer = "<div id=\"formInfoInt\" class=\"formErrors hide\">";
    $failed = 0;
    if (isset($_POST['name'])) {
        $name = $_POST['name'];
        if ($name == "") {
            $error = formEl . formName . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkNameValid($name);
            if ($error != "ok") {
                $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
                $failed = 1;
            }
        }
    }

    if (isset($_POST['lastName'])) {
        $lastName = $_POST['lastName'];
        if ($lastName == "") {
            $error = formEl . formLastName . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkLastNameValid($lastName);
            if ($error != "ok") {
                $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
                $failed = 1;
            }
        }
    }

    if (isset($_POST['address'])) {
        $address = $_POST['address'];
        if ($address == "") {
            $error = formLa . formAddress . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkAddressValid($address);
            if ($error != "ok") {
                $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
                $failed = 1;
            }
        }
    }

    if (isset($_POST['cp'])) {
        $cp = $_POST['cp'];
        if ($cp == "") {
            $error = formEl . formCP . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkCPValid($cp);
            if ($error != "ok") {
                $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
                $failed = 1;
            }
        }
    }

    if (isset($_POST['dni'])) {
        $dni = $_POST['dni'];
        if ($dni == "") {
            $error = formEl . formDNI . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkDNIValid($dni);
            if ($error != "ok") {
                $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
                $failed = 1;
            }
        }
    }

    if (isset($_POST['mail'])) {
        $mail = $_POST['mail'];
        if ($mail == "") {
            $error = formEl . formMail . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkMailValid($mail);
            if ($error != "ok") {
                $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
                $failed = 1;
            }
        }
    }

    if (isset($_POST['login'])) {
        $login = $_POST['login'];
        if ($login == "") {
            $error = formEl . formLogin . formCantBeEmpty;
            $answer = $answer . "<div class=\"formElementError\">" . $error . "</div>";
            $failed = 1;
        } else {
            $error = checkLoginValid($login);
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

    if ($failed == 0) {
        $answer = $answer . "<p>" . formRegisterThanks . "</p>";
    }

    $answer = $answer . "<div>";

    echo $answer;

    return 0;
}

?>