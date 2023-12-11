// Import necessary modules from React
import React, { useState } from 'react';
import { Link } from 'react-router-dom'; // Make sure to install react-router-dom if you haven't already

// Functional component for Sign In page
const SignInPage = () => {
  // State variables to store the username and password
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  // Function to handle form submission
  const handleSignIn = (e) => {
    e.preventDefault();

    // Add your logic to check the validity of the user here
    // For simplicity, let's just log the username and password for now
    console.log('Username:', username);
    console.log('Password:', password);

    // You can redirect the user to another page upon successful login
    // For example, using react-router-dom:
    // history.push('/dashboard');
  };

  return (
    <div>
      <h1 style={{ textAlign: 'center' }}>Sign In</h1>
      <form onSubmit={handleSignIn} style={{ textAlign: 'center' }}>
        <div>
          <label htmlFor="username">Username:</label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
        </div>
        <div>
          <label htmlFor="password">Password:</label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </div>
        <button type="submit">Sign In</button>
      </form>
      <div style={{ textAlign: 'center', marginTop: '10px' }}>
        <p>New user? <Link to="/register">Register here</Link></p>
      </div>
    </div>
  );
};

export default SignInPage;
