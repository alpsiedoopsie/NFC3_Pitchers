import React, { useState, useEffect } from "react";
import MapWithMarkers from "./MapWithMarkers";

const LocationPage = () => {
  const [markers, setMarkers] = useState([]);

  useEffect(() => {
    const savedMarkers = localStorage.getItem("markers");
    if (savedMarkers) {
      setMarkers(JSON.parse(savedMarkers));
    }
  }, []);

  return (
    <div className="location-page">
      <h1>Location Map</h1>
      <MapWithMarkers markers={markers} />
    </div>
  );
};

export default LocationPage;