<?php

error_reporting(0);

header('Content-Type: text/html; charset=utf-8');
//setcookie("loginUser", null, null, '/');

require 'PHP/AuxFunctions.php';

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
        <link rel="stylesheet" type="text/css" href="CSS/main2.css">
        <link rel="stylesheet" type="text/css" href="CSS/slider.css">
        <link rel="stylesheet" type="text/css" href="CSS/autoComplete.css">
        <link rel="stylesheet" type="text/css" href="CSS/searchAndCart.css">
        <link rel="stylesheet" type="text/css" href="CSS/phone.css">
        <script src="JS/main.js" type="text/javascript"></script>
        <script src="JS/autocomplete.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
                                    --><input id="searchInput" class="" name="searchText" type="text" onkeyup="changeInput(this.value)"
                                                                                                        placeholder="<?php echo Search; ?>"><!--
                                    --><button id="searchButton" class="icon" name="searchButton" type="submit" value="search"></button>
                            </div>
                            <div  id="quickSearchResult"></div >
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
                <?php if(!isset($_COOKIE['loginUser'])) {
                    ?>
                    <li id="accountLoginLi" class="">
                        <a id="loginLink" class="linkHeader" href="login.php">
                            <span>
                                <?php echo Login; ?>
                            </span>
                            <img id="loginIcon" class="icon" src="/Images/Icons/blank.png" />
                        </a>
                    </li>
                    <li id="accountRegisterLi" class="">
                        <a id="registerLink" class="linkHeader" href="register.php">
                            <span>
                                <?php echo Register; ?>
                            </span>
                            <img id="registerIcon" class="icon" src="/Images/Icons/blank.png" />
                        </a>
                    </li>
                <?php }
                else { ?>
                <li>
                    <div id="userCookie" class="">
                        <span>
                            <?php
                                echo Hello." ".$_COOKIE['loginUser'];
                            ?>

                        </span>
                    </div>
                </li>
                <?php }?>
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
            <?php echo getSlider(SliderInfo) ?>
            <script>
                var gameIndex = 0;
                slider();

                function slider() {
                    var i;
                    var x = document.getElementsByClassName("hide");
                    for (i = 0; i < x.length; i++) {
                        x[i].style.display = "none";
                    }
                    gameIndex++;
                    if (gameIndex > x.length) {
                        gameIndex = 1
                    }
                    x[gameIndex-1].style.display = "block";

                    setTimeout(slider, 5000);
                }
            </script>
            <?php echo getTopFutureGames(mainFutureGames)?>
            <?php echo getTopNewerGames(mainNewerGames)?>
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