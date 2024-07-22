const say = require("say");

const convertToMp3 = (text, filename, callback) => {
  say.export(text, "", 0.75, filename, function (err) {
    if (err) {
      return callback(err);
    }
    callback(null, filename);
  });
};

module.exports = convertToMp3;
