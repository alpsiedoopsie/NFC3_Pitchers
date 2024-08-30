import React, { useState } from "react";
import AddProjectForm from "./AddProjectForm";
import "./ProjectsPage.css";
import MapWithMarkers from "./MapWithMarkers";
import ImageModal from "./ImageModal";

const ProjectsPage = () => {
  const [projects, setProjects] = useState(() => {
    const savedProjects = localStorage.getItem("projects");
    return savedProjects ? JSON.parse(savedProjects) : [];
  });
  const [newPlace, setNewPlace] = useState("");
  const [projectName, setProjectName] = useState("");
  const [newLat, setNewLat] = useState(null);
  const [newLon, setNewLon] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [modalImageUrl, setModalImageUrl] = useState("");

  const handleAddProject = (newProject) => {
    const updatedProjects = [...projects, newProject];
    setProjects(updatedProjects);
    localStorage.setItem("projects", JSON.stringify(updatedProjects));
    setNewPlace(newProject.location);
    setProjectName(newProject.typeOfCrime); // Adjust if needed
    setNewLat(newProject.coordinates.coordinates[1]); // Latitude
    setNewLon(newProject.coordinates.coordinates[0]); // Longitude
  };

  const openModal = (imageUrl) => {
    setModalImageUrl(imageUrl);
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setModalImageUrl("");
  };

  const capitalize = (str) => {
    return str.charAt(0).toUpperCase() + str.slice(1);
  };

  return (
    <div className="projects-page">
      <h1>My Projects</h1>
      <div className="form-and-map-container">
        <div className="form-container">
          <AddProjectForm onAddProject={handleAddProject} />
        </div>
        <div className="map-container">
          <MapWithMarkers place={newPlace} project={projectName} lat={newLat} lon={newLon} />
        </div>
      </div>
      <ul>
        {projects.map((project, index) => (
          <React.Fragment key={index}>
            <li>
              <h2>{capitalize(project.location)}</h2>
              <p>{project.descriptionOfCrime}</p>
              <p>Type of Crime: {capitalize(project.typeOfCrime)}</p>
              {project.picture && (
                <img
                  src={project.picture}
                  alt="Project"
                  style={{ width: '100px', height: '100px', cursor: 'pointer' }}
                  onClick={() => openModal(project.picture)}
                />
              )}
            </li>
          </React.Fragment>
        ))}
      </ul>
      <ImageModal isOpen={isModalOpen} onClose={closeModal} imageUrl={modalImageUrl} />
    </div>
  );
};

export default ProjectsPage;