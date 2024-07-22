const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const allowedCategories = [
  "business",
  "entertainment",
  "health",
  "science",
  "sports",
  "technology",
];

const categorySchema = new Schema({
  name: {
    type: String,
    required: true,
    unique: true,
    enum: {
      values: allowedCategories,
      message: "Invalid Category",
    },
  },
});

categorySchema.statics.getAllowedCategories = function () {
  return allowedCategories;
};

module.exports = mongoose.model("Category", categorySchema);
