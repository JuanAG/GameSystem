<?php

/**
 *
 */
function getClientLanguage()
{
// Get the proper language for the client
    $language = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
    switch ($language) {
        case "es": // Spanish
            include("../Locale/Spanish.php");
            break;
        case "en": //English
            include("../Locale/English.php");
            break;
        default: // It will be english for default
            include("../Locale/English.php");
            break;
    }
}

/**
 * @param $user
 * @param $pass
 */
function getCookieLogin($user, $pass)
{
    if (isset($_COOKIE['userName']) && isset($_COOKIE['passWord'])) {

        if (($_POST['userName'] != $user) || ($_POST['passWord'] != md5($pass))) {
            //header('Location: login.php');
        } else {
            echo 'Welcome back ' . $_COOKIE['userName'];
        }
    }
}

