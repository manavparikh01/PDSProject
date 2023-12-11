// RegisterPage.js
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useCustomerContext } from '../customerContext';
import './RegisterPage.css';

const RegisterPage = () => {
  const [name, setName] = useState('');
  const [username, setUsername] = useState('');
  const [address, setAddress] = useState('');
  const [password, setPassword] = useState('');
  const [customer_id, setCustomer_id] = useState('');
  const { setCustomer } = useCustomerContext();
  // const history = useHistory();
  let history = useNavigate();


  const handleRegister = async (e) => {
    e.preventDefault();
    console.log('Name:', name);
    console.log('Username (Email):', username);
    console.log('Address:', address);
    console.log('Password:', password);
    // Add your registration logic here
    try {
        const response = await fetch('http://127.0.0.1:5000/register', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ name, username, address, password }),
        });
  
        if (response.ok) {
          const responseData = await response.json();
          console.log('Registration successful');
          console.log(responseData.customer_id)
          setCustomer_id(responseData.customer_id);
          setCustomer(responseData.customer_id);
          history('/dashboard');
          // Handle successful registration, e.g., redirect to login page
        } else {
          const errorData = await response.json();
          console.error(`Registration failed: ${errorData.error}`);
          // Handle registration error, e.g., display error message to the user
        }
      } catch (error) {
        console.error('Error during registration:', error);
        // Handle other errors, e.g., network issues
      }
  };

  return (
    <div className="register-container">
      <h1 className="register-header">Register</h1>
      <form onSubmit={handleRegister} className="register-form">
        <div className="form-group">
          <label htmlFor="name">Name:</label>
          <input
            type="text"
            id="name"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
        </div>
        <div className="form-group">
          <label htmlFor="username">Username (Email):</label>
          <input
            type="email"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
        </div>
        <div className="form-group">
          <label htmlFor="address">Address:</label>
          <input
            type="text"
            id="address"
            value={address}
            onChange={(e) => setAddress(e.target.value)}
          />
        </div>
        <div className="form-group">
          <label htmlFor="password">Password:</label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </div>
        <button type="submit" className="register-button">
          Register
        </button>
      </form>
      <div className="existing-user-link">
        <p>
          Already have an account? <Link to="/">Sign In here</Link>
        </p>
      </div>
    </div>
  );
};

export default RegisterPage;
