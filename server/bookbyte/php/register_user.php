<?php
//error_reporting(0);
if (!isset($_POST['email']) && !isset($_POST['name']) && !isset($_POST['password'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$address = addslashes($_POST['address']);
$buyer = "Buyer";

//INSERT INTO `tbl_users`( `user_email`, `user_name`, `user_password`) VALUES ('[value-1]','[value-2]','[value-3]')
$sqlinsert = "INSERT INTO `tbl_users`(`user_email`, `user_name`, `user_phone`, `user_password`,`user_address`,`user_type`) VALUES ('$email','$name','$phone','$password', '$address', '$buyer')";

if ($conn->query($sqlinsert) === TRUE) {
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