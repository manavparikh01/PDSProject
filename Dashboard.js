import React from 'react';
import './style.css';

export default function Dashboard() {
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
    </div>
    <div class="content">
        <h1>Welcome to the Con Edison</h1>
        <p>Your one stop destination for a Smart Home Energy Management.</p>
        <p></p>
    </div>

</body>
</html>

        </div>
    );
}
