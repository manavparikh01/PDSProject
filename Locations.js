import React from 'react';
import './style.css';

export default function Locations() {
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
            <li><a href="#">Locations</a></li>
            <li><a href="#">Settings</a></li>
        </ul>
    </div>
    <div class="conedison">
        <img src="conedison.png" height = "60px" width = "280px">
        <p> Your one stop destination for a Smart Home Energy Management.</p>
    </div>
    <div class="content">
        <h1>Locations</h1>
        <p>Current Locations are as follows:</p>
        <form>
            <input type="button" onclick="window.location.href='charts.html';" value="View Charts" />
        </form>
        <p>To add new Locations click here:</p>
        <form>
            <input type="button" onclick="window.location.href='location_form.html';" value="Add Location" />
        </form>
        <p>Add a new device to an existing loation:</p>
        <form>
            <input type="button" onclick="window.location.href='device_form.html';" value="Add a Device" />
        </form>
        
    </div>

</body>
</html>

        </div>
    );
}
