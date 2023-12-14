import React from 'react';
import './style.css';

export default function DeviceForm() {
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
        <h1>Add a device:</h1>
        <form>
            <label for="locID">LocationID:</label><br>
            <input type="text" id="locID" name="locID"><br><br>
            <label for="type">Type:</label><br>
            <select name="type" id="type">
                <option value="general" selected>Select a Device</option>
                <option value="refrigerator">Refrigerator</option>
                <option value="ac">AC System</option>
                <option value="lights">Light</option>
              </select><br><br>
            <label for="model">Model:</label><br>
            <select name="model" id="model">
                <option value="general" selected>Select a Device Model</option>
                <option value="refrigerator">Refrigerator</option>
                <option value="ac">AC System</option>
                <option value="lights">Light</option>
              </select><br><br>
          </form>
    </div>

</body>
</html>

        </div>
    );
}
