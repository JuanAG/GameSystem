<?php

require_once 'MagicConstants.php';
require 'DataBase.php';

/**
 * @param $SliderInfo
 * @return string
 */
function getSlider($SliderInfo)
{
    // Connect to the database for the data
    $gamesSlider = getDataToSlider();

    $answer = "<div id= \"slider\" >";
    // The text
    $answer = $answer."<p id=\"sliderTitle\">".$SliderInfo."</p>";

    // Call for every game to the slider
    for ($i=0; $i < getSliderNumberOfGames(); $i++){
        $answer = $answer . getSliderGameHTML($gamesSlider, $i);
    }

    return $answer . "</div>";
}

/**
 * @param $arrayGames
 * @param $idIndexToGet
 * @return string
 */
function getSliderGameHTML($arrayGames, $idIndexToGet)
{
    $answer = "";
    // The element which contains the game needs to have front, if not it will not display anything
    if($arrayGames['FRONT'][$idIndexToGet] == "Y"){
        $id = $arrayGames['IDJUEGO'][$idIndexToGet];
        $answer = "<a id=\"photo".$idIndexToGet."\" class=\"hide sliderItem\" href=\"game.php?id=".$id."\">";
            $answer = $answer."<div id=\"sliderLeft\">";
                // Has front and the game will be added to the slider
                $answer = $answer."<img class=\"sliderFront\" src=\"/Images/Games/".$id."/big/front.jpg\">";
            $answer = $answer."</div>";
            $answer = $answer."<div id=\"sliderRigth\">";
                // Name
                $answer = $answer."<p class=\"sliderNameGame\">".$arrayGames['NOMBRE'][$idIndexToGet]."</p>";
                // The rest of photos
                $answer = $answer."<div class=\"sliderPhotosOfGame\">";
                    $photos = explode("#", $arrayGames['FOTOS'][$idIndexToGet]);
                    for($i = 1; $i < count($photos); $i++){
                        $answer = $answer."<img class=\"sliderLittlePhotos\" src=\"/Images/Games/".$id."/small/".$photos[$i]."\">";
                    }
                $answer = $answer."</div>";
                $answer = $answer."<div class=\"sliderPricePlatform\">";
                    // Price
                    $answer = $answer."<p id=\"sliderPriceGame\">".$arrayGames['PRECIO'][$idIndexToGet]." &euro;</p>";
                    // Platform
                    $answer = $answer."<div class=\"sliderPlatform\">";
                        $answer = $answer."<p class=\"sliderPlatformGame\">".$arrayGames['PLATAFORMA'][$idIndexToGet]."</p>";
                        $iconPlatform = "";
                        switch ($arrayGames['PLATAFORMA'][$idIndexToGet]){
                            case 'Xbox': $iconPlatform = "/Images/Icons/xboxIcon.png"; break;
                            case 'PS4': $iconPlatform = "/Images/Icons/psIcon.png"; break;
                            case '3DS': $iconPlatform = "/Images/Icons/3dsIcon.png"; break;
                            case 'PC': $iconPlatform = "/Images/Icons/pcIcon.png"; break;
                        }
                        $answer = $answer."<img class=\"reducedIcon\" src=\"".$iconPlatform."\">";
                    $answer = $answer."</div>";
                $answer = $answer."</div>";
            $answer = $answer."</div>";
        $answer = $answer."</a>";
    }
    return $answer;
}

function getTopNewerGames($mainNewerGames){
    // Connect to the database for the data
    $gamesTopNew = getDataToTopNewGames();

    $answer = "<div id= \"mainNewGames\" >";
    // The text
    $answer = $answer."<p id=\"gameTopTitle\">".$mainNewerGames."</p>";
    // The separator
    $answer = $answer."<p id=\"separatorTopTitle\"></p></div>";

    // Make it a list
    $answer = $answer."<ul id=\"topNewList\" class=\"gamesList\">";

    // Call for every game to the top
    for ($i=0; $i < getNumberOfTopNewGames(); $i++){
        $answer = $answer . getTopNewGame($gamesTopNew, $i);
    }

    return $answer . "</ul>";
}

/**
 * @param $arrayGames
 * @param $idIndexToGet
 * @return string
 */
