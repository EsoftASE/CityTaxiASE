<?php
require_once('inc/sess_auth.php');

// Check if the user is logged in
if (!isset($_SESSION['userdata']) || empty($_SESSION['userdata'])) {
    // Redirect to login page if not logged in
    header('Location: http://localhost/cms/login.php');
    exit();
}

// Fetch available cabs
$cabs = $conn->query("SELECT c.*, cc.name as category FROM cab_list c INNER JOIN category_list cc ON c.category_id = cc.id WHERE c.delete_flag = 0 AND c.id NOT IN (SELECT cab_id FROM booking_list WHERE status IN (0,1,2)) ORDER BY c.reg_code");

// Fetch driver locations
$driver_locations = $conn->query("SELECT c.id as cab_id, cc.latitude, cc.longitude 
                                  FROM cab_list c 
                                  JOIN driver_locations cc ON c.id = cc.cab_id 
                                  WHERE cc.status = 'available'");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Cabs</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        #map {
            height: 400px;
            width: 100%;
        }

        .leaflet-marker-icon {
            width: 41px !important;
        }

        .textbox-container {
            margin-top: 20px;
        }

        .textbox-container label {
            font-weight: bold;
            margin-top: 10px;
        }

        .textbox-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="bg-dark py-5" id="main-header">
        <div class="container h-100 d-flex align-items-center justify-content-center w-100">
            <div class="text-center text-white w-100">
                <h1 class="display-4 fw-bolder">Available Cabs</h1>
            </div>
        </div>
    </header>

    <!-- Section -->
    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-5">
            <div class="row">
                <div class="col-md-12">
                    <div class="row gx-4 gx-lg-5 row-cols-1 row-cols-sm-1 row-cols-md-2 row-cols-xl-2" id="cab_list">
                        <?php while($row= $cabs->fetch_assoc()): ?>
                        <a class="col item text-decoration-none text-dark book_cab" href="javascript:void(0)" data-id="<?php echo $row['id'] ?>" data-bodyno="<?php echo $row['body_no'] ?>">
                            <div class="callout callout-primary border-primary rounded-0">
                                <dl>
                                    <dt class="h3"><i class="fa fa-car"></i> <?php echo $row['body_no'] ?></dt>
                                    <dd class="truncate-3 text-muted lh-1">
                                        <small><?php echo $row['category'] ?></small><br>
                                        <small><?php echo $row['cab_model'] ?></small>
                                        <small><?php echo $_SESSION['userdata']['email']; ?></small>
                                    </dd>
                                </dl>
                            </div>
                        </a>
                        <?php endwhile; ?>
                    </div>
                    <div id="noResult" style="display:none" class="text-center"><b>No Result</b></div>
                </div>
            </div>
        </div>
    </section>

    <!-- Map and Textboxes Section -->
    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-5">
            <div id="map"></div>
            <div class="textbox-container">
                <form id="bookingForm" action="search.php" method="post">
                    <label for="pickupZone">Pickup Zone:</label>
                    <input type="text" id="pickupZone" name="pickupZone" placeholder="Pickup Zone" readonly>

                    <label for="dropoffZone">Drop-off Zone:</label>
                    <input type="text" id="dropoffZone" name="dropoffZone" placeholder="Drop-off Zone" readonly>

                    <label for="selectedCab">Cab ID:</label>
                    <input type="text" id="selectedCab" name="selectedCab" placeholder="Selected Cab ID" readonly>

                    <!-- Hidden input to pass the user ID -->
                    <input type="hidden" id="userId" name="userId" value="<?php echo $_SESSION['userdata']['id']; ?>">

                    <button type="submit" class="btn btn-primary mt-3">Submit</button>
                </form>
            </div>
        </div>
    </section>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        $(function() {
            // Initialize the map with the coordinates of Mirissa Central College
            var map = L.map('map').setView([5.9445, 80.4559], 15);

            // Add tile layer
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);

            var pickupLatLng = null;
            var pickupAddress = null;
            var dropoffLatLng = null;
            var dropoffAddress = null;
            var dropoffSelected = false;

            function handleLocationError() {
                alert("Unable to retrieve your location.");
            }

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        var lat = position.coords.latitude;
                        var lng = position.coords.longitude;

                        pickupLatLng = [lat, lng];
                        L.marker(pickupLatLng, {
                            icon: L.icon({
                                iconUrl: 'https://img.icons8.com/ios-filled/500/marker.png',
                                iconSize: [25, 41],
                                iconAnchor: [12, 41],
                                popupAnchor: [1, -34],
                                shadowSize: [41, 41]
                            })
                        }).addTo(map)
                            .bindPopup("Pickup Zone")
                            .openPopup();

                        map.setView(pickupLatLng, 15);

                        fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}`)
                            .then(response => response.json())
                            .then(data => {
                                pickupAddress = data.display_name;
                                $('#pickupZone').val(pickupAddress);
                            })
                            .catch(error => {
                                console.error('Error fetching pickup address:', error);
                                alert("Error fetching pickup address.");
                            });
                    },
                    handleLocationError
                );
            } else {
                handleLocationError();
            }

            map.on('click', function(e) {
                dropoffLatLng = e.latlng;
                dropoffSelected = true;

                L.marker(dropoffLatLng, {
                    icon: L.icon({
                        iconUrl: 'https://img.icons8.com/ios-filled/500/marker.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    })
                }).addTo(map)
                    .bindPopup("Drop-off Zone")
                    .openPopup();

                fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${e.latlng.lat}&lon=${e.latlng.lng}`)
                    .then(response => response.json())
                    .then(data => {
                        dropoffAddress = data.display_name;
                        $('#dropoffZone').val(dropoffAddress);
                    })
                    .catch(error => {
                        console.error('Error fetching drop-off address:', error);
                        alert("Error fetching drop-off address.");
                    });
            });

            // Add driver locations to the map
            <?php while ($driver_location = $driver_locations->fetch_assoc()): ?>
                var driverLocation = [<?php echo $driver_location['latitude']; ?>, <?php echo $driver_location['longitude']; ?>];
                L.marker(driverLocation, {
                    icon: L.icon({
                        iconUrl: 'https://img.icons8.com/emoji/500/taxi-emoji.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    })
                }).addTo(map)
                    .bindPopup("Available Cab: <?php echo $driver_location['cab_id']; ?>");
            <?php endwhile; ?>
        });
    </script>
</body>
</html>
