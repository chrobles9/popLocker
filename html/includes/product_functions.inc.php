<?php

// This script defines functions used by the catalog.
// This script is begun in Chapter 8.


// Function for indicating the price.
// Takes into account the potential sales price.
// Takes three arguments: the product type, the regular price, and the sale price.
// Returns a string.
function get_price($regular) {
			// Otherwise, display the regular price:
			return '<strong>Price:</strong> $' . number_format($regular, 2) . '<br />';			
} // End of get_price() function.


// Function for calculating the shipping and handling.
// Takes one argument: the current order total.
// Returns a float.
function get_shipping($total = 0) {
	
	// Set the base handling charges:
	$shipping = 3;
	
	// Rate is based upon the total:
	if ($total < 10) {
		$rate = .25;
	} elseif ($total < 20) {
		$rate = .20;
	} elseif ($total < 50) {
		$rate = .18;
	} elseif ($total < 100) {
		$rate = .16;
	} else {
		$rate = .15;
	}
	
	// Calculate the shipping total:
	$shipping = $shipping + ($total * $rate);

	// Return the shipping total:
	return $shipping;
	
} // End of get_shipping() function.