function getTopNewGame($arrayGames, $idIndexToGet)
{
    $answer = "";
    // The element which contains the game needs to have front, if not it will not display anything
    if($arrayGames['FRONT'][$idIndexToGet] == "Y"){
        $id = $arrayGames['IDJUEGO'][$idIndexToGet];
        $answer = "<li>";
            $answer = $answer."<a id=\"photo".$idIndexToGet."\" class=\"topItem\" href=\"game.php?id=".$id."\">";
                $answer = $answer."<div class=\"topNewGame\">";
                    $answer = $answer."<img class=\"topFront\" src=\"/Images/Games/".$id."/big/front.jpg\">";
                    $answer = $answer."<p class=\"topGameName\">".$arrayGames['NOMBRE'][$idIndexToGet]."</p>";
                    $answer = $answer."<div class=\"topPricePlatform\">";
                        // Price
                        $answer = $answer."<p id=\"topPriceGame\">".$arrayGames['PRECIO'][$idIndexToGet]." &euro;</p>";
                        // Platform
                        $answer = $answer."<div class=\"topPlatform\">";
                            $answer = $answer."<p class=\"sliderPlatformGame\">".$arrayGames['PLATAFORMA'][$idIndexToGet]."</p>";
                            $iconPlatform = "";
                            switch ($arrayGames['PLATAFORMA'][$idIndexToGet]){
                                case 'Xbox': $iconPlatform = "/Images/Icons/xboxIcon.png"; break;
                                case 'PS4': $iconPlatform = "/Images/Icons/psIcon.png"; break;
                                case '3DS': $iconPlatform = "/Images/Icons/3dsIcon.png"; break;
                                case 'PC': $iconPlatform = "/Images/Icons/pcIcon.png"; break;
                            }
                            $answer = $answer."<img class=\"reducedIcon\" src=\"".$iconPlatform."\">";
                        $answer = $answer."</div>";
                    $answer = $answer."</div>";
                $answer = $answer."</div>";
            $answer = $answer."</a>";
        $answer = $answer."</li>";
    }
    return $answer;
}

function getTopFutureGames($mainNewerGames){
    // Connect to the database for the data
    $gamesTopFuture = getDataToTopFutureGames();

    $answer = "<div id= \"mainNewGames\" >";
    // The text
    $answer = $answer."<p id=\"gameTopTitle\">".$mainNewerGames."</p>";
    // The separator
    $answer = $answer."<p id=\"separatorTopTitle\"></p></div>";

    // Make it a list
    $answer = $answer."<ul id=\"topNewList\" class=\"gamesList\">";

    // Call for every game to the top
    for ($i=0; $i < getNumberOfTopFutureGames(); $i++){
        $answer = $answer . getTopNewGame($gamesTopFuture, $i);
    }

    return $answer . "</ul>";
}

