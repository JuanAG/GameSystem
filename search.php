<?php

error_reporting(0);

header('Content-Type: text/html; charset=utf-8');

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
                                                                                                        placeholder="<?php
                                                                                                            if(isset($_REQUEST['searchText'])){
                                                                                                                echo $_REQUEST['searchText'];
                                                                                                            }
                                                                                                            else {
                                                                                                                echo Search;
                                                                                                            } ?>"><!--
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
                            <?php echo Hello." ".$_COOKIE['loginUser']; ?>
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

        <div id="main" class="sameLineSearch">
            <?php
                $nameSearch = ""; $pegiInferiorSearch = 0; $pegiSuperiorSearch = 0; $priceSuperiorSearch = 0.0; $priceInferiorSearch = 0.0;
                $coleccionistaSearch = "N"; $seminuevoSearch = "N"; $retroSearch = "N"; $digitalSearch = "N";
                $genActionSearch = "0"; $genAdventureSearch = "0"; $genFightingSearch = "0"; $genMiscSearch = "0"; $genPlatformSearch = "0"; $genPuzzleSearch = "0";
                $genRacingSearch = "0"; $genRPGSearch = "0"; $genShooterSearch = "0"; $genSimulationSearch = "0"; $genSportSearch = "0"; $genStrategySearch = "0";
                $orderAscSearch = "Y"; $orderNombre = "0"; $orderPegi = "0"; $orderPrice = "0"; $orderPlatform = "0"; $orderGenre = "0"; $page = 0;

                // Get the data
                if(isset($_REQUEST['searchText'])){$nameSearch = $_REQUEST['searchText'];}
                if(isset($_POST['pegiInferior'])){$pegiInferiorSearch = $_POST['pegiInferior'];}
                if(isset($_POST['pegiSuperior'])){$pegiSuperiorSearch = $_POST['pegiSuperior'];}
                if(isset($_POST['priceSuperior'])){$priceSuperiorSearch = $_POST['priceSuperior'];}
                if(isset($_POST['priceInferior'])){$priceInferiorSearch = $_POST['priceInferior'];}

                $atributosSearch = "";
                if(isset($_POST['esColeccionista'])){$coleccionistaSearch = "Y";}
                if(isset($_POST['esSeminuevo'])){$seminuevoSearch = "Y";}
                if(isset($_POST['esRetro'])){$retroSearch = "Y";}
                if(isset($_POST['esDigital'])){$digitalSearch = "Y";}
                if($coleccionistaSearch == "N" && $seminuevoSearch == "N" && $retroSearch == "N" && $digitalSearch == "N"){$atributosSearch = "NNNY";}
                else{$atributosSearch = $coleccionistaSearch."".$seminuevoSearch."".$retroSearch."".$digitalSearch;}

                $genres = "";
                if(isset($_POST['genAction'])){$genActionSearch = "1";}
                if(isset($_POST['genAdventure'])){$genAdventureSearch = "1";}
                if(isset($_POST['genFighting'])){$genFightingSearch = "1";}
                if(isset($_POST['genMisc'])){$genMiscSearch = "1";}
                if(isset($_POST['genPlatform'])){$genPlatformSearch = "1";}
                if(isset($_POST['genPuzzle'])){$genPuzzleSearch = "1";}
                if(isset($_POST['genRacing'])){$genRacingSearch = "1";}
                if(isset($_POST['genRPG'])){$genRPGSearch = "1";}
                if(isset($_POST['genShooter'])){$genShooterSearch = "1";}
                if(isset($_POST['genSimulation'])){$genSimulationSearch = "1";}
                if(isset($_POST['genSports'])){$genSportSearch = "1";}
                if(isset($_POST['genStrategy'])){$genStrategySearch = "1";}
                $booleanGenres =    $genActionSearch == "0" && $genAdventureSearch == "0" && $genFightingSearch == "0" && $genMiscSearch == "0" &&
                                    $genPlatformSearch == "0" && $genPuzzleSearch == "0" && $genRacingSearch == "0" && $genRPGSearch == "0" &&
                                    $genShooterSearch == "0" && $genSimulationSearch == "0" && $genSportSearch == "0" && $genStrategySearch == "0";
                if($booleanGenres){$genres = "111111111111";}
                else{
                    $genres = $genActionSearch."".$genAdventureSearch."".$genFightingSearch."".$genMiscSearch."".$genPlatformSearch."".$genPuzzleSearch;
                    $genres = $genres."".$genRacingSearch."".$genRPGSearch."".$genShooterSearch."".$genSimulationSearch."".$genSportSearch."".$genStrategySearch;
                    }

                $platforms = "";
                // See if it is a category search from the header
                if(isset($_GET['plataform'])){
                    $platAux = $_GET['plataform'];
                    switch ($platAux){
                        case "pc": $platforms = "0100"; break;
                        case "3ds": $platforms = "1000"; break;
                        case "ps4": $platforms = "0010"; break;
                        case "xbox": $platforms = "0001"; break;
                    }
                }
                else {
                    $platform3DSSearch = "0"; $platformPcSearch = "0"; $platformPS4Search = "0"; $platformXboxSearch = "0";
                    if(isset($_POST['platform3DS'])){$platform3DSSearch = "1";}
                    if(isset($_POST['platformPc'])){$platformPcSearch = "1";}
                    if(isset($_POST['platformPS4'])){$platformPS4Search = "1";}
                    if(isset($_POST['platformXbox'])){$platformXboxSearch = "1";}
                    if($platform3DSSearch == "0" && $platformPcSearch == "0" && $platformPS4Search == "0" && $platformXboxSearch == "0"){$platforms = "1111";}
                    else{$platforms = $platform3DSSearch."".$platformPcSearch."".$platformPS4Search."".$platformXboxSearch;}
                }

                if(isset($_POST['orderAsc'])){$orderAscSearch = "Y";}
                else{$orderAscSearch = "Y";}

                if(isset($_POST['orderName'])){$orderNombre = "1";}
                if(isset($_POST['orderPegi'])){$orderPegi = "1";}
                if(isset($_POST['orderPrice'])){$orderPrice = "1";}
                if(isset($_POST['orderPlatform'])){$orderPlatform = "1";}
                if(isset($_POST['orderGenre'])){$orderGenre = "1";}
                // Set an order by default
                if($orderNombre == "0" && $orderPegi == "0" && $orderPrice == "0" && $orderPlatform == "0" && $orderGenre == "0"){$orderNombre = "1";}
                $orderSearch = $orderNombre."".$orderPegi."".$orderPrice."".$orderPlatform."".$orderGenre;

                if(isset($_REQUEST['PAGE'])){$page = $_REQUEST['PAGE'];}
            ?>
            <div id="searchParams" class="left">
                <?php
                    $maxPrice = 0.0;
                    if($priceSuperiorSearch == 0.0){
                        $maxPrice = 150.0;
                    }
                    else{
                        $maxPrice = $priceSuperiorSearch;
                    }
                ?>
                <?php echo "<form id=\"paginationHiddenForm\" action=\"search.php\" method=\"post\">"; ?>
                <?php echo getSearchForm($nameSearch, $pegiInferiorSearch, $pegiSuperiorSearch, $priceInferiorSearch, $priceSuperiorSearch, $atributosSearch, $genres,
                                            $platforms, $orderAscSearch, $orderSearch, $page, $maxPrice, ""); ?>
                <?php echo "</form>"; ?>
            </div>
            <div id="searchResults" class="right">
                <?php
                    echo getQueryResultsAux($nameSearch, $pegiInferiorSearch, $pegiSuperiorSearch, $priceInferiorSearch, $priceSuperiorSearch, $atributosSearch, $genres,
                                            $platforms, $orderAscSearch, $orderSearch, $page, "1");
                ?>
                <script>
                var sliderPriceValue = document.getElementById("sliderPriceId");
                var outputPrice = document.getElementById("priceValue");
                outputPrice.innerHTML = sliderPriceValue.value;

                sliderPriceValue.oninput = function() {
                  outputPrice.innerHTML = this.value;
}
                </script>
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