const mongoose=require('mongoose');

const Schema = mongoose.Schema;

const likesSchema = new Schema({
    articleID: {
        type: mongoose.Schema.Types.ObjectID,
        ref: 'Article',
        required: true
    },
    authorID: {
        type: mongoose.Schema.Types.ObjectID,
        ref: 'User',
        required: true
    }
}
);
module.exports = mongoose.model("Likes", likesSchema);