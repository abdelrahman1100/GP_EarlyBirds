const express = require("express");
const requireAuth = require("../middleware/requireAuth");

const {
    like,
    getlikes
} = require("../controllers/likeController");

const router = express.Router();
//authorized features

router.use(requireAuth);

router.get("/getlikes", getlikes);

router.post("/like", like);

module.exports = router;