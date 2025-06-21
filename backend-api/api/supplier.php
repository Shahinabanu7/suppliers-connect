<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
$ip = '192.168.1.239'; 

header('Content-Type: application/json');

require_once 'database.php';

// Test DB connection
if ($conn->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "DB Connection failed: " . $conn->connect_error
    ]);
    exit;
}

// Run SQL query
$sql = "SELECT id, name, CONCAT('http://$ip/supplierconnect/', logo) AS logo, rating, category FROM suppliers";

$result = $conn->query($sql);

if (!$result) {
    echo json_encode([
        "success" => false,
        "message" => "SQL error: " . $conn->error
    ]);
    exit;
}

$suppliers = [];

while ($row = $result->fetch_assoc()) {
    $suppliers[] = $row;
}

if (empty($suppliers)) {
    echo json_encode([
        "success" => false,
        "message" => "No suppliers found"
    ]);
    exit;
}

echo json_encode([
    "success" => true,
    "data" => $suppliers
]);
?>