function getGameToShow(){

    // Get the id of the game
    $id = $_REQUEST['id'];

    // Connect to the database for the data
    $gameData = getGameData1($id);
    $photos = getGameData2($id);
    $stock = getGameStock($id);
    $stock = $stock['STOCK'][0];
    $price = getGamePrice($id);
    $price = $price['PRICE'][0];
    $pegi = $gameData['PEGI'][0];
    $plataforma = $gameData['PLATAFORMA'][0];

    $answer = "<div id=\"game\">";
        // The part of buy and front

        // The part of the data
        $answer = $answer."<div id=\"gameDataBox\">";
            $answer = $answer."<div id=\"gameName\">".$gameData['NOMBRE'][0]."</div>";

            $answer = $answer."<div id=\"gameBuyBox\">";
            $answer = $answer."<div id=\"gameFront\" class=\"left\">";
                // If has front
                if($gameData['FRONT'][0] == 'Y'){
                    $answer = $answer."<img src=\"/Images/Games/".$id."/big/front.jpg\">";
                }
            $answer = $answer."</div>";
            $answer = $answer."<div id=\"gameBuy\" class=\"right\">";
                $answer = $answer."<div class=\"topPricePlatform\">";
                    // Price
                    $answer = $answer."<p id=\"topPriceGame\" class=\"bigPrice\" >".$price." &euro;</p>";
                    // Platform
                    $answer = $answer."<div class=\"topPlatform bigPlatform\">";
                        $answer = $answer."<p class=\"sliderPlatformGame\" >".$plataforma."</p>";
                        $iconPlatform = "";
                        switch ($plataforma){
                            case 'Xbox': $iconPlatform = "/Images/Icons/xboxIcon.png"; break;
                            case 'PS4': $iconPlatform = "/Images/Icons/psIcon.png"; break;
                            case '3DS': $iconPlatform = "/Images/Icons/3dsIcon.png"; break;
                            case 'PC': $iconPlatform = "/Images/Icons/pcIcon.png"; break;
                        }
                        $answer = $answer."<img class=\"reducedIcon\" src=\"".$iconPlatform."\">";
                    $answer = $answer."</div>";
                $answer = $answer."</div>";

                $answer = $answer."<div id=\"platformPegi\" class=\"oneLine\">";
                    $answer = $answer."<p class=\"\">".pegi."</p>";
                    $answer = $answer."<p class=\"\">".$pegi."</p>";
                $answer = $answer."</div>";

                $answer = $answer."<div id=\"buySellButtons\">";
                    $answer = $answer."<form class=\"oneLine\" method=\"post\" action=\"game.php\">";
                        $answer = $answer."<p>".quantity."</p>";
                        $answer = $answer."<input class=\"inputQuantity\" type=\"text\" name=\"quantity\" value=\"1\" />";
                        $answer = $answer."<input type=\"text\" class=\"hider\" name=\"id\" value=\"".$id."\" />";
                        $aux = "";
                        $class = "";
                        $rentText = "";
                        if($stock == 0){
                            $aux = reserve;
                            $class = "reserve buttonGame";
                            $rentText = reserve;
                        }
                        else if($stock > 0){
                            $aux = buy;
                            $class = "buy buttonGame";
                            $rentText = rent;
                        }
                        else {
                            $aux = noStock;
                            $class = "noStock buttonGame";
                            $rentText = noStock;
                        }
                        $answer .= "<input type=\"submit\" name=\"buy\" value=\"".$aux."\" class=\"".$class."\"";if($aux==noStock){$answer .=" disabled ";} $answer .= " />";
                        $answer = $answer."<input type=\"submit\" name=\"sell\" value=\"".sell."\" class=\"buy buttonGame\" />";
                        $answer = $answer."<input type=\"submit\" name=\"rent\" value=\"".$rentText."\" class=\"".$class."\" />";
                    $answer = $answer."</form>";


                $answer = $answer."</div>";

            $answer = $answer."</div>";

            $answer = $answer."<div class=\"separatorOrange\"></div>";
            $answer = $answer."<div id=\"youtube\">";
                $answer = $answer."<embed id=\"youtubeVideo\" src=\"http://www.youtube.com/v/".$gameData['YOUTUBE'][0]."?version=3&amp;hl=en_US&amp;rel=0&amp;autohide=1\"";
                $answer = $answer."wmode=\"transparent\" type=\"application/x-shockwave-flash\" allowfullscreen=\"true\" title=\"Adobe Flash Player\">";
            $answer = $answer."</div>";
            $answer = $answer."<div id=\"gamePhotos\">";
                // Get some random numbers for the photos
                $photosRan = $photos['NOMBRE'];
                shuffle($photosRan);

                // select the number of photos
                for($i = 0; $i < getGamesPhotos(); $i++){
                    $aux = $photosRan[$i];
                    $photoName = trim($photosRan[$i]);
                    $answer = $answer."<img class=\"gamePhoto\" src=\"/Images/Games/".$id."/big/".$photoName."\">";
                }
            $answer = $answer."</div>";
            $answer = $answer."<div id=\"gameDescription\">";
                $desc = $gameData['DESCRIPCION'][0];
                if(strpos($desc, "#REQUISITOS#")){
                    $desc = substr($desc, 0, strpos($desc, "#REQUISITOS#"));
                }
                $desc = trim($desc);
                $answer = $answer."<div>".$desc."</div>";
            $answer = $answer."</div>";

            $answer = $answer."<div class=\"separatorOrange\"></div>";

        $answer = $answer."</div>";
        $answer = $answer."</div>";

    return $answer."</div>";
}

