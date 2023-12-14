import React from 'react';
import './style.css';

export default function LocationForm() {
    return (
        <div>
            <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="sidebar">
        <h2>Dashboard</h2>
        <ul>
            <li><a href="dashboard.html">Home</a></li>
            <li><a href="locations.html">Locations</a></li>
            <li><a href="#">Settings</a></li>
        </ul>
    </div>
    <div class="conedison">
        <img src="conedison.png" height = "60px" width = "280px">
        <p> Your one stop destination for a Smart Home Energy Management.</p>
    </div>
    <div class="content">
        <h1>Add a Location:</h1>
        <form>
            <label for="address">Address:</label><br>
            <input type="text" id="address" name="address"><br><br>
            <label for="unit">Unit Number:</label><br>
            <input type="number" id="unit" name="unit"><br><br>
            <label for="takedate">Takeover Date:</label><br>
            <input type="date" id="takedate" name="takedate"><br><br>
            <label for="sq">Square Footage:</label><br>
            <input type="number" id="sq" name="sq"><br><br>
            <label for="beds">Number of Bedrooms:</label><br>
            <input type="number" id="beds" name="beds"><br><br>
            <label for="occupants">Number of Occupants:</label><br>
            <input type="number" id="occupants" name="occupants"><br><br>
          </form>
    </div>

</body>
</html>

        </div>
    );
}
