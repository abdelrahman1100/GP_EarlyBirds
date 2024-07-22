const express = require("express");
const requireAuth = require("../middleware/requireAuth");

const {
    readNews
} = require("../controllers/readerController");

const router = express.Router();
//authorized features

router.use(requireAuth);

router.get("/readNews", readNews);

module.exports = router;