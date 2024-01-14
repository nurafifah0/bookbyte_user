<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$cartid = $_POST['cart_id'];
$newqty = $_POST['cart_qty'];
$newprice = $_POST['newprice'];

$sql = "UPDATE `tbl_cart` SET `cart_qty`= $cart_qty ,`book_price`= $book_price WHERE  `cart_id` = '$cart_id'";

if ($conn->query($sql) === TRUE) {
		$response = array('status' => 'success', 'data' => $sql);
		sendJsonResponse($response);
	}else{
		$response = array('status' => 'failed', 'data' => $sql);
		sendJsonResponse($response);
	}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>