const jwt = require("jsonwebtoken");
const User = require("../models/userModel");

// middleware to protect routes
const requireAuth = async (req, res, next) => {
  const { authorization } = req.headers;

  if (!authorization) {
    return res.status(401).json({ error: "Authorization token required" });
  }

  // authorization should be 'Bearer token'
  const token = authorization.split(" ")[1];

  try {
    const { _id } = jwt.verify(token, process.env.JWT_SECRET);

    // put user object in req, so that it
    // can be accessed by next middlewares
    req.user = await User.findOne({ _id }).select("_id");
    next();
  } catch (error) {
    console.log(error);
    res.status(401).json({ error: "Request is not authorized" });
  }
};

//test if logged in successfully with google
//function isLoggedIn(req, res, next) {
//  req.user ? next() : res.sendStatus(401);
//}

module.exports = requireAuth;
