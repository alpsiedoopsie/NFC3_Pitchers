import React, { useState } from "react";
import "./LoginForm.css";

const LoginForm = () => {
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [phone, setPhone] = useState("");
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    setIsLoggedIn(true);
  };

  return (
    <div className="login-form-container">
      {isLoggedIn ? (
        <h1>Welcome, {name}!</h1>
      ) : (
        <form onSubmit={handleSubmit}>
          <div>
            <label htmlFor="name">Name:</label>
            <input
              type="text"
              id="name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
            />
          </div>
          <div>
            <label htmlFor="phone">Phone Number:</label>
            <input
              type="tel"
              id="phone"
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
              required
            />
          </div>
          <button type="submit">{isLoggedIn ? name : "Get Started"}</button>
        </form>
      )}
    </div>
  );
};

export default LoginForm;