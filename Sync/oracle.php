<?php

   $commands = array('getSQLPLUS'); // Get the route of sqlplus

    // exec commands
    foreach($commands AS $command){
       $tmp = shell_exec($command);
       // tmp now holds the proper command to execute
       //$output = shell_exec("cd ".$tmp." & StartDB");
       $output = shell_exec("cd ".$tmp." & StopDB");
       //$output = shell_exec("cd ".$tmp." & sqlplus");

       if(strpos($output, ">")){
            $output = substr($output, strpos($output, ">"));
        }
    }

?>

<!DOCTYPE HTML>
<html lang="en-US">
<head>
    <meta charset="UTF-8">
    <title>Updating oracle configuration</title>
</head>
<body>
<div>
    <div>
       <p>What Oracle says</p>
       <?php echo $output ?>
    </div>
</div>
</body>
</html>