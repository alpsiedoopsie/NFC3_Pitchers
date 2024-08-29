import React, { useState } from 'react';

const AddProjectForm = ({ onAddProject }) => {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [department, setDepartment] = useState('');
  const [completionTime, setCompletionTime] = useState('');
  const [place, setPlace] = useState('');
  const [currentLocation, setCurrentLocation] = useState({ lat: null, lon: null });

  const handleSubmit = (e) => {
    e.preventDefault();

    const newProject = {
      id: Date.now(),
      name,
      description,
      department,
      completionTime,
      place,
      lat: currentLocation.lat,
      lon: currentLocation.lon,
    };

    onAddProject(newProject);

    // Clear the form
    setName('');
    setDescription('');
    setDepartment('');
    setCompletionTime('');
    setPlace('');
    setCurrentLocation({ lat: null, lon: null });
  };

  const handleUseCurrentLocation = () => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          setCurrentLocation({
            lat: position.coords.latitude,
            lon: position.coords.longitude,
          });
          setPlace('Current Location'); // Optional: Set a placeholder for the current location
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
