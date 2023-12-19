import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useCustomerContext } from '../customerContext';
import './style.css';

const LocationForm = () => {
    const { customerID, clearCustomer } = useCustomerContext();
    let history = useNavigate();

  const [locationData, setLocationData] = useState({
    address: '',
    zipcode: '',
    unit: '',
    takedate: '',
    sq: '',
    beds: '',
    occupants: '',
  });

  const handleSave = async () => {
    try {
      // Assuming you have an API endpoint for saving location data
      const response = await fetch('http://127.0.0.1:5000/newlocation', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ customerID, ...locationData }),
      });

      if (response.ok) {
        console.log('Location data saved successfully.');
        history('/locations');
        // You can add additional logic or redirect the user after successful save
      } else {
        console.error('Failed to save location data.', response);
      }
    } catch (error) {
      console.error('Error saving location data:', error);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setLocationData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSignOut = () => {
    // Clear customer data and redirect to the home page
    clearCustomer();
    history('/');
  };

  return (
    <div>
      <div className="sidebar">
        <h2>Dashboard</h2>
        <ul>
          <li><Link to="/dashboard">Home</Link></li>
          <li><Link to="/locations">Locations</Link></li>
          <li><Link to="/settings">Settings</Link></li>
        </ul>
        <div className="sign-out">
          <button onClick={handleSignOut}>Sign Out</button>
        </div>
      </div>
      <div className="conedison">
        <img src="/Users/manavparikh/Desktop/Fall23/Database/Project/frontend/lightgraphs/src/pages/conedison.png" alt="Con Edison" height="60px" width="280px" />
        <p>Your one-stop destination for a Smart Home Energy Management.</p>
      </div>
      <div className="content">
        <h1>Add a Location:</h1>
        <form>
          <label htmlFor="address">Address:</label><br />
          <input type="text" id="address" name="address" value={locationData.address}
            onChange={handleInputChange}/><br /><br />
          <label htmlFor="zipcode">ZipCode:</label><br />
          <input type="text" id="zipcode" name="zipcode" value={locationData.zipcode}
            onChange={handleInputChange}/><br /><br />
          <label htmlFor="unit">Unit Number:</label><br />
          <input type="number" id="unit" name="unit" value={locationData.unit}
            onChange={handleInputChange}/><br /><br />
          <label htmlFor="takedate">Takeover Date:</label><br />
          <input type="date" id="takedate" name="takedate" value={locationData.takedate}
            onChange={handleInputChange}/><br /><br />
          <label htmlFor="sq">Square Footage:</label><br />
          <input type="number" id="sq" name="sq" value={locationData.sq}
            onChange={handleInputChange}/><br /><br />
          <label htmlFor="beds">Number of Bedrooms:</label><br />
          <input type="number" id="beds" name="beds" value={locationData.beds}
            onChange={handleInputChange}/><br /><br />
          <label htmlFor="occupants">Number of Occupants:</label><br />
          <input type="number" id="occupants" name="occupants" value={locationData.occupants}
            onChange={handleInputChange}/><br /><br />
          <button type="button" onClick={handleSave}>
            Save Location
          </button>
        </form>
      </div>
    </div>
  );
};

export default LocationForm;
