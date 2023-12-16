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

  const getDeviceModels = () => {
    switch (deviceData.type) {
      case 'ac':
        return ['CoolFlow 7000', 'SuperCool 8000', 'BreezeCool 5500'];
      case 'refrigerator':
        return ['KitchenMaster 900', 'Maytag IceMaster 800', 'ElectroCool 950'];
      case 'lights':
        return ['SmartGlow 140W', 'BrightLite 160W', 'LumiTech 150W', 'GlowSmart 180W'];
      default:
        return ['Select a Device Model'];
    }
  };

  return (
    <div>
      <div className="sidebar">
      <h2>Dashboard</h2>
        <ul>
          <li><Link to="/dashboard">Home</Link></li>
          <li><Link to={`/locations`}>Locations</Link></li>
          <li><Link to="/settings">Settings</Link></li>
        </ul>
      </div>
      <div className="conedison">
      <img src="conedison.png" alt="Con Edison Logo" height="60px" width="280px" />
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
          
          {/* Only show the model select if a device type is selected */}
          {deviceData.type !== 'general' && (
            <>
              <label htmlFor="model">Model:</label><br />
              <select
                name="model"
                id="model"
                onChange={handleInputChange}
                value={deviceData.model}
              >
                {getDeviceModels().map((model) => (
                  <option key={model} value={model}>
                    {model}
                  </option>
                ))}
              </select><br /><br />
            </>
          )}

          <button type="button" onClick={handleAddDevice}>Add Device</button>
        </form>
      </div>
    </div>
  );
}

export default DeviceForm;
