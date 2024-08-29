import React, { useState, useEffect } from "react";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";
import axios from "axios";

import markerIcon2x from "leaflet/dist/images/marker-icon-2x.png";
import markerIcon from "leaflet/dist/images/marker-icon.png";
import markerShadow from "leaflet/dist/images/marker-shadow.png";

// Fix for default marker icon issue in React-Leaflet
delete L.Icon.Default.prototype._getIconUrl;

L.Icon.Default.mergeOptions({
  iconRetinaUrl: markerIcon2x,
  iconUrl: markerIcon,
  shadowUrl: markerShadow,
});

const MapWithMarkers = ({ place, project, lat, lon }) => {
  const [markers, setMarkers] = useState(() => {
    const savedMarkers = localStorage.getItem("markers");
    return savedMarkers ? JSON.parse(savedMarkers) : [];
  });

  const apiKey = '6be8fe7e245a435999e51f7fc43e3a58'; // Replace with your OpenCage API key

  useEffect(() => {
    const addMarker = async () => {
      if (!place && !lat && !lon) return; // Do nothing if neither place nor coordinates are provided

      // Avoid duplicate API calls for the same place or coordinates
      const isMarkerAlreadyAdded = markers.some(marker => 
        marker.lat === lat && marker.lon === lon && marker.address === place
      );

      if (!isMarkerAlreadyAdded) {
        let newMarker = { lat, lon, address: place || "Unknown", project };

        // If lat and lon are not provided, perform geocoding
        if (!lat || !lon) {
          try {
            const response = await axios.get(
              `https://api.opencagedata.com/geocode/v1/json`,
              {
                params: {
                  q: place,
                  key: apiKey,
                },
              }
            );

            if (response.data.results && response.data.results.length > 0) {
              const { lat, lng } = response.data.results[0].geometry;
              newMarker = { lat, lon: lng, address: place, project };
            } else {
              console.error("No location data found for the specified place.");
              return;
            }
          } catch (error) {
            console.error("Error fetching location data:", error);
            return;
          }
        }

        // Add the new marker and save to localStorage
        const updatedMarkers = [...markers, newMarker];
        setMarkers(updatedMarkers);
        localStorage.setItem("markers", JSON.stringify(updatedMarkers));
      }
    };

    addMarker();
  }, [place, lat, lon, project]); // Trigger only when these values change

  return (
    <MapContainer
      center={[19.078422674323754, 72.8659786122058]}
      zoom={13}
      style={{ height: "500px", width: "100%" }}
    >
      <TileLayer
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      />
      {markers.map((marker, index) => (
        <Marker key={index} position={[marker.lat, marker.lon]}>
          <Popup>
            <strong>{marker.project}</strong><br />
            {marker.address}
          </Popup>
        </Marker>
      ))}
    </MapContainer>
  );
};

export default MapWithMarkers;
