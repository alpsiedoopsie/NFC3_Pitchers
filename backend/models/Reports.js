const mongoose = require('mongoose');

const ReportSchema = new mongoose.Schema({
  location: { type: String, required: true },
  coordinates: {
    type: {
      type: String,
      enum: ['Point'],
      required: true
    },
    coordinates: {
      type: [Number],
      required: true
    }
  },
  typeOfCrime: { type: String, required: true },
  descriptionOfCrime: { type: String, required: true }
});

ReportSchema.index({ coordinates: '2dsphere' });

module.exports = mongoose.model('Report', ReportSchema);
