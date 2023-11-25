<?php
// Require the configuration before any PHP code:
  require('../config.inc.php');

  include('./includes/product_functions.inc.php');

// Include the header file:
$page_title = 'PopLocker | Shop Till You Pop!';
include('./includes/header.html');


// Require the database connection:
require(MYSQL);



// Invoke the stored procedure:
$r = mysqli_query($dbc, "SELECT * FROM product WHERE featured = 1");





// Include the view:
include('./views/home.html');

// Include the footer file:
include('./includes/footer.html');


?>








