const Country = require("../models/countryModel"); // Assuming you have an Article model defined

async function seedCountries() {
  try {
    for (const code of Country.getAllowedCountries()) {
      if (await Country.findOne({ code })) {
        // if exists, don't add it again
        continue;
      }

      // create new record
      await Country.create({ code });
    }

    console.log("\tCountries seeded successfully");
  } catch (error) {
    console.error("Error seeding languages:", error);
  }
}

module.exports = seedCountries;
