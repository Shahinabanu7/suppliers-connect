<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");

// Read incoming JSON
$data = json_decode(file_get_contents("php://input"), true);

// Validate input
if (!isset($data['cart']) || empty($data['cart'])) {
    echo json_encode(["success" => false, "message" => "No cart items found"]);
    exit;
}

// DB connection
$host = "localhost";
$db_name = "supplier_connect"; // ✅ change to your DB name
$username = "root"; // ✅ change if different
$password = "root"; // ✅ set if your DB has password

try {
    $conn = new PDO("mysql:host=$host;dbname=$db_name", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo json_encode(["success" => false, "message" => "Connection failed: " . $e->getMessage()]);
    exit;
}

// Loop through cart and insert
$cart = $data['cart'];
$response = [];

foreach ($cart as $item) {
    $name = $item['name'];
    $price = $item['price'];
    $qty = $item['qty'];
    $image = $item['image'];

    $stmt = $conn->prepare("INSERT INTO orders (name, price, qty, image) VALUES (?, ?, ?, ?)");
    $success = $stmt->execute([$name, $price, $qty, $image]);

    if ($success) {
        $response[] = ["name" => $name, "status" => "inserted"];
    } else {
        $response[] = ["name" => $name, "status" => "failed"];
    }
}

echo json_encode([
    "success" => true,
    "message" => "Order placed",
    "details" => $response
]);

?>