function getRegisterForm(){
    $answer = "<form id=\"registerForm\" name=\"register\" class=\"form\" method=\"post\" action=\"register.php\">";
        $answer = $answer."<div class=\"separatorBlack\"></div><div class=\"separatorOrange\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formName."</p>"."<input id=\"name\" class=\"left\" type=\"text\" name=\"name\" value=\"John\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formLastName."</p>"."<input id=\"lastName\" class=\"left\" type=\"text\" name=\"lastName\" value=\"Smith\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formAddress."</p>"."<input id=\"address\" class=\"left\" type=\"text\" name=\"address\" value=\"Calle 25\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formCP."</p>"."<input id=\"cp\" class=\"left\" type=\"text\" name=\"cp\" value=\"41500\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formDNI."</p>"."<input id=\"dni\" class=\"left\" type=\"text\" name=\"dni\" value=\"12345678Z\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formMail."</p>"."<input id=\"mail\" class=\"left\" type=\"text\" name=\"mail\" value=\"john@game.system\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formLogin."</p>"."<input id=\"login\" class=\"left\" type=\"text\" name=\"login\" value=\"john\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formPass."</p>"."<input id=\"pass\" class=\"left\" type=\"password\" name=\"pass\" value=\"pass\"></div><br/>";
        $answer = $answer."<div class=\"oneLineFlex\"><p class=\"formText left\">".formRemenberMe."</p>"."<input id=\"remenberMe\" class=\"right\" type=\"checkbox\" name=\"remenberMe\" checked></div>";
        $answer = $answer."<br/><input id=\"submit\" type=\"submit\" name=\"submit\" value=\"".Register."\">";
        $answer = $answer."<div class=\"separatorOrange\"></div><div class=\"separatorBlack\"></div>";
    return $answer."</form>";
}

