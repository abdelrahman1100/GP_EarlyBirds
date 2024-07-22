const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const articleSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  source: {
    type: String,
    required: true,
  },
  author: {
    type: String,
    required: true,
  },
  url: {
    type: String,
    required: true,
  },
  publishedAt: {
    type: String,
    required: true,
  },
  languageId: {
    type: Schema.Types.ObjectId,
    ref: "Language",
    required: true,
  },
  categoryIds: [
    {
      type: Schema.Types.ObjectId,
      ref: "Category",
      required: true,
    },
  ],
  countryId: {
    type: Schema.Types.ObjectId,
    ref: "Country",
    required: true,
  },
  imageURL: {
    type: String,
  },
  content: {
    type: String,
  },
  description: {
    type: String,
  },
});

module.exports = mongoose.model("Article", articleSchema);
