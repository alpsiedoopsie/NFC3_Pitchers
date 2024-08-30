import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Navbar from "./components/Navbar";
import Home from "./components/Home";
import News from "./components/News";
import Contact from "./components/Contact";
import ProjectsPage from "./components/ProjectsPage";
import LocationPage from "./components/LocationPage";
import LoginForm from "./components/LoginForms"; // Import the new LoginForm component

function App() {
  return (
    <Router>
      <Navbar />
      <div style={{ paddingLeft: "16px" }}>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/news" element={<News />} />
          <Route path="/contact" element={<Contact />} />
          <Route path="/ProjectPage" element={<ProjectsPage />} />
          <Route path="/location" element={<LocationPage />} />
          <Route path="/get-started" element={<LoginForm />} /> {/* Add the new route */}
        </Routes>
      </div>
    </Router>
  );
}

export default App;