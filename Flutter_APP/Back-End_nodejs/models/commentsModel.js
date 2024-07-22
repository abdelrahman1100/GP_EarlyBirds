const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const commentsSchema = new Schema({
  text: {
    type: String,
    required: true
  },
  publishDate: {
    type: String,
    required: true
  },
  userName: {
    type: String,
    required: true
  },
  authorID: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  articleID: {
    type: Schema.Types.ObjectId,
    ref: 'Article',
    required: true
  },
});

module.exports = mongoose.model("Comments", commentsSchema);
