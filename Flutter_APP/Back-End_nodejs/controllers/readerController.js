const convertToMp3 = require("../helpers/readerHelper");
const fs = require("fs");
const path = require("path");

const parentDir = path.resolve(__dirname, "..");
const filename = "output.mp3";
const filepath = path.join(parentDir, filename);

const readNews = (req, res) => {
  const text = req.body.text;

  if (!text) {
    return res.status(400).send("Text is required");
  }

  convertToMp3(text, filename, (err, filename) => {
    if (err) {
      return res.status(500).send("Error generating MP3 file");
    }

    res.status(200).download(filepath, filename, (err) => {
      if (err) {
        console.error("Error sending file:", err);
      }

      // Optionally, delete the file after sending it
    //   fs.unlink(filepath, (err) => {
    //     if (err) {
    //       console.error("Error deleting file:", err);
    //     }
    //   });
    });
  });
};

module.exports = {
  readNews,
};
