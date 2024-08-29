import React, { useState } from "react";

const AddProjectForm = ({ onAddProject }) => {
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [place, setPlace] = useState("");
  const [currentLocation, setCurrentLocation] = useState({
    lat: null,
    lon: null,
  });

  const handleSubmit = async (e) => {
    e.preventDefault();

    const formattedData = {
      "location": place,
      "coordinates": {
        "type": "Point",
        "coordinates": [currentLocation.lon, currentLocation.lat], // Longitude, Latitude
      },
      "typeOfCrime": name,
      "descriptionOfCrime": description,
    };

    try {
      const response = await fetch("http://localhost:3000/api/auth/submit", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formattedData),
      });

      if (response.ok) {
        const createdProject = await response.json();
        onAddProject({
          ...createdProject,
          lat: currentLocation.lat,
          lon: currentLocation.lon,
          place,
          name,
          description,
        });

        // Clear form fields after successful submission
        setName("");
        setDescription("");
        setPlace("");
        setCurrentLocation({ lat: null, lon: null });
      } else {
        console.error("Failed to submit the report");
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
          setPlace("Latitude: " + position.coords.latitude + 
  "   Longitude: " + position.coords.longitude);
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
      <button type="submit" onc>Submit Report</button>
    </form>
  );
};

export default AddProjectForm;
