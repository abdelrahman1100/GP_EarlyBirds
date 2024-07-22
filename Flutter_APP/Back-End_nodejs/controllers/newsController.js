const Article = require("../models/articleModel");
const Country = require("../models/countryModel");
const Language = require("../models/languageModel");
const Category = require("../models/categoryModel");
const User = require("../models/userModel");
const Saved = require("../models/savedModel");
const Comments = require("../models/commentsModel");
const Likes = require("../models/likeModel");
const jwt = require("jsonwebtoken");

const mongoose = require("mongoose");

const NLPCloudClient = require("nlpcloud");

let SummarizerManager = require("node-summarizer").SummarizerManager;

const getNews = async (req, res) => {
  // for filtering upon language, category, country
  const { country, category, language } = req.body;

  if (!country && !category && !language) {
    return res.status(400).json({
      message: "atleast 1 field is required [category, country, language]",
    });
  }
  try {
    let requestedAttrs = {};

    // 1. check valdity of attrs values
    if (country) {
      if (!Country.getAllowedCountries().includes(country)) {
        return res.status(400).json({
          error: "Invalid Country",
          providedValue: country,
          acceptedValues: Country.getAllowedCountries(),
        });
      }
      const cn = await Country.findOne({ code: country });
      requestedAttrs.countryId = cn._id;
    }

    if (category) {
      if (!Category.getAllowedCategories().includes(category)) {
        return res.status(400).json({
          error: "Invalid Cateory",
          providedValue: category,
          acceptedValues: Category.getAllowedCategories(),
        });
      }
      const cat = await Category.findOne({ name: category });
      requestedAttrs.categoryIds = { $in: [cat._id] };
      // { categoryIds: { $in: [] } }
    }

    if (language) {
      if (!Language.getAllowedLanguages().includes(language)) {
        return res.status(400).json({
          error: "Invalid Language",
          providedValue: language,
          acceptedValues: Language.getAllowedLanguages(),
        });
      }
      const lan = await Language.findOne({ code: language });
      requestedAttrs.languageId = lan._id;
    }

    // make the request
    const articles = await Article.find(requestedAttrs);

    // get userId to know if the current user liked this artilce before or not
    const { authorization } = req.headers;
    // authorization should be 'Bearer token'
    const token = authorization.split(" ")[1];
    const { _id } = jwt.verify(token, process.env.JWT_SECRET); // userId

    // Get the comments count & likes count of each article
    for (let i = 0; i < articles.length; i++) {
      const commentsCount = await Comments.countDocuments({
        articleID: articles[i]._id,
      });

      const likesCount = await Likes.countDocuments({
        articleID: articles[i]._id,
      });

      articles[i] = articles[i].toObject(); // Convert Mongoose Document to plain JavaScript object
      articles[i].commentsCount = commentsCount;
      articles[i].likesCount = likesCount;

      articles[i].liked = false;
      const articleLikedByCurrentUser = await Likes.findOne({
        authorID: _id,
        articleID: articles[i]._id,
      });
      // console.log(articleLikedByCurrentUser);
      if (articleLikedByCurrentUser) {
        articles[i].liked = true;
      }
    }

    return res.status(200).json(articles);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

const summarize = async (req, res) => {
  const { text } = req.body;

  if (!text) {
    return res.status(400).json({ message: "article content is required" });
  }

  try {
    let Summarizer = new SummarizerManager(text, 10);
    let summary = Summarizer.getSummaryByFrequency().summary;
    return res.status(200).json({ summary });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// check that data exists, and it's valid
const validateRequestData = (req, res) => {
  const { userId, articleId } = req.body;

  // make sure data is sent
  if (!userId || !articleId) {
    return res
      .status(400)
      .json({ message: "make sure to send the required data" });
  }

  // validate ids
  if (
    !mongoose.Types.ObjectId.isValid(userId) ||
    !mongoose.Types.ObjectId.isValid(articleId)
  ) {
    return res.status(400).json({ message: "Ids are not valid" });
  }

  return null;
};

// check that there are data object with corresponding IDs
const userAndArticleExists = async (req, res) => {
  const { userId, articleId } = req.body;
  const user = await User.findOne({ _id: userId });
  const article = await Article.findOne({ _id: articleId });

  if (!user) {
    return res.status(400).json({ message: "No user with such id" });
  }

  if (!article) {
    return res.status(400).json({ message: "No article with such id" });
  }

  return null;
};

const articleIsSaved = async (userId, articleId) => {
  const articleSaved = await Saved.findOne({ userId, articleId });

  if (articleSaved) {
    return true;
  }

  return false;
};

const save = async (req, res) => {
  const { userId, articleId } = req.body;

  try {
    // ids are sent, and ids are valid
    let dataIsInvalid = validateRequestData(req, res);

    if (dataIsInvalid) {
      return dataIsInvalid;
    }

    // there are objects with corresponding ids
    dataIsInvalid = await userAndArticleExists(req, res);

    if (dataIsInvalid) {
      return dataIsInvalid;
    }

    // article is not saved before
    const articleSaved = await articleIsSaved(userId, articleId);
    if (articleSaved) {
      return res.status(400).json({ message: "Article is already saved" });
    }

    // save article
    await Saved.create({ userId, articleId });
    return res.status(200).json({ message: "article is saved successfully" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

const unsave = async (req, res) => {
  const { userId, articleId } = req.body;

  try {
    // ids are sent, and ids are valid
    let dataIsInvalid = validateRequestData(req, res);

    if (dataIsInvalid) {
      return dataIsInvalid;
    }

    // there are objects with corresponding ids
    dataIsInvalid = await userAndArticleExists(req, res);

    if (dataIsInvalid) {
      return dataIsInvalid;
    }

    // article is saved before
    const articleSaved = await articleIsSaved(userId, articleId);

    if (!articleSaved) {
      return res.status(400).json({ message: "No such save article" });
    }

    // save article
    await Saved.deleteOne({ userId, articleId });
    return res.status(200).json({ message: "article is unsaved successfully" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

const getSavedArticles = async (req, res) => {
  const { userId } = req.body;

  // make sure userId is sent in the request
  if (!userId) {
    return res.status(400).json({ message: "User id is not provided" });
  }

  if (!mongoose.Types.ObjectId.isValid(userId)) {
    return res.status(400).json({ message: "User id is not valid" });
  }

  try {
    // get all article saved by this user
    const savedArticles = await Saved.find({ userId });
    let articles = [];

    for (article of savedArticles) {
      const curArticle = await Article.findOne({ _id: article.articleId });
      articles.push(curArticle);
    }

    return res.status(200).json({ articles });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

module.exports = {
  getNews,
  summarize,
  save,
  unsave,
  getSavedArticles,
};
