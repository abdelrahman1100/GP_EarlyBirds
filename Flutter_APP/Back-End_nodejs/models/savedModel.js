const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const savedSchema = new Schema({
  userId: {
    type: Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  articleId: {
    type: Schema.Types.ObjectId,
    ref: "Article",
    required: true,
  },
});

// to make sure that the 2 fields together must be unique (same article can't be saved twice be the same user)
// create compound unique index
savedSchema.index({ userId: 1, articleId: 1 }, { unique: true });

module.exports = mongoose.model("Saved", savedSchema);
