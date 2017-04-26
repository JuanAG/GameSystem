<?php
    // Delete the cookies
    setcookie('userName', '', time()-60*60*24*365);
    setcookie('passWord', '', time()-60*60*24*365);
?>

<html>
<head>
    <meta http-equiv="refresh" content="0;URL=index.php">
</head>
<body>

</body>
</html>