const Article = require("../models/articleModel"); // Assuming you have an Article model defined
const Country = require("../models/countryModel");
const Language = require("../models/languageModel");
const Category = require("../models/categoryModel");
const getAPINews = require("../newsAPI/newsAPI");

/*
- required: title, source, author, url, publishedAt, language, category
- not-required: country, imageURL, content, description
*/

async function seedArticles() {
  try {
    // get all kinds of news, add or update the DB
    const allowedCategories = Category.getAllowedCategories();
    const allowedCountries = Country.getAllowedCountries();
    const allowedLanguages = Language.getAllowedLanguages();

    for (const category of allowedCategories) {
      for (const country of allowedCountries) {
        for (const language of allowedLanguages) {
          let requestedAttrs = {
            category,
            country,
            language,
          };

          let articles = await getAPINews(requestedAttrs);

          for (const curArticle of articles) {
            // api returns: title, source, author, url, publishedAt, imageURL, content, description
            // still missing: countryId, languageId, categoryId

            const title = curArticle.title;
            const publishedAt = curArticle.publishedAt;

            let artExists = await Article.findOne({ title, publishedAt });

            // add missing attrs
            const curCategoryId = await Category.findOne({ name: category });

            const curCountryId = await Country.findOne({ code: country });
            const curLanguageId = await Language.findOne({ code: language });

            curArticle.languageId = curLanguageId._id;
            curArticle.categoryIds = [curCategoryId._id];
            curArticle.countryId = curCountryId._id;

            if (artExists) {
              // one article can have more than 1 category
              if (!artExists.categoryIds.includes(curCategoryId._id)) {
                try {
                  await Article.updateOne(
                    { title, publishedAt },
                    { $push: { categoryIds: curCategoryId._id } }
                  );
                } catch (error) {
                  console.log("Can't update article categories");
                  console.log(error.message);
                }
              }

              // don't add it again => duplicates
              continue;
            }

            try {
              await Article.create(curArticle);
            } catch (error) {
              console.log("Error creating article");
              console.log(error.message);
            }
          }
        }
      }
    }

    console.log("\tArticles seeded successfully");
  } catch (error) {
    console.error("Error seeding articles:", error.message);
  }
}

module.exports = seedArticles;
