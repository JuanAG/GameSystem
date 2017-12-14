<?php

error_reporting(0);

require_once 'PHP/DataBase.php';

if(isset($_POST['name']) && $_POST['name'] != null) {

    setUser($_POST['name'], $_POST['lastName'], $_POST['address'], $_POST['cp'], $_POST['dni'], $_POST['mail'], $_POST['login'], $_POST['pass']);

    // Cookies Remenber me
    if(isset($_POST['remenberMe'])){
        setcookie("loginUser", $_POST['login'], time()+getCookieTime(), '/');
    }
}
