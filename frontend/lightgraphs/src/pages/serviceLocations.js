import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useCustomerContext } from '../customerContext';
import './style.css';

const Locations = () => {
    const { customerID } = useCustomerContext();
    const [locations, setLocations] = useState([]);

    const fetchLocations = async (customerID) => {
        try {
          const response = await fetch(`http://127.0.0.1:5000/locations/${customerID}`);
  
          if (response.ok) {
            const data = await response.json();
            console.log(data);
            setLocations(data.locations);
          } else {
            console.error('Failed to fetch locations.');
          }
        } catch (error) {
          console.error('Error fetching locations:', error);
        }
      };

    useEffect(() => {
        
        
    console.log(customerID);
        fetchLocations(customerID);
    
      }, [customerID]); 

  return (
    <div>
      <div className="sidebar">
        <h2>Dashboard</h2>
        <ul>
          <li><Link to="/dashboard">Home</Link></li>
          <li><Link to="/locations">Locations</Link></li>
          <li><Link to="/settings">Settings</Link></li>
        </ul>
      </div>
      <div className="conedison">
        <img src="conedison.png" alt="Con Edison Logo" height="60px" width="280px" />
        <p>Your one-stop destination for a Smart Home Energy Management.</p>
      </div>
      <div className="content">
        <h1>Locations</h1>
        <p>To view energy cost per location</p>
        <Link to={`/locations/energycost`}>
        <button>View Chart</button>
      </Link>
        <p>Current Locations are as follows:</p>
        {locations.length > 0 ? (
          <div className="location-boxes">
            {locations.map((location) => (
              <Link to={`/location/${location.LocationID}`} key={location.LocationID}>
                <div className="location-box">{location.Address}
                <p>{location.LocationID}</p>
                </div>
                
              </Link>
            ))}
          </div>
        ) : (
          <p>No locations added.</p>
        )}
        
       
        <p>To add new Locations click here:</p>
      <Link to="/newlocation">
        <button>Add Location</button>
      </Link>
      </div>
    </div>
  );
};

export default Locations;
