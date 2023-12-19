import React, { useEffect, useState } from 'react';
import { useCustomerContext } from '../customerContext';
import { Link, useNavigate } from 'react-router-dom';
import './style.css';

const Dashboard = () => {
  const { customerID, clearCustomer } = useCustomerContext();
  const [customerData, setCustomerData] = useState();
  let history = useNavigate();

  const fetchCustomerData = async (customerID) => {
    try {
      console.log(customerID);
      const response = await fetch(`http://127.0.0.1:5000/dashboard/${customerID}`);
      if (response.ok) {
        const data = await response.json();
        console.log(data);
        
        setCustomerData(data);
        //setName(data.Name);
        console.log(customerData);
      } else {
          const data = await response.json();
        console.error('Error fetching customer data:', data.error);
      }
    } catch (error) {
      console.error('Error fetching customer data:', error);
    }
  };

  useEffect(() => {
    

    // if (customerID) {
      fetchCustomerData(customerID);
      //return () => clearInterval(fetchCustomerData);
    // }
  }, [customerID]);

//   useEffect(() => {
//     console.log('inside effect', customerData);
//   }, [customerData])

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
        <img src="conedison.png" alt="Con Edison" height="60px" width="280px" />
      </div>
      <div className="content">
        <h1>Welcome to Con Edison</h1>
        <p>Your one-stop destination for Smart Home Energy Management.</p>
        {customerData ? (
        <>
          <p>Customer ID: {customerData.CustomerID}</p>
          <p>Name: {customerData.Name}</p>
          <p>Username: {customerData.Username}</p>
          <p>Billing Address: {customerData.BillingAddress}</p>
          {/* Add other customer details here */}
        </>
      ) : (
        <p>Loading...</p>
      )}
      </div>
    </div>
  );
};

export default Dashboard;

