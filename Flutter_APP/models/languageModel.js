const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const allowedLanguages = ["ar", "en"];

const languageSchema = new Schema({
  code: {
    type: String,
    required: true,
    unique: true,
    enum: {
      values: allowedLanguages,
      message: "Invalid Language",
    },
  },
});


languageSchema.statics.getAllowedLanguages = function () {
  return allowedLanguages;
};

module.exports = mongoose.model("Language", languageSchema);
