const User = require("../models/userModel");
const comments = require("../models/commentsModel");
const jwt = require("jsonwebtoken");
require("dotenv").config();
const { ObjectId } = require("mongodb");
const { PythonShell } = require("python-shell");
const { exec } = require("child_process");
const path = require("path");

const getcomment = async (req, res) => {
  const { articleID } = req.body;
  const query = { articleID: articleID };
  try {
    const comment = await comments.find(query);
    return res.status(200).json({ comment });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const predict = (comment) => {
  return new Promise((resolve, reject) => {
    const pythonScriptPath = path.join(__dirname, "../python/predict.py");
    const pythonProcess = exec(
      `python ${pythonScriptPath}`,
      (error, stdout, stderr) => {
        if (error) {
          console.error(`exec error: ${error}`);
          reject("Error in prediction");
          return;
        }

        try {
          const message = stdout;
          const match = message.match(/\d+/);

          if (match) {
            const predictedLabel = parseInt(match[0], 10);

            let classification;

            if (predictedLabel === 0) {
              classification = "This comment is classified as hate speech.";
            } else if (predictedLabel === 1) {
              classification =
                "This comment is classified as offensive language.";
            } else {
              classification =
                "This comment is classified as neither offensive nor non-offensive.";
            }

            resolve({ classification });
          } else {
            reject("No valid prediction found in the message.");
          }
        } catch (parseError) {
          console.error(`parse error: ${parseError}`);
          reject("Error parsing prediction result");
        }
      }
    );

    pythonProcess.stdin.write(JSON.stringify(comment));
    pythonProcess.stdin.end();
  });
};

const testAddComment = async (text) => {
  try {
    const result = await predict(text);
    console.log("result is: ", result);
    return result;
  } catch (error) {
    return null;
  }
};

const addcomment = async (req, res) => {
  const publishDate = new Date();
  const { authorization } = req.headers;
  const token = authorization.split(" ")[1];
  const { text, articleID } = req.body;

  try {
    const { _id } = jwt.verify(token, process.env.JWT_SECRET);
    const user = await User.findOne({ _id });
    const userName = user.userName;
    const authorID = _id;
    if (!text) {
      return res.status(400).json({ error: "Comment text is required" });
    }

    if (!articleID) {
      return res.status(400).json({ error: "Article id is required" });
    }

    // Call predict function to classify the comment
    const predictionResult = await predict(text);

    // Check classification and decide whether to proceed with adding comment
    if (
      predictionResult.classification ===
      "This comment is classified as neither offensive nor non-offensive."
    ) {
      // console.log(text, publishDate, userName, authorID, articleID);
      const comment = await comments.create({
        text,
        publishDate,
        userName,
        authorID,
        articleID,
      });
      res
        .status(200)
        .json({ comment: "Comment added successfully", data: comment });
    } else {
      res.status(400).json({
        error: "This comment violated our policy and cannot be added",
      });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const editcomment = async (req, res) => {
  const { authorization } = req.headers;
  const token = authorization.split(" ")[1];
  const { text, commentID } = req.body;

  if (!text) {
    return res.status(400).json({ error: "Comment text is required" });
  }

  if (!commentID) {
    return res.status(400).json({ error: "Comment id is required" });
  }

  try {
    const { _id } = jwt.verify(token, process.env.JWT_SECRET);
    const comment = await comments.findOne({ _id: commentID });

    if (comment && comment.authorID.equals(new ObjectId(_id))) {
      // Call predict function and wait for the result
      const predictionResult = await predict(text);

      if (
        predictionResult.classification ===
        "This comment is classified as neither offensive nor non-offensive."
      ) {
        const filter = { _id: new ObjectId(commentID) };
        const updateDoc = {
          $set: {
            text: text,
          },
        };
        const result = await comments.updateOne(filter, updateDoc);
        const updatedComment = await comments.findOne({ _id: commentID });
        res.status(200).json({ updatedComment });
      } else {
        res.status(400).json({
          error:
            "This comment violated our policy! Your comment cannot be updated.",
        });
      }
    } else {
      res.status(400).json({ error: "Cannot edit" });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const deletecomment = async (req, res) => {
  const { authorization } = req.headers;
  // authorization should be 'Bearer token'
  const token = authorization.split(" ")[1];
  const { commentID } = req.body;
  try {
    const { _id } = jwt.verify(token, process.env.JWT_SECRET);
    const comment = await comments.find({ _id: commentID });
    if (comment && comment[0].authorID.equals(new ObjectId(_id))) {
      const result = await comments.deleteOne(new ObjectId(commentID));
      res.status(200).json({ result });
    } else {
      res.status(400).json("Can not delete");
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

module.exports = {
  getcomment,
  addcomment,
  editcomment,
  deletecomment,
  predict,
};
