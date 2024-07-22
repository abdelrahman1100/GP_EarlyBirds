const Category = require("../models/categoryModel");

async function seedCategories() {
  try {
    for (const name of Category.getAllowedCategories()) {
      if (await Category.findOne({ name })) {
        // if exists, don't add it again
        continue;
      }

      // create new record
      await Category.create({ name });
    }

    console.log("\tCategories seeding successfully");
  } catch (error) {
    console.error("Error seeding categories:", error);
  }
}

module.exports = seedCategories;
