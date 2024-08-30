import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Navbar from "./components/Navbar";
import Home from "./components/Home";
import News from "./components/News";
import Contact from "./components/Contact";
import ProjectsPage from "./components/ProjectsPage";

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
        </Routes>
      </div>
    </Router>
  );
}

export default App;
