import React, { useState, useEffect } from "react";
import AddProjectForm from "./AddProjectForm";
import "./ProjectsPage.css";
import MapWithMarkers from "./MapwithMarker";

const ProjectsPage = () => {
  const [projects, setProjects] = useState(() => {
    const savedProjects = localStorage.getItem("projects");
    return savedProjects ? JSON.parse(savedProjects) : [];
  });
  const [newPlace, setNewPlace] = useState("");
  const [projectName, setProjectName] = useState("");
  const [newLat, setNewLat] = useState(null);
  const [newLon, setNewLon] = useState(null);

  const handleAddProject = (newProject) => {
    const updatedProjects = [...projects, newProject];
    setProjects(updatedProjects);
    localStorage.setItem("projects", JSON.stringify(updatedProjects));
    setNewPlace(newProject.place);
    setProjectName(newProject.name);
    setNewLat(newProject.lat);
    setNewLon(newProject.lon);
  };

  useEffect(() => {
    // Re-load markers from local storage
    const savedMarkers = localStorage.getItem("markers");
    if (savedMarkers) {
      const markers = JSON.parse(savedMarkers);
      if (markers.length > 0) {
        setNewPlace(markers[0].address);
        setProjectName(markers[0].project);
        setNewLat(markers[0].lat);
        setNewLon(markers[0].lon);
      }
    }
  }, []);

  return (
    <div className="projects-page">
      <h1>My Projects</h1>
      <div className="form-and-map-container">
        <div className="form-container">
          <AddProjectForm onAddProject={handleAddProject} />
        </div>
        <div className="map-container" style={{ zIndex: 0 }}>
          <MapWithMarkers
            place={newPlace}
            project={projectName}
            lat={newLat}
            lon={newLon}
          />
        </div>
      </div>
      <ul>
        {projects.map((project) => (
          <React.Fragment key={project.id}>
            <li>
              <h2>{project.name}</h2>
              <p>{project.description}</p>
              <p>Department: {project.department}</p>
              <p>Completion Time: {project.completionTime}</p>
              <p>Place: {project.place}</p>
            </li>
          </React.Fragment>
        ))}
      </ul>
    </div>
  );
};

export default ProjectsPage;
