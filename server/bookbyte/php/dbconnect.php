<?php
$servername = "localhost";
$username   = "infinmwk_nurafifah";   //  root
$password   = "tcOB?iT07Hjg"; //
$dbname     = "infinmwk_nurafifah_bookbytes_db"; //  bookbytes_db

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>