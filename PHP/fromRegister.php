<?php

require_once 'PHP/MagicConstants.php';
require 'PHP/DataBase.php';

    $querySearch = $_POST['search'];

    $gamesSearch = getDataToQuickSearchGames($querySearch);

    echo "Pene";

    return 0;

?>