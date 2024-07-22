const Language = require("../models/languageModel"); // Assuming you have an Article model defined

async function seedLanguages() {
  try {
    for (const code of Language.getAllowedLanguages()) {
      if (await Language.findOne({ code })) {
        // if exists, don't add it again
        continue;
      }

      // create new record
      await Language.create({ code });
    }

    console.log("\tLanguages seeded successfully");
  } catch (error) {
    console.error("Error seeding languages:", error);
  }
}

module.exports = seedLanguages;
