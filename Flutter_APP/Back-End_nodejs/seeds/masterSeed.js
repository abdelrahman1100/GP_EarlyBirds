const mongoose = require("mongoose");
require("dotenv").config(); // to access process.env object

const seedArticles = require("./seedArticles");
const seedCategories = require("./seedCategories");
const seedLanguages = require("./seedLanguages");
const seedCountries = require("./seedCountries");

async function seedDatabase() {
  try {
    // connect datebase
    await mongoose.connect(process.env.MONGO_URI);
    // assuming DB is connected at index file
    console.log("Start seeding database");

    // run the seed functions
    await seedCategories();
    await seedLanguages();
    await seedCountries();

    // must be the last as it depends on previous seeds
    await seedArticles();

    console.log("Database seeded successfully");

    // disconnect database
    await mongoose.disconnect();
  } catch (error) {
    console.error("Error seeding database:", error);
  }
}

seedDatabase();
