// SignInPage.js
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useCustomerContext } from '../customerContext';
import './SignInPage.css';

const SignInPage = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [customer_id, setCustomer_id] = useState('');
  const { setCustomer } = useCustomerContext();
  let history = useNavigate();

  const handleSignIn = async (e) => {
    e.preventDefault();
    console.log('Username:', username);
    console.log('Password:', password);

    // Add your authentication logic here
    try {
      const response = await fetch('http://127.0.0.1:5000/signin', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password }),
      });

      if (response.ok) {
        const responseData = await response.json();
        console.log('Registration successful');
        console.log(responseData.customer_id)
        console.log(customer_id)
        setCustomer_id(responseData.customer_id);
        console.log(customer_id)
        setCustomer(responseData.customer_id);
        console.log('hello');
        
        history('/dashboard');
        // Handle successful authentication, e.g., redirect to the dashboard
      } else {
        const responseData = await response.json();
        console.error(`Authentication failed: ${responseData.message}`);
        // Handle authentication failure, e.g., display an error message to the user
      }
    } catch (error) {
      console.error('Error during authentication:', error);
      // Handle other errors, e.g., network issues
    }
  };

  return (
    <div className="sign-in-container">
      <h1 className="sign-in-header">Sign In</h1>
      <form onSubmit={handleSignIn} className="sign-in-form">
        <div className="form-group">
          <label htmlFor="username">Username:</label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
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
        <button type="submit" className="sign-in-button">
          Sign In
        </button>
      </form>
      <div className="new-user-link">
        <p>
          New user? <Link to="/register">Register here</Link>
        </p>
      </div>
    </div>
  );
};

export default SignInPage;
