const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendEmergencyAlert = functions.https.onRequest(async (req, res) => {
  const {message, latitude, longitude} = req.body;

  const notification = {
    notification: {
      title: "Emergency Alert!",
      body: `${message} at location (Lat: ${latitude}, Long: ${longitude})`,
    },
    topic: "emergency_alerts", // Change this topic to target specific users
  };

  try {
    await admin.messaging().send(notification);
    res.status(200).send("Notification sent successfully");
  } catch (error) {
    console.error("Error sending notification:", error);
    res.status(500).send("Error sending notification");
  }
});
