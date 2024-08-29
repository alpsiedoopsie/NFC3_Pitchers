import React, { useState } from "react";

const AddProjectForm = ({ onAddProject }) => {
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [department, setDepartment] = useState("");
  const [completionTime, setCompletionTime] = useState("");
  const [place, setPlace] = useState("");
  const [currentLocation, setCurrentLocation] = useState({
    lat: null,
    lon: null,
  });
  const [capturedImage, setCapturedImage] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();

    const newProject = {
      name,
      description,
      department,
      completionTime,
      place,
      location: {
        type: "Point",
        coordinates: [currentLocation.lon, currentLocation.lat],
      },
      media: capturedImage ? [capturedImage] : [],
    };

    try {
      const response = await fetch("/api/reports", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(newProject),
      });

      if (response.ok) {
        const createdProject = await response.json();
        onAddProject(createdProject);
      
        setName("");
        setDescription("");
        setDepartment("");
        setCompletionTime("");
        setPlace("");
        setCurrentLocation({ lat: null, lon: null });
        setCapturedImage(null);
      } else {
        console.error("Failed to create project");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  };

  const handleUseCurrentLocation = () => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          setCurrentLocation({
            lat: position.coords.latitude,
            lon: position.coords.longitude,
          });
          setPlace("Current Location"); // Optional: Set a placeholder for the current location
        },
        (error) => {
          console.error("Error fetching current location:", error);
        }
      );
    } else {
      console.error("Geolocation is not supported by this browser.");
    }
  };

  return (
    <form onSubmit={handleSubmit} className="add-project-form">
      <div>
        <label>Type of Incident:</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />
      </div>
      <div>
        <label>Description:</label>
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          required
        />
      </div>
      <div>
        <label>Incident:</label>
        <input
          type="text"
          value={department}
          onChange={(e) => setDepartment(e.target.value)}
          required
        />
      </div>
      <div>
        <label>Incident Time:</label>
        <input
          type="text"
          value={completionTime}
          onChange={(e) => setCompletionTime(e.target.value)}
          required
        />
      </div>
      <div>
        <label>Place:</label>
        <input
          type="text"
          value={place}
          onChange={(e) => setPlace(e.target.value)}
        />
        <button type="button" onClick={handleUseCurrentLocation}>
          Use Current Location
        </button>
      </div>
      
      <button type="submit">Add Project</button>
    </form>
  );
};

export default AddProjectForm;
