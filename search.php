<?php
session_start();

// Include the initialize.php file to get the constants
include('initialize.php');

// Check if the user is logged in
if (!isset($_SESSION['userdata']) || empty($_SESSION['userdata'])) {
    // Redirect to login page if not logged in
    header('Location: ' . base_url . 'login.php');
    exit();
}

// Establish the database connection
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $pickupZone = isset($_POST['pickupZone']) ? htmlspecialchars($_POST['pickupZone']) : '';
    $dropoffZone = isset($_POST['dropoffZone']) ? htmlspecialchars($_POST['dropoffZone']) : '';
    $selectedCab = isset($_POST['selectedCab']) ? htmlspecialchars($_POST['selectedCab']) : '';
    $userId = isset($_SESSION['userdata']['id']) ? $_SESSION['userdata']['id'] : '';

    // Generate a unique reference code
    $refCode = uniqid('REF_');

    // Prepare and bind
    $stmt = $conn->prepare("INSERT INTO booking_list (ref_code, client_id, cab_id, pickup_zone, drop_zone, status, date_created, date_updated) VALUES (?, ?, ?, ?, ?, 0, NOW(), NOW())");
    $stmt->bind_param("sisss", $refCode, $userId, $selectedCab, $pickupZone, $dropoffZone);

    // Execute the statement
    if ($stmt->execute()) {
        echo "<div class='container mt-5'>";
        echo "<h1 class='mb-4'>Booking Successful!</h1>";
        echo "<p><strong>Reference Code:</strong> $refCode</p>";
        echo "<p><strong>Pickup Zone:</strong> $pickupZone</p>";
        echo "<p><strong>Drop-off Zone:</strong> $dropoffZone</p>";
        echo "<p><strong>Selected Cab ID:</strong> $selectedCab</p>";
        echo "<p><strong>User ID:</strong> $userId</p>";
        echo "<a href='index.php' class='btn btn-primary'>Go Back</a>";
        echo "</div>";
    } else {
        echo "Error: " . $stmt->error;
    }

    // Close the statement
    $stmt->close();
}

// Close the connection
$conn->close();
?>
