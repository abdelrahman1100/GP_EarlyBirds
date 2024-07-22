const User = require("../models/userModel");
const bcrypt = require("bcrypt");
const validator = require("validator");
const jwt = require("jsonwebtoken");
const passport = require("passport");
const GoogleStrategy = require("passport-google-oauth20").Strategy;
require("dotenv").config();
const { PythonShell } = require("python-shell");
const path = require("path");
const { exec } = require("child_process");

const createToken = (_id, expiresIn = "3d") => {
  // return jwt.sign({ _id }, process.env.JWT_SECRET, { expiresIn: "3d" });
  return jwt.sign({ _id }, process.env.JWT_SECRET, { expiresIn: expiresIn });
};

const signupUser = async (req, res) => {
  const { email, password, userName } = req.body;
  try {
    // 1. check data is sent != null
    if (!email || !password || !userName) {
      throw new Error("Please provide all data");
    }

    // 2. validate email, password, userName
    if (!validator.isEmail(email)) {
      throw new Error("Email is not valid");
    }

    if (!validator.isStrongPassword(password)) {
      throw new Error("Password is not strong enough");
    }

    if (userName === "") {
      throw new Error("username can't be empty");
    }

    // 3. check that email is unique
    const exists = await User.findOne({ email });
    if (exists) {
      throw new Error("Email already in use");
    }

    // 4. bcrypt password & store user in DB
    const hash = await bcrypt.hash(password, 10); // value, salt
    const user = await User.create({ email, password: hash, userName });

    const token = createToken(user._id);

    res.status(200).json({ user, token });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    // 1. check email & password != null
    if (!email || !password) {
      throw new Error("All Entries must be filled");
    }
    // try to login the user (if don't exist through error)
    const user = await User.findOne({ email });

    // match the password with bcrypt (if not a match through error)
    let match = null; // should not be 'const' => reassigned

    if (user) {
      match = await bcrypt.compare(password, user.password);
    }
    if (!user || !match) {
      throw new Error("Incorrect username or password");
    }

    const token = createToken(user._id);

    res.status(200).json({ user, token });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const logoutUser = (req, res) => {
  // const token = req.headers.authorization;
  const { token } = req.body;
  const { _id } = jwt.verify(token, process.env.JWT_SECRET);
  createToken(_id, "1s");
  req.session.destroy();
  res.status(200).json("Loggedout successfully");
};

module.exports = {
  loginUser,
  signupUser,
  logoutUser,
};