function getCartForm(){
    $answer = "<form id=\"cartForm\" name=\"doTransactions\" class=\"form\" method=\"post\" action=\"cartAction.php\">";

        $count = 0;
        if(isset($_SESSION['Compras'])){
            $count = count($_SESSION['Compras']);
            $answer = $answer."<p class=\"bigText\">".buy."</p>";
        }
        $totalTotal = 0;
        for($i = 0; $i < $count; $i++){
            $id = $_SESSION['Compras'][$i];
            $answer = $answer."<div class=\"transactionItem\">";
                $gameData = getGameData1($id);
                $price = getGamePrice($id);
                $price = $price['PRICE'][0];
                    $answer = $answer."<a id=\"photo".$i."\" class=\"cartItem\" href=\"game.php?id=".$id."\">";
                        $answer = $answer."<div class=\"cartGame\">";
                            $answer = $answer."<div class=\"cartPhoto\" class=\left\">";
                                $answer = $answer."<img class=\"quickSearchFront\" src=\"/Images/Games/".$id."/small/front.jpg\">";
                            $answer = $answer."</div>";
                            $answer = $answer."<div class=\"cartData\" class=\"right\">";
                                $answer = $answer."<p class=\"quickSearchGameName\">".$gameData['NOMBRE'][0]."</p>";

                                $answer = $answer."<div class=\"quickSearchPricePlatform\">";
                                    // Price
                                    $answer = $answer."<p class=\"cartPrice\">".$price." &euro;</p>";
                                    // Platform
                                    $answer = $answer."<div class=\"quickSearchPlatform\">";
                                        $answer = $answer."<p class=\"quickSearchPlatformGame\">".$gameData['PLATAFORMA'][0]."</p>";
                                        $iconPlatform = "";
                                        switch ($gameData['PLATAFORMA'][0]){
                                            case 'Xbox': $iconPlatform = "/Images/Icons/xboxIcon.png"; break;
                                            case 'PS4': $iconPlatform = "/Images/Icons/psIcon.png"; break;
                                            case '3DS': $iconPlatform = "/Images/Icons/3dsIcon.png"; break;
                                            case 'PC': $iconPlatform = "/Images/Icons/pcIcon.png"; break;
                                        }
                                        $answer = $answer."<img class=\"reducedIcon\" src=\"".$iconPlatform."\">";
                                    $answer = $answer."</div>";
                                $answer = $answer."</div>";
                            $answer = $answer."</div>";
                        $answer = $answer."</div>";
                    $answer = $answer."</a>";
                    $answer = $answer."<div class=\"sameLine2 nextGame\">";
                        $answer = $answer."<div class=\"left\" >".quantity."&nbsp;"."</div>";
                        $answer = $answer."<div id=\"cantidad\" class=\"right\">".$_SESSION['ComprasCantidad'][$i]."</div>";
                    $answer = $answer."</div>";
            $answer = $answer."</div>";
        }

        $count = 0;
        if(isset($_SESSION['Ventas'])){
            $count = count($_SESSION['Ventas']);
            $answer = $answer."<p class=\"bigText\">".sell."</p>";
        }
        for($i = 0; $i < $count; $i++){
            $id = $_SESSION['Ventas'][$i];
            $answer = $answer."<div class=\"transactionItem\">";
                $gameData = getGameData1($id);
                $price = getGamePrice($id);
                $price = $price['PRICE'][0];
                    $answer = $answer."<a id=\"photo".$i."\" class=\"cartItem\" href=\"game.php?id=".$id."\">";
                        $answer = $answer."<div class=\"cartGame\">";
                            $answer = $answer."<div class=\"cartPhoto\" class=\left\">";
                                $answer = $answer."<img class=\"quickSearchFront\" src=\"/Images/Games/".$id."/small/front.jpg\">";
                            $answer = $answer."</div>";
                            $answer = $answer."<div class=\"cartData\" class=\"right\">";
                                $answer = $answer."<p class=\"quickSearchGameName\">".$gameData['NOMBRE'][0]."</p>";

                                $answer = $answer."<div class=\"quickSearchPricePlatform\">";
                                    // Price
                                    $answer = $answer."<p class=\"cartPrice\">".$price." &euro;</p>";
                                    // Platform
                                    $answer = $answer."<div class=\"quickSearchPlatform\">";
                                        $answer = $answer."<p class=\"quickSearchPlatformGame\">".$gameData['PLATAFORMA'][0]."</p>";
                                        $iconPlatform = "";
                                        switch ($gameData['PLATAFORMA'][0]){
                                            case 'Xbox': $iconPlatform = "/Images/Icons/xboxIcon.png"; break;
                                            case 'PS4': $iconPlatform = "/Images/Icons/psIcon.png"; break;
                                            case '3DS': $iconPlatform = "/Images/Icons/3dsIcon.png"; break;
                                            case 'PC': $iconPlatform = "/Images/Icons/pcIcon.png"; break;
                                        }
                                        $answer = $answer."<img class=\"reducedIcon\" src=\"".$iconPlatform."\">";
                                    $answer = $answer."</div>";
                                $answer = $answer."</div>";
                            $answer = $answer."</div>";
                        $answer = $answer."</div>";
                    $answer = $answer."</a>";
                    $answer = $answer."<div class=\"sameLine2 nextGame\">";
                        $answer = $answer."<div class=\"left\" >".quantity."&nbsp;"."</div>";
                        $answer = $answer."<div id=\"cantidad\" class=\"right\">".$_SESSION['SellCantidad'][$i]."</div>";
                    $answer = $answer."</div>";
            $answer = $answer."</div>";
        }

        $count = 0;
        if(isset($_SESSION['Rents'])){
            $count = count($_SESSION['Rents']);
            $answer = $answer."<p class=\"bigText\">".rent."</p>";
        }
        for($i = 0; $i < $count; $i++){
            $id = $_SESSION['Rents'][$i];
            $answer = $answer."<div class=\"transactionItem\">";
                $gameData = getGameData1($id);
                $price = getGamePrice($id);
                $price = $price['PRICE'][0];
                    $answer = $answer."<a id=\"photo".$i."\" class=\"cartItem\" href=\"game.php?id=".$id."\">";
                        $answer = $answer."<div class=\"cartGame\">";
                            $answer = $answer."<div class=\"cartPhoto\" class=\left\">";
                                $answer = $answer."<img class=\"quickSearchFront\" src=\"/Images/Games/".$id."/small/front.jpg\">";
                            $answer = $answer."</div>";
                            $answer = $answer."<div class=\"cartData\" class=\"right\">";
                                $answer = $answer."<p class=\"quickSearchGameName\">".$gameData['NOMBRE'][0]."</p>";

                                $answer = $answer."<div class=\"quickSearchPricePlatform\">";
                                    // Price
                                    $answer = $answer."<p class=\"cartPrice\">".$price." &euro;</p>";
                                    // Platform
                                    $answer = $answer."<div class=\"quickSearchPlatform\">";
                                        $answer = $answer."<p class=\"quickSearchPlatformGame\">".$gameData['PLATAFORMA'][0]."</p>";
                                        $iconPlatform = "";
                                        switch ($gameData['PLATAFORMA'][0]){
                                            case 'Xbox': $iconPlatform = "/Images/Icons/xboxIcon.png"; break;
                                            case 'PS4': $iconPlatform = "/Images/Icons/psIcon.png"; break;
                                            case '3DS': $iconPlatform = "/Images/Icons/3dsIcon.png"; break;
                                            case 'PC': $iconPlatform = "/Images/Icons/pcIcon.png"; break;
                                        }
                                        $answer = $answer."<img class=\"reducedIcon\" src=\"".$iconPlatform."\">";
                                    $answer = $answer."</div>";
                                $answer = $answer."</div>";
                            $answer = $answer."</div>";
                        $answer = $answer."</div>";
                    $answer = $answer."</a>";
                    $answer = $answer."<div class=\"sameLine2 nextGame\">";
                        $answer = $answer."<div class=\"left\" >".quantity."&nbsp;"."</div>";
                        $answer = $answer."<div id=\"cantidad\" class=\"right\">".$_SESSION['RentsCantidad'][$i]."</div>";
                    $answer = $answer."</div>";
            $answer = $answer."</div>";
        }

        $answer = $answer."<br/><input id=\"submit\" type=\"submit\" name=\"submit\" value=\"".proceed."\">";
        $answer = $answer."<div class=\"separatorOrange\"></div><div class=\"separatorBlack\"></div>";
    return $answer."</form>";
}

function setTranactions(){
    $answer = "<div id=\"result\">";
    $name = null;
    if(isset($_COOKIE['loginUser'])){
        $name = $_COOKIE['loginUser'];
    }
    if($name != null) {
        $idUser = getDataFromDatabase("SELECT idLogin FROM Login WHERE Usuario = '" . $_COOKIE['loginUser'] . "'");
        $idUser = $idUser['IDLOGIN'][0];
        $count = 0;
        $transactionsCorrect = 0;
        if (isset($_SESSION['Compras'])) {
            $count = count($_SESSION['Compras']);
            $answer = $answer . "<div>Comprados:";
        }

        for ($i = 0; $i < $count; $i++) {
            $id = $_SESSION['Compras'][$i];

            $price = getGamePrice($id);
            $price = $price['PRICE'][0];
            $cantidad = $_SESSION['ComprasCantidad'][$i];

            $transactionsCorrect += setTransactions($idUser, $id, $price, $cantidad, 1);
        }
        if (isset($_SESSION['Compras'])) {
            $answer = $answer . " " . $transactionsCorrect . "</div>";
        }

        $count = 0;
        $transactionsCorrect = 0;
        if (isset($_SESSION['Ventas'])) {
            $count = count($_SESSION['Ventas']);
            $answer = $answer . "<div>Vendidos:";
        }
        for ($i = 0; $i < $count; $i++) {
            $id = $_SESSION['Ventas'][$i];

            $price = getGamePrice($id);
            $price = $price['PRICE'][0];
            $cantidad = $_SESSION['SellCantidad'][$i];

            $transactionsCorrect += setTransactions($idUser, $id, $price, $cantidad, 2);
        }
        if (isset($_SESSION['Ventas'])) {
            $answer = $answer . " " . $transactionsCorrect . "</div>";
        }

        $count = 0;
        $transactionsCorrect = 0;
        if (isset($_SESSION['Rents'])) {
            $count = count($_SESSION['Rents']);
            $answer = $answer . "<div>Alquilados:";
        }
        for ($i = 0; $i < $count; $i++) {
            $id = $_SESSION['Rents'][$i];

            $price = getGamePrice($id);
            $price = $price['PRICE'][0];
            $cantidad = $_SESSION['RentsCantidad'][$i];

            $transactionsCorrect += setTransactions($idUser, $id, $price, $cantidad, 3);
        }
        if (isset($_SESSION['Rents'])) {
            $answer = $answer . " " . $transactionsCorrect . "</div>";
        }
        // Delete the cart after the chekcout
        session_destroy();
    }
    else{
        $answer = $answer."Tiene que logearse para poder comprar";
    }
    return $answer."</div>";
}

function getLoginForm(){
    $answer = "<form id=\"registerForm\" name=\"register\" class=\"form\" method=\"post\" action=\"login.php\">";
        $answer = $answer."<div class=\"separatorBlack\"></div><div class=\"separatorOrange\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formLogin."</p>"."<input id=\"login\" class=\"left\" type=\"text\" name=\"login\" value=\"john\"></div>";
        $answer = $answer."<div class=\"oneLine\"><p class=\"formText left\">".formPass."</p>"."<input id=\"pass\" class=\"left\" type=\"password\" name=\"pass\" value=\"pass\"></div><br/>";
        $answer = $answer."<div class=\"oneLineFlex\"><p class=\"formText left\">".formRemenberMe."</p>"."<input id=\"remenberMe\" class=\"right\" type=\"checkbox\" name=\"remenberMe\" checked></div>";
        $answer = $answer."<br/><input id=\"submit\" type=\"submit\" name=\"submit\" value=\"".Login."\">";
        $answer = $answer."<div class=\"separatorOrange\"></div><div class=\"separatorBlack\"></div>";
    return $answer."</form>";
}

