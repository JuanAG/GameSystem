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
            <ul id="topHeaderLeft" class="">
                <li>
                    <a id="logoLink" class="" href="/">
                        <img id="logo" class="" src="/Images/logo.png" />
                    </a>
                </li>
                <li id="searchLi" class="">
                    <div id="search" class="">
                        <form id="searchBoxForm" class="roundedBorders" action="/search.php" method="get">
                            <div id="searchBox" class=""><!--
                                    --><input id="searchInput" class="" name="searchText" type="text" placeholder="<?php echo Search; ?>"><!--
                                    --><button id="searchButton" class="icon" name="searchButton" type="submit" value="search"></button>
                            </div>
                        </form>
                    </div>
                </li>
            </ul>
            <ul id="topHeaderRight" class="">
                <li id="cartLi" class="">
                    <a id="cartLink" class="linkHeader" href="cart.php">
                                <span>
                                    <?php echo Cart; ?>
                                </span>
                        <img id="cartIcon" class="icon" src="/Images/Icons/blank.png" />
                    </a>
                </li>
                <li id="accountLoginLi" class="">
                    <a id="loginLink" class="linkHeader" href="login.php">
                                <span>
                                    <?php echo Login; ?>
                                </span>
                        <img id="loginIcon" class="icon" src="/Images/Icons/blank.png" />
                        <?php /*<ul id="" class="">
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
                            </ul>*/ ?>
                    </a>

                </li>
                <li id="accountRegisterLi" class="">
                    <a id="registerLink" class="linkHeader" href="register.php">
                                <span>
                                    <?php echo Register; ?>
                                </span>
                        <img id="registerIcon" class="icon" src="/Images/Icons/blank.png" />
                        <?php /*<ul id="" class="">
                                <div id="" class="">
                                    <div id="" class="">
                                        <?php echo Register; ?>
                                    </div>
                                    <form id="registerForm" class="" action="register.php" method="post">

                                    </form>
                                </div>
                                </ul>*/ ?>
                    </a>
                </li>
            </ul>
            <div id="menusSeparator" class="fullWidth"></div>
            <ul id="menu" class="fullWidth">
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

        <div id="main" class="">
            Lorem ipun dolor
            </br></br></br></br></br></br></br></br></br></br></br></br></br>
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
                <img id="nintendo3DSLogo" class="" src="/Images/Icons/3ds.png" /><!--
                        --><img id="ps4Logo" class="" src="/Images/Icons/ps4.png" /><!--
                        --><img id="xboxLogo" class="" src="/Images/Icons/xbox.png" /><!--
                        --><img id="paypalLogo" class="" src="/Images/Icons/paypal.png" />
            </div>
        </div>
    </body>
</html>