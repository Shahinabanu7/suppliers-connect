<?php
header("Content-Type: application/json");
include "database.php"; 
$data = json_decode(file_get_contents("php://input"));

// Extract email and password
$email = $data->email ?? '';
$password = $data->password ?? '';

// Check if email and password are provided
if (empty($email) || empty($password)) {
    http_response_code(400);
    echo json_encode([
        "status" => false,
        "message" => "Email and password are required."
    ]);
    exit;
}

// Search for the user in the database
$sql = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";
$result = mysqli_query($conn, $sql);

// If a match is found
if ($user = mysqli_fetch_assoc($result)) {
    echo json_encode([
        "status" => true,
        "message" => "Login successful",
        "token" => $user['token'] // return the token
    ]);
} else {
    // If no match, return error
    http_response_code(401);
    echo json_encode([
        "status" => false,
        "message" => "Invalid email or password"
    ]);
}
?>
