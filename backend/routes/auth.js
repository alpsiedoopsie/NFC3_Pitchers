const express = require("express");
const router = express.Router();
const User = require("../models/User");
const Report = require("../models/Reports");

// Register route
router.post("/register", async (req, res) => {
  const { username, email, password } = req.body;

  try {
    let user = await User.findOne({ email });
    if (user) {
      return res.status(400).json({ message: "User already exists" });
    }

    user = new User({ username, email, password });
    await user.save();

    res.status(201).json({ message: "User registered" });
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

// Login route
router.post("/login", async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    const isMatch = await user.matchPassword(password);
    if (!isMatch) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    res.json({ message: "Login successful" });
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

router.post("/submit", async (req, res) => {
  const { location, coordinates, typeOfCrime, descriptionOfCrime } = req.body;

  try {
    // Create a new report instance with the provided data
    const report = new Report({
      location,
      coordinates,
      typeOfCrime,
      descriptionOfCrime,
    });

    // Save the report to the database
    await report.save();

    // Respond with a success message
    res.status(201).json({ message: "Report submitted successfully" });
  } catch (err) {
    // Handle errors and respond with a server error message
    res.status(500).json({ message: "Server error" });
  }
});

router.get("/reports", async (req, res) => {
  try {
    const reports = await Report.find(); // Fetch all reports from the database
    res.status(200).json(reports); // Send the fetched reports as a JSON response
  } catch (err) {
    res.status(500).json({ message: "Server error" }); // Handle errors and respond with a server error message
  }
});

module.exports = router;


