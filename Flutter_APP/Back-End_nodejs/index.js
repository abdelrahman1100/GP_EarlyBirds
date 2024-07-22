require("dotenv").config(); // to access process.env object
const express = require("express");
const mongoose = require("mongoose");
const userRoutes = require("./routes/user");
const newsRoutes = require("./routes/news");
const commentRoutes = require("./routes/comment");
const likeRoutes = require("./routes/like");
const readRoutes = require("./routes/reader");
const passport = require("passport");
const session = require("express-session");
const path = require("path");

// const crypto = require("crypto");

async function main() {
  // ONLY ONCE => generate jwt secret
  // const secret = crypto.randomBytes(64).toString("hex");
  // console.log(secret);

  
  // express app
  const app = express();
  
  // middleware
  app.use(express.json()); // to use request payload

  
  // routers
  app.use("/news", newsRoutes);
  app.use("/user", userRoutes);
  app.use("/comment", commentRoutes);
  app.use("/like", likeRoutes);
  app.use("/reader", readRoutes);

  try {
    await mongoose.connect(process.env.MONGO_URI);

    //* use 'npm run dev' to run the server
    app.listen(5000, () => {
      console.log("Listening on: http://localhost:5000");
    });
  } catch (error) {
    console.log(error);
  }
}

main();
