const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const allowedCountries = ["eg", "us"];

const countrySchema = new Schema({
  code: {
    type: String,
    required: true,
    unique: true,
    enum: {
      values: allowedCountries,
      message: "Invalid Country",
    },
  },
});

countrySchema.statics.getAllowedCountries = function () {
  return allowedCountries;
};

module.exports = mongoose.model("Country", countrySchema);
