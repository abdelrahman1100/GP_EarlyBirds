const { default: mongoose } = require("mongoose");
const Likes = require("../models/likeModel");
const jwt = require("jsonwebtoken");

const like = async (req, res) => {
    const { authorization } = req.headers;
    // authorization should be 'Bearer token'
    const token = authorization.split(" ")[1];
    const { articleID } = req.body;
    try {
        const { _id } = jwt.verify(token, process.env.JWT_SECRET);
        const find = await Likes.findOne({ articleID, authorID: _id });
        if (find) {
            const del = await Likes.deleteOne({ articleID, authorID: _id });
            const pipeline = [{
            $match: {
                articleID: new mongoose.Types.ObjectId(articleID)
            }
        },
            {
                $group: {
                    _id: null,
                    count: { $sum: 1 }
                }   
            }
        ];
        const Like = mongoose.model("Likes");
        const arr = await Like.aggregate(pipeline).exec();
        let count = 0;
        if (arr.length > 0) {
            count = arr[0].count;   
        }
            res.status(200).json({ "Likes_count": count, "status": "disliked",del });
        }
        else {
            const create = await Likes.create({ articleID, authorID: _id });
            const pipeline = [{
            $match: {
                articleID: new mongoose.Types.ObjectId(articleID)
            }
        },
            {
                $group: {
                    _id: null,
                    count: { $sum: 1 }
                }   
            }
        ];
        const Like = mongoose.model("Likes");
        const arr = await Like.aggregate(pipeline).exec();
        let count = 0;
        if (arr.length > 0) {
            count = arr[0].count;   
        }
            res.status(200).json({ "Likes_count": count, "status": "liked",create });
        }
    } catch (error){
        res.status(400).json({ error: error.message });
    }
}

const getlikes = async (req, res) => {
    const { articleID } = req.body;
    try {
        const pipeline = [{
            $match: {
                articleID: new mongoose.Types.ObjectId(articleID)
            }
        },
            {
                $group: {
                    _id: null,
                    count: { $sum: 1 }
                }   
            }
        ];
        const all = await Likes.find({ articleID});
        const Like = mongoose.model("Likes");
        const arr = await Like.aggregate(pipeline).exec();
        let count = 0;
        if (arr.length > 0) {
            count = arr[0].count;   
        }
        res.status(200).json({ "Likes_count": count,all});
        
    } catch (error){
        res.status(400).json({ error: error.message });
    }
}

module.exports = {
    getlikes,
    like
};