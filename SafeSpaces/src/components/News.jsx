import { Carousel } from 'react-responsive-carousel';
import "react-responsive-carousel/lib/styles/carousel.min.css";
import React from 'react';

export default function News() {
  return (
    <Carousel>
      <div>
        <img src="/assets/images/1.jpg" alt="Image 1" />
        <p className="legend">Legend 1</p>
      </div>
      <div>
        <img src="/assets/images/2.jpg" alt="Image 2" />
        <p className="legend">Legend 2</p>
      </div>
      <div>
        <img src="/assets/images/3.jpg" alt="Image 3" />
        <p className="legend">Legend 3</p>
      </div>
    </Carousel>
  );
}