<?php


// Require the configuration before any PHP code:
require('../access/config.inc.php');

// Include the header file:
include('./includes/header.html');

// Require the database connection:
require(MYSQL);

//Calls Categories
$r = mysqli_query($dbc, "SELECT * FROM categories");

// For debugging purposes:
if (!$r) echo mysqli_error($dbc);

// If records were returned, include the view file:
if (mysqli_num_rows($r) > 0) {
	include ('./views/list_categories.html');
} else { // Include the error page:
	include ('./views/error.html');
}

// Include the footer file:
include ('./includes/footer.html');



?>