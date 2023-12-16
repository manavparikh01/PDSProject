import React, { createContext, useContext } from 'react';

// SQL Keywords (add more as needed)
const SQL_KEYWORDS = ['SELECT', 'DROP', 'INSERT', 'UPDATE', 'DELETE', 'FROM', 'WHERE', 'JOIN'];

// Create a context
const SqlValidationContext = createContext({
  validateInput: (input) => {}
});

export const SqlValidationProvider = ({ children }) => {
  const validateInput = (input) => {
    const upperInput = input.toUpperCase();
    return !SQL_KEYWORDS.some(keyword => upperInput.includes(keyword));
  };

  return (
    <SqlValidationContext.Provider value={{ validateInput }}>
      {children}
    </SqlValidationContext.Provider>
  );
};

// Custom hook to use the context
export const useSqlValidation = () => useContext(SqlValidationContext);