<?php
// Require the configuration before any PHP code:
require('../config.inc.php');

// Validate the required values:
 $category  = false;
	
if (isset($_GET['category'], $_GET['id']) && filter_var($_GET['id'], FILTER_VALIDATE_INT, array('min_range' => 1))) {
	// Make the associations:
	$catid = $_GET['category'];
	$category = $_GET['id'];
}

// If there's a problem, display the error page:
if(!$category){
	$page_title = 'Error!';
	include('./includes/header.html');
	include('./views/error.html');
	include('./includes/footer.html');
	exit();
}

// Include the header file:
include('./includes/header.html');

// Require the database connection:
require(MYSQL);

// Call the stored procedure:
$r = mysqli_query($dbc, "SELECT * FROM product WHERE category = $category");

// For debugging purposes:
if (!$r) echo mysqli_error($dbc);

// If records were returned, include the view file:
if (mysqli_num_rows($r) > 0) {

		 include('./views/list_products.html');

} else { // Include the "noproducts" page:
	include('./views/noproducts.html');
}

// Include the footer file:
include('./includes/footer.html');

?>