import React, { createContext, useContext, useState, useEffect } from 'react';

const CustomerContext = createContext();

export const useCustomerContext = () => useContext(CustomerContext);

export const CustomerProvider = ({ children }) => {
  const [customerID, setCustomerID] = useState(() => {
    // Retrieve customer ID from localStorage on initial load
    return localStorage.getItem('customerID') || null;
  });

  // Update localStorage whenever customerID changes
  useEffect(() => {
    if (customerID) {
      localStorage.setItem('customerID', customerID);
    } else {
      localStorage.removeItem('customerID');
    }
  }, [customerID]);

  const setCustomer = (id) => {
    setCustomerID(id);
  };

  const clearCustomer = () => {
    setCustomerID(null);
  };

  return (
    <CustomerContext.Provider value={{ customerID, setCustomer, clearCustomer }}>
      {children}
    </CustomerContext.Provider>
  );
};
