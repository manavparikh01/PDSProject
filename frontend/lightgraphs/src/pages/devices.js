import React, { useState, useEffect } from 'react';
import { Link, useParams } from 'react-router-dom';
import { useCustomerContext } from '../customerContext';
import './style.css';

const Devices = () => {
  const { customerID } = useCustomerContext();
  const { locationID } = useParams(); // Use useParams to get locationID from the URL
  const [devices, setDevices] = useState([]);

  const fetchDevices = async (customerID, locationID) => {
    try {
        console.log(locationID)
      const response = await fetch(`http://127.0.0.1:5000/devices/${customerID}/${locationID}`);

      if (response.ok) {
        const data = await response.json();
        console.log(data);
        setDevices(data.devices);
      } else {
        console.error('Failed to fetch devices.');
      }
    } catch (error) {
      console.error('Error fetching devices:', error);
    }
  };

  useEffect(() => {
    fetchDevices(customerID, locationID);
  }, [customerID]);

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
        <h1>Devices</h1>
        <p>Current Devices are as follows:</p>
        {devices.length > 0 ? (
          <div className="device-boxes">
            {devices.map((device) => (
              
                <div className="device-box">{device.Type}
                <p>{device.ModelNumber}</p>
                  <p>{device.DeviceID}</p>

                </div>
              
            ))}
          </div>
        ) : (
          <p>No devices added.</p>
        )}
        <button onClick={() => window.location.href = 'charts.html'}>View Charts</button>
        <p>To add new Devices click here:</p>
        <Link to={`/newdevice/${locationID}`}>
          <button>Add Device</button>
        </Link>
      </div>
    </div>
  );
};

export default Devices;