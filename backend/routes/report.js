const express = require("express");
const router = express.Router();
const Report = require("../models/Reports.js"); // Adjust the path as necessary

// Endpoint to create a new report
router.post("/", async (req, res) => {
  try {
    const report = new Report(req.body);
    await report.save();
    res.status(201).send(report);
  } catch (error) {
    res.status(400).send(error);
  }
});

module.exports = router;
