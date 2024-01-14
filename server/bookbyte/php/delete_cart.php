<?php
//error_reporting(0);

if (!isset($_POST['cartid']) && !isset($_POST['buyerid'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$cartid = $_POST['cartid'];
$buyerid = $_POST['buyerid'];


$sqldelete = "DELETE FROM `tbl_cart` WHERE `cart_id` = '$cartid' AND `buyer_id` = '$buyerid'";

if ($conn->query($sqldelete) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>