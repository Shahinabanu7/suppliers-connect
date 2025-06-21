<?php
$host = "localhost";           // Database host
$user = "root";                // Database username (default is root for XAMPP)
$pass = "root";                    // Database password (leave empty for XAMPP)
$db   = "supplier_connect";    // Your database name

$conn = mysqli_connect($host, $user, $pass, $db);

if (!$conn) {
    die("Database connection failed: " . mysqli_connect_error());
}
?>