const express = require("express");
const requireAuth = require("../middleware/requireAuth");
const {
  getNews,
  summarize,
  save,
  unsave,
  getSavedArticles,
} = require("../controllers/newsController");

const router = express.Router();

// require auth for all workouts routes
router.use(requireAuth);

// 'news/getNews' + req.body
router.get("/getNews", getNews);

router.post("/summarize", summarize);

router.post("/save", save);

router.post("/unsave", unsave);

router.get("/getSaved", getSavedArticles);

module.exports = router;
