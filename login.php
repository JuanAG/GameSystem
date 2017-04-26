<?php

    echo 'Pagina de login';

    // The only login and pass for now
    $user = 'juan';
    $pass = ' ';

    if (isset($_POST['userName']) && isset($_POST['passWord'])) {
        // If the user exist
        if (($_POST['userName'] == $user) && ($_POST['passWord'] == $pass)) {
            if (isset($_POST['rememberMe'])) {
                // One year cookies
                setcookie('userName', $_POST['userName'], time()+60*60*24*365);
                setcookie('passWord', md5($_POST['passWord']), time()+60*60*24*365);

            } else {
                // Only until the browser closes
                setcookie('userName', $_POST['userName'], 0);
                setcookie('passWord', md5($_POST['passWord']), 0);
            }
            header('Location: index.php');
        }
        else {
            echo LoginIncorrect;
        }
    }
    else {
        echo LoginIncorrect;
    }

?>