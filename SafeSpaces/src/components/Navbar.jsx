import React, { useState, useEffect, useRef } from "react";
import { NavLink } from "react-router-dom";
import { IoMenu } from "react-icons/io5"; // Importing only the menu icon
import "./TopNav.css";

const Navbar = () => {
  const [showMenu, setShowMenu] = useState(false);
  const menuRef = useRef(null);

  const toggleMenu = () => {
    setShowMenu(!showMenu);
  };

  const closeMenuOnMobile = () => {
    if (window.innerWidth <= 1150) {
      setShowMenu(false);
    }
  };

  useEffect(() => {
    const handleResize = () => {
      if (window.innerWidth > 1150) {
        setShowMenu(false);
      }
    };

    const handleClickOutside = (event) => {
      if (menuRef.current && !menuRef.current.contains(event.target)) {
        setShowMenu(false);
      }
    };

    window.addEventListener("resize", handleResize);
    document.addEventListener("mousedown", handleClickOutside);

    return () => {
      window.removeEventListener("resize", handleResize);
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);

  return (
    <header className="header" style={{ zIndex: 10 }}>
      <nav className="nav container">
        <NavLink to="/" className="nav__logo">
          Safe<span className="logo">Spaces</span>
        </NavLink>

        <div
          className={`nav__menu ${showMenu ? "show-menu" : ""}`}
          id="nav-menu"
          ref={menuRef}
        >
          <ul className="nav__list">
            <li className="nav__item">
              <NavLink to="/" className="nav__link" onClick={closeMenuOnMobile}>
                Home
              </NavLink>
            </li>
            <li className="nav__item">
              <NavLink
                to="/news"
                className="nav__link"
                onClick={closeMenuOnMobile}
              >
                News
              </NavLink>
            </li>
            <li className="nav__item">
              <NavLink
                to="/ProjectPage"
                className="nav__link nav__cta"
                onClick={closeMenuOnMobile}
              >
                Incidents Report
              </NavLink>
            </li>
            <li className="nav__item">
              <NavLink
                to="/location"
                className="nav__link"
                onClick={closeMenuOnMobile}
              >
                Location
              </NavLink>
            </li>
            <li className="nav__item">
              <NavLink to="/get-started" className="nav__link nav__cta">
                Get Started
              </NavLink>
            </li>
          </ul>
        </div>

        <div className="nav__toggle" id="nav-toggle" onClick={toggleMenu}>
          <IoMenu />
        </div>
      </nav>
    </header>
  );
};

export default Navbar;
