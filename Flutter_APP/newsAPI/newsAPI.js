// we need axios to make HTTP requests
const axios = require("axios");

// and we need jsdom and Readability to parse the article HTML
const { JSDOM } = require("jsdom");
const { Readability, isProbablyReaderable } = require("@mozilla/readability");

const NewsAPI = require("newsapi");

// make newsAPI object
const newsapi = new NewsAPI(process.env.NEWS_API_KEY);

async function getAPINews(requestedFields) {
  let result = [];

  try {
    console.log(requestedFields);
    const response = await newsapi.v2.topHeadlines(requestedFields);

    if (response.status === "ok") {
      let articles = response.articles; // reponse{status, articles}
      console.log(articles.length);
      for (const apiArticle of articles) {
        let curArticle = extractArticle(apiArticle);
        curArticle.content = await getContent(curArticle.url);
        result.push(curArticle);
      }
    } else {
      console.log(`Error fetching data from API, code: ${response.code}`);
      console.log(response.message);
    }
  } catch (error) {
    console.log(error);
  }
  return result;
}

function extractArticle(apiArticle) {
  let article = {};
  article.title = apiArticle.title;
  article.source = apiArticle.source.name;
  article.author = apiArticle.author;
  article.url = apiArticle.url;
  article.publishedAt = apiArticle.publishedAt;
  article.imageURL = apiArticle.urlToImage;
  article.content = apiArticle.content;
  article.description = apiArticle.description;

  return article;
}

async function getContent(url) {
  let articleContent = null;

  try {
    const r2 = await axios.get(url);
    let dom = new JSDOM(r2.data, {
      url: url,
    });

    // if it can be read
    if (isProbablyReaderable(dom.window.document)) {
      // TODO: is this try catch necessary ?

      let response = new Readability(dom.window.document).parse();
      articleContent = response.textContent;
    }
  } catch (error) {
    console.log("Readability error, can't get article content");
  }

  return articleContent;
}

module.exports = getAPINews;
