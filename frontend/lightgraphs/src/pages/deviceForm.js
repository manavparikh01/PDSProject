import React, { useState } from 'react';
import { Link, useParams, useNavigate } from 'react-router-dom';
import './style.css';

const DeviceForm = () => {
  const { locationID } = useParams();
  const [deviceData, setDeviceData] = useState({
    type: 'general',
    model: 'general',
  });
  let history = useNavigate();

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setDeviceData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleAddDevice = async () => {
    try {
      const response = await fetch(`http://127.0.0.1:5000/add_device/${locationID}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(deviceData),
      });

      if (response.ok) {
        console.log('Device added successfully!');
        history(`/location/${locationID}`);
        // You can add additional logic or redirect after successful device addition
      } else {
        console.error('Failed to add device.');
      }
    } catch (error) {
      console.error('Error adding device:', error);
    }
  };

  return (
    <div>
      <div className="sidebar">
        <h2>Dashboard</h2>
        <ul>
          <li><Link to="/dashboard">Home</Link></li>
          <li><Link to={`/location/${locationID}`}>Locations</Link></li>
          <li><Link to="/settings">Settings</Link></li>
        </ul>
      </div>
      <div className="conedison">
        <img src="conedison.png" height="60px" width="280px" alt="Con Edison Logo" />
        <p>Your one-stop destination for a Smart Home Energy Management.</p>
      </div>

      <div className="content">
        <h1>Add a device:</h1>
        <p>LocationID: {locationID}</p>
        <form>
          <label htmlFor="type">Type:</label><br />
          <select name="type" id="type" onChange={handleInputChange} value={deviceData.type}>
            <option value="general">Select a Device</option>
            <option value="refrigerator">Refrigerator</option>
            <option value="ac">AC System</option>
            <option value="lights">Light</option>
          </select><br /><br />
          <label htmlFor="model">Model:</label><br />
          <select name="model" id="model" onChange={handleInputChange} value={deviceData.model}>
            <option value="general">Select a Device Model</option>
            <option value="refrigerator">Refrigerator</option>
            <option value="ac">AC System</option>
            <option value="lights">Light</option>
          </select><br /><br />
          <button type="button" onClick={handleAddDevice}>Add Device</button>
        </form>
      </div>
    </div>
  );
}

export default DeviceForm;
