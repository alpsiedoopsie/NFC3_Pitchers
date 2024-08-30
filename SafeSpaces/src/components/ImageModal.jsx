// src/components/ImageModal.jsx
import React from 'react';
import './ImageModal.css';

const ImageModal = ({ isOpen, onClose, imageUrl }) => {
  if (!isOpen) return null;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <button className="modal-close" onClick={onClose}>X</button>
        <img src={imageUrl} alt="Preview" className="modal-image" />
      </div>
    </div>
  );
};

export default ImageModal;