<?php

// This file contains the database access information. 
// This file establishes a connection to MySQL and selects the database.
// This script is begun in Chapter 7.

// Set the database access information as constants:
//DEFINE ('DB_USER', 'chrobles'); 
DEFINE('DB_USER', 'root');

// public password for project 
DEFINE ('DB_PASSWORD', 'Robles919');
DEFINE ('DB_HOST', 'localhost');
DEFINE ('DB_NAME', 'web260robleeos');

// Make the connection:
$dbc = mysqli_connect (DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

// Set the character set:
mysqli_set_charset($dbc, 'utf8');

// Omit the closing PHP tag to avoid 'headers already sent' errors!


/*if(mysqli_connect_error()){
    echo 'Database connection errors: '. mysqli_connect_error();
    die();
}
*/
?>