function getQueryResultsAux($name, $pegiInferior, $pegisuperior, $priceInferior, $priceSuperior, $atributos, $genres, $platforms, $asc, $orderby, $page, $a){
    $maxPrice = 0;
    $lookPrices = 1;
    if($name == null or $name == ""){$name = "NULL";} else{$name = "'".$name."'";}
    if($pegiInferior == null){$pegiInferior = "0";}
    if($pegisuperior == null){$pegisuperior = "0";}
    if($priceInferior == null){$priceInferior = "0.0";}
    if($priceSuperior == null){$priceSuperior = "0.0";}else{$lookPrices = 0; $maxPrice = floor($priceSuperior);}
    if($atributos == null or $atributos == ""){$atributos = "'NNNY'";} else{$atributos = "'".$atributos."'";}
    if($genres == null or $genres == ""){$genres = "'111111111111'";} else{$genres = "'".$genres."'";}
    if($platforms == null or $platforms == ""){$platforms = "'1111'";} else{$platforms = "'".$platforms."'";}
    if($asc == null or $asc == ""){$asc = "'Y'";} else{$asc = "'".$asc."'";}
    if($orderby == null or $orderby == ""){$orderby = "'10000'";} else{$orderby = "'".$orderby."'";}

    $queryResults = getQueryResults($name, $pegiInferior, $pegisuperior, $priceInferior, $priceSuperior, $atributos, $genres, $platforms, $asc, $orderby);
    $answer = "<div id='queryResults' class='gamesList'>";

        // See what page are we
        $initResult = getMaxQueryResults() * $page;
        $cont = 0;
        $resCount = count($queryResults['IDJUEGO']);

        for($i = 0; $i < $resCount; $i++){
            if($i >= $initResult && $cont < getMaxQueryResults()){
                $answer = $answer . getTopNewGame($queryResults, $i);
                $cont++;
            }
            // See what it is the max price of all games
            if($lookPrices == 1 && $queryResults['PRECIO'][$i] >= $maxPrice){
                $maxPrice = $queryResults['PRECIO'][$i];
            }
        }

        // Time to put the form who maintains state
        $answer = $answer."<form id=\"paginationHiddenForm\" action=\"search.php\" method=\"post\">";

            $answer = $answer."<div class=\"hiden\" >";
                $answer = $answer.getSearchForm($name, $pegiInferior, $pegisuperior, $priceInferior, $priceSuperior, $atributos, $genres, $platforms, $asc, $orderby, $page, $maxPrice, $a);
            $answer = $answer."</div>";

            $answer = $answer."<ul id=\"pagination\">";
                $pages = 0;
                if($resCount % getMaxQueryResults() == 0){
                    $pages = $resCount/getMaxQueryResults();
                }
                else {
                    $pages = 1 + $resCount / getMaxQueryResults();
                }
                for($i = 1; $i <= $pages; $i++){
                    $answer = $answer."<li><button  type=\"submit\" class=\"linkButton\" name=\"PAGE\" value=\"".($i-1)."\" >".$i."</button ></li>";
                }
            $answer = $answer."</ul>";

        $answer = $answer."</form>";

    return $answer."</div>";
}

