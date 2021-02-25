<?php
// Require the configuration before any PHP code:
  require('./includes/config.inc.php');


// Include the header file:
$page_title = 'PopLocker | Shop Till You Pop!';
include('./includes/header.html');


// Require the database connection:
require(MYSQL);

//Calls Categories
$r = mysqli_query($dbc, "SELECT * FROM categories");




// Include the view:
include('./views/list_categories.html');



// Include the footer file:
include('./includes/footer.html');


?>


