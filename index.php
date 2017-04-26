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
            <div id="topHeader" class="">
                <img id="logo" class="" src="/Images/logo.png" />
                <div id="search" class="">
                    <form id="searchBoxForm" class="roundedBorders" action="/search.php" method="get">
                        <fieldset id="searchBox" class=""><!--
                            --><input id="searchInput" class="" name="searchText" type="text" placeholder="<?php echo Search; ?>"><!--
                            --><button id="searchButton" class="" name="searchButton" type="submit" value="search"></button>
                        </fieldset>
                    </form>
                </div>
                <div id="clientBox" class="">
                    <div id="account" class="">
                        <div id="accountRegister" class="">
                            <a id="" class="" href="register.php">
                                <?php echo Register; ?>
                                <span id="" class="arrowDown"></span>
                            </a>
                            <ul id="" class="">
                                <div id="" class="">
                                    <div id="" class="">
                                        <?php echo Register; ?>
                                    </div>
                                    <form id="registerForm" class="" action="register.php" method="post">

                                    </form>
                                </div>
                            </ul>
                        </div>
                        <div id="accountLogin" class="">
                            <a id="" class="" href="login.php">
                                <?php echo Login; ?>
                                <span id="" class="arrowDown"></span>
                            </a>
                            <ul id="" class="">
                                <div id="" class="">
                                    <div id="" class="">
                                        <?php echo Login; ?>
                                    </div>
                                    <form id="loginForm" class="" action="login.php" method="post">
                                        <div id="" class="">
                                            <label for="username"><?php echo Username; ?></label>
                                            <input id="username" class="" name="userName" placeholder="<?php echo Username; ?>">
                                        </div>
                                        <div id="" class="">
                                            <label for="password"><?php echo Username; ?></label>
                                            <input id="password" class="" name="passWord" placeholder="<?php echo Password; ?>">
                                        </div>
                                        <div id="" class="">
                                            <div id="" class="">
                                                <input id="remember" class="" name="rememberMe" type="checkbox" checked>
                                                <label for="remember"><?php echo RemenberMe; ?></label>
                                            </div>
                                            <div id="" class="">
                                                <input id="loginButton" class="" name="loginButton" value="<?php echo Login; ?>" type="submit">
                                            </div>
                                        </div>
                                        <div id="" class="">
                                            <a id="" class="" href="recover.php">
                                                <?php echo ForgotPass; ?>
                                            </a>
                                        </div>
                                    </form>
                                </div>
                            </ul>
                        </div>
                    </div>
                    <div id="cart" class="">
                        <label></label>
                    </div>
                </div>
            </div>
            <div id="menu" class="">

            </div>
        </div>

        <div id="main" class="">
            <div id="slider" class="">

            </div>
            <div id="listProducts" class="">


            </div>
        </div>

        <div id="footer" class="fullWidth">
            <div id="topHeader" class="">

            </div>
            <div id="copyright" class="center">
                <?php echo Copyright; ?>
            </div>
            <div id="divider" class="">

            </div>
            <div id="finalIcons" class="white">
                <img id="nintendo3DS" class="" src="/Images/Icons/3DS.png" /><!--
                --><img id="logo" class="" src="/Images/Icons/ps4.png" /><!--
                --><img id="logo" class="" src="/Images/Icons/Xbox.png" /><!--
                --><img id="logo" class="" src="/Images/Icons/paypal.png" />
            </div>
        </div>
    </body>
</html>