import React from 'react';
import PolicePic from './../assets/images/police.png';
import CallPic from './../assets/images/call.png';
import FirePic from './../assets/images/fire.png';
import MedicPic from './../assets/images/medical.png';
import DisasPic from './../assets/images/disaster.png';
import WomenPic from './../assets/images/women.png';
import ChildPic from './../assets/images/child.png';
import RailPic from './../assets/images/railway.png';
import OtherPic from './../assets/images/others.png';

function Card() {
  return (
    <div className='card-container'>
      <div className='card'>
        <div className='card-content'>
          <h2>Police</h2>
          <p>Tap this button to instantly call the police if you encounter any crime-related issues. Your safety is our priority.</p>   
          <i class="fa-solid fa-phone"></i>     
        </div>
        <img src={PolicePic} alt="Police Icon" className='btn1'/>
      </div>    
      <div className='card'>
        <div className='card-content'>
          <h2>Fire</h2>
          <p>If you spot a fire or smoke, please call the fire department right away. Fires can spread quickly, so it's important to report them immediately. Make sure to evacuate the area safely and avoid trying to handle the fire on your own. Your prompt action can make a big difference in keeping everyone safe.</p>   
          <i class="fa-solid fa-phone"></i>     
        </div>
        <img src={FirePic} alt="Fire Icon" className='btn1'/>
      </div>
      <div className='card'>
        <div className='card-content'>
          <h2>Medical</h2>
          <p>If you’re facing a medical emergency or someone nearby is in urgent need of help, call emergency services immediately. This includes serious injuries, sudden illnesses, or any critical condition. Stay calm, provide clear details about the situation, and follow any instructions you receive. Quick action can make a big difference in getting the help you need.</p>   
          <i class="fa-solid fa-phone"></i>     
        </div>
        <img src={MedicPic} alt="Medical Icon" className='btn1'/>
      </div>
      <div className='card'>
        <div className='card-content'>
          <h2>Disaster</h2>
          <p>If you're dealing with a disaster, such as a natural calamity or major damage, call emergency services right away. This includes situations like earthquakes, floods, or severe storms. Stay safe, give clear information about what’s happening, and follow any instructions you receive. Your prompt action is vital for getting the help you need.</p>   
          <i class="fa-solid fa-phone"></i>     
        </div>
        <img src={DisasPic} alt="Disaster Icon" className='btn1'/>
      </div>
      <div className='card'>
        <div className='card-content'>
          <h2>Women</h2>
          <p>If you’re facing a difficult situation, whether it's related to personal safety, abuse, or emotional support, don’t hesitate to call the women’s helpline. Our trained professionals are here to help you with guidance, support, and resources. Your safety and well-being matter—reach out for the help you deserve.</p>   
          <i class="fa-solid fa-phone"></i>     
        </div>
        <img src={WomenPic} alt="Women Icon" className='btn1'/>
      </div>
      <div className='card'>
        <div className='card-content'>
          <h2>Child</h2>
          <p>If you’re concerned about a child’s safety or well-being, or if a child needs support, call the child helpline immediately. Whether it’s for emotional issues, abuse, or any other concern, trained professionals are ready to offer help and guidance. Your prompt action can make a big difference in a child’s life.</p>   
          <i class="fa-solid fa-phone"></i>     
        </div>
        <img src={ChildPic} alt="Child Icon" className='btn1'/>
      </div>
      <div className='card'>
        <div className='card-content'>
          <h2>Railway</h2>
          <p>If you encounter any issues related to train travel, such as delays, safety concerns, or lost belongings, call the railway helpline right away. Our team is available to provide support, information, and assistance to ensure a smooth journey. Your comfort and safety are our priority.</p>   
          <i class="fa-solid fa-phone"></i>     
        </div>
        <img src={RailPic} alt="Railway Icon" className='btn1'/>
      </div>
      <div className='card'>
        <div className='card-content'>
          <h2>Others</h2>
          <p>If you’re facing any issue or need support, call our general helpline for help. Whether it's for information, emergency assistance, or guidance on various matters, our team is here to assist you. Don’t hesitate to reach out—your concerns are important to us.</p>   
          <i class="fa-solid fa-phone"></i>        
        </div>
        <img src={OtherPic} alt="Others Icon" className='btn1'/>
      </div>
    </div>
  );
}

export default Card;
