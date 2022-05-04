const axios = require("axios");
const cheerio = require("cheerio");
const pretty = require("pretty");
const puppeteer = require("puppeteer");


(async () => {
    const browser = await puppeteer.launch();

    

    await browser.close();
})();