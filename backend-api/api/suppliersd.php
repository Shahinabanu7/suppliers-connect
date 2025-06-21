<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// ✅ Direct DB connection here
$host = "localhost";
$db_name = "supplier_connect"; 
$username = "root";
$password = "root";

try {
    $conn = new PDO("mysql:host=$host;dbname=$db_name;charset=utf8", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $exception) {
    echo json_encode([
        "success" => false,
        "message" => "Connection failed: " . $exception->getMessage()
    ]);
    exit;
}

// ✅ Check if ID is passed
if (!isset($_GET['id'])) {
    echo json_encode(["success" => false, "message" => "Supplier ID is required"]);
    exit;
}

$supplier_id = intval($_GET['id']);

// ✅ Base URL for images
$base_url = 'http://13.60.206.177/supplierconnect/';

// ✅ Get supplier
$sqlSupplier = "SELECT id, name, logo, rating, category FROM suppliers WHERE id = ?";
$stmtSupplier = $conn->prepare($sqlSupplier);
$stmtSupplier->execute([$supplier_id]);
$supplier = $stmtSupplier->fetch(PDO::FETCH_ASSOC);

if (!$supplier) {
    echo json_encode(["success" => false, "message" => "Supplier not found"]);
    exit;
}
$supplier['logo'] = $base_url . $supplier['logo'];

// ✅ Get products for this supplier
$sqlProducts = "SELECT id, supplier_id, name, image, price FROM products WHERE supplier_id = ?";
$stmtProducts = $conn->prepare($sqlProducts);
$stmtProducts->execute([$supplier_id]);
$products = $stmtProducts->fetchAll(PDO::FETCH_ASSOC);

// ✅ Add full image URL to each product
foreach ($products as &$product) {
    $product['image'] = $base_url . $product['image'];
}

// ✅ Final response
echo json_encode([
    "success" => true,
    "supplier" => $supplier,
    "products" => $products
]);
?>
