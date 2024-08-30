import React, { useState } from 'react';

const AddProjectForm = ({ onAddProject }) => {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [department, setDepartment] = useState('');
  const [completionTime, setCompletionTime] = useState('');
  const [place, setPlace] = useState('');
  const [currentLocation, setCurrentLocation] = useState({ lat: null, lon: null });
  const [picture, setPicture] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();

    const newProject = {
      location: place,
      coordinates: {
        type: "Point",
        coordinates: [currentLocation.lon, currentLocation.lat], // Longitude, Latitude
      },
      typeOfCrime: "Theft", // Example value, adjust as needed
      descriptionOfCrime: description,
      picture: picture ? URL.createObjectURL(picture) : null, // Convert file to URL
    };

    try {
      await fetch('http://localhost:3000/api/auth/submit', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(newProject),
      });

      // Clear the form
      setName('');
      setDescription('');
      setDepartment('');
      setCompletionTime('');
      setPlace('');
      setCurrentLocation({ lat: null, lon: null });
      setPicture(null);

      // Optionally update state to reflect the new project
      onAddProject(newProject);
    } catch (error) {
      console.error('Error submitting project:', error);
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
          setPlace('Current Location'); 
        },
        (error) => {
          console.error('Error fetching current location:', error);
        }
      );
    } else {
      console.error('Geolocation is not supported by this browser.');
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>Project Name:</label>
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
        <label>Department:</label>
        <input
          type="text"
          value={department}
          onChange={(e) => setDepartment(e.target.value)}
          required
        />
      </div>
      <div>
        <label>Completion Time:</label>
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
      <div>
        <label>Upload Picture:</label>
        <input
          type="file"
          accept="image/*"
          onChange={(e) => setPicture(e.target.files[0])}
        />
      </div>
      <button type="submit">Add Project</button>
    </form>
  );
};

export default AddProjectForm;