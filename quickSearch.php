<?php

require_once 'PHP/MagicConstants.php';
require 'PHP/DataBase.php';

    $querySearch = $_POST['search'];

    $answer = "<ul id=\"quickSearchResults\">";

    $gamesSearch = getDataToQuickSearchGames($querySearch);

    for($i = 0; $i < getQuickSearchMaxResults() && $i < count($gamesSearch); $i++){

        $id = $gamesSearch['IDJUEGO'][$i];
        if($id != null){
            $answer = $answer."<li class=\"quickSearchElementResult\">";
                $answer = $answer."<a id=\"photo".$i."\" class=\"searchItem\" href=\"game.php?id=".$id."\">";
                    $answer = $answer."<div class=\"quickSearchGame\">";
                        $answer = $answer."<div class=\"quickSearchPhoto\" class=\left\">";
                            $answer = $answer."<img class=\"quickSearchFront\" src=\"/Images/Games/".$id."/small/front.jpg\">";
                        $answer = $answer."</div>";
                        $answer = $answer."<div class=\"quickSearchData\" class=\"right\">";
                            $answer = $answer."<p class=\"quickSearchGameName\">".$gamesSearch['NOMBRE'][$i]."</p>";

                            $answer = $answer."<div class=\"quickSearchPricePlatform\">";
                                // Price
                                $answer = $answer."<p id=\"quickSearchPriceGame\">".$gamesSearch['PRECIO'][$i]." &euro;</p>";
                                // Platform
                                $answer = $answer."<div class=\"quickSearchPlatform\">";
                                    $answer = $answer."<p class=\"quickSearchPlatformGame\">".$gamesSearch['PLATAFORMA'][$i]."</p>";
                                    $iconPlatform = "";
                                    switch ($gamesSearch['PLATAFORMA'][$i]){
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
            $answer = $answer."</li>";
        }
    }

    $answer = $answer."</ul>";
    echo $answer;

    return 0;
?>