function getSearchForm($name, $pegiInferior, $pegisuperior, $priceInferior, $priceSuperior, $atributos, $genres, $platforms, $asc, $orderby, $page, $maxPrice, $a){
    $answer = "<div>";
        $answer = $answer."<div class=\"oneLine hiden\">";
            $answer = $answer."<p></p>";
            $aux = str_replace("'", "", $name);
            if(strcasecmp($aux, "NULL") == 0){}
            else{
                $name = $aux;
                $answer = $answer."<input type=\"text\" name=\"searchText\" value=\"".$name."\">";
            }
        $answer = $answer."</div>";
        $answer = $answer."<div class=\"oneLine\">";
            $answer = $answer."<p>".Price."<span id=\"priceValue".$a."\" class=\"\"></span></p>";
            $answer = $answer."<input type=\"text\" name=\"priceInferior\" value=\"".$priceInferior."\" class=\"hide\">";
            $answer = $answer."<input id=\"sliderPriceId".$a."\" type=\"range\" class=\"sliderValue\" min=\"0\" max=\"".$maxPrice."\" name=\"priceSuperior\" value=\"".$maxPrice."\">";
        $answer = $answer."</div>";

        // Atributtes
        $answer = $answer."<p class=\"center\" >".searchAtributes."<p>";
        $atributos = str_replace("'", "", $atributos);
        $answer = $answer."<div class=\"atributesSearch\">";
            $aux = substr($atributos,0,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".edColec."</span>";
                $answer .= "<input type=\"checkbox\" name=\"esColeccionista\" value=\"".$aux."\""; if($aux == "Y"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($atributos,1,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".semiNew."</span>";
                $answer = $answer."<input type=\"checkbox\" name=\"esSeminuevo\" value=\"".$aux."\"";if($aux == "Y"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($atributos,2,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".retro."</span>";
                $answer = $answer."<input type=\"checkbox\" name=\"esRetro\" value=\"".$aux."\"";if($aux == "Y"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($atributos,3,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".digital."</span>";
                $answer = $answer."<input type=\"checkbox\" name=\"esDigital\" value=\"".$aux."\"";if($aux == "Y"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
        $answer = $answer."</div>";

        // Genres
        $answer = $answer."<p class=\"center\" >".searchGenres."<p>";
        $genres = str_replace("'", "", $genres);
        $answer = $answer."<div class=\"genresSearch\">";
            $aux = substr($genres,0,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchAction."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genAction\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,1,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchAdventure."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genAdventure\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,2,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchFighting."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genFighting\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,3,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchMisc."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genMisc\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,4,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchGenrePlatform."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genPlatform\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,5,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchPuzzle."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genPuzzle\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,6,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchRacing."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genRacing\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,7,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchRPG."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genRPG\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,8,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchShooter."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genShooter\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,9,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchSimulation."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genSimulation\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,10,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchSports."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genSports\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

            $aux = substr($genres,11,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchStrategy."</span>";
                $answer .= "<input type=\"checkbox\" name=\"genStrategy\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";

        $answer = $answer."</div>";

        // Platforms
        $answer = $answer."<p class=\"center\" >".searchPlatforms."<p>";
        $platforms = str_replace("'", "", $platforms);
        $answer = $answer."<div class=\"genresSearch\">";
            $aux = substr($platforms,1,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".PC."</span>";
                $answer .= "<input type=\"checkbox\" name=\"platformPc\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($platforms,0,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".DS."</span>";
                $answer .= "<input type=\"checkbox\" name=\"platform3DS\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($platforms,2,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".PS4."</span>";
                $answer .= "<input type=\"checkbox\" name=\"platformPS4\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($platforms,3,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".XboxOne."</span>";
                $answer .= "<input type=\"checkbox\" name=\"platformXbox\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
        $answer = $answer."</div>";

        // AscSoN
        $answer = $answer."<p class=\"center\" >".searchOrderBy."<p>";
        $asc = str_replace("'", "", $asc);
        $answer = $answer."<div class=\"ascSoNSearch hiden\">";
            $answer = $answer."<span>".searchAsc."</span>";
            $answer = $answer."<input type=\"checkbox\" name=\"orderAsc\" value=\"".$asc."\""; ;if($asc == "Y"){$answer .= "checked";} $answer .= " >";
        $answer = $answer."</div>";

        // OrderBy
        $orderby = str_replace("'", "", $orderby);
        $answer = $answer."<div class=\"orderBySearch\">";
            $aux = substr($orderby,0,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchName."</span>";
                $answer .= "<input type=\"checkbox\" name=\"orderName\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($orderby,1,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchPegi."</span>";
                $answer .= "<input type=\"checkbox\" name=\"orderPegi\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($orderby,2,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchPrice."</span>";
                $answer .= "<input type=\"checkbox\" name=\"orderPrice\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($orderby,3,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchPlatform."</span>";
                $answer .= "<input type=\"checkbox\" name=\"orderPlatform\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
            $aux = substr($orderby,4,1);
            $answer = $answer."<div class=\"sameLine\">";
                $answer = $answer."<span>".searchGenre."</span>";
                $answer .= "<input type=\"checkbox\" name=\"orderGenre\" value=\"".$aux."\""; if($aux == "1"){$answer .= "checked";} $answer .= " >";
            $answer = $answer."</div>";
        $answer = $answer."</div>";

        $answer = $answer."<input class=\"hiden\" type=\"text\" name=\"PAGE\" value=\"".$page."\">";
        $answer = $answer."<input type=\"submit\" id=\"searchButtonSearch\"value=\"".searchForm."\">";
    $answer = $answer."</div>";
    return $answer;
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

