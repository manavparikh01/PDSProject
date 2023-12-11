import React, { useEffect, useState } from 'react';
import { useCustomerContext } from '../customerContext';

const Dashboard = () => {
  const { customerID } = useCustomerContext();
  const [customerData, setCustomerData] = useState();
  const [name, setName] = useState('');

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



  return (
    <div>
      <h2>Dashboard</h2>
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
  );
};

export default Dashboard;

