const axios = require("axios");
const cheerio = require("cheerio");
const { get, add } = require("cheerio/lib/api/traversing");
var rest = [];


const parse = async () => {
    var title;
    var rating;
    var averagePrice;
    var shortDescription;
    var subpageUrl;
    var kitchen = [];
    

    const getHTML = async (url) => {
        const { data } = await axios.get(url);
        return cheerio.load(data);
    };

    const $ = await getHTML(
        "https://www.restoclub.ru/spb/search/kitajskie-restorany-v-peterburge"
    );

    const pageNumber = $("a.pagination__item._page").eq(-2).text();
    for (let i = 1; i <= pageNumber; i++) {
        const selector = await getHTML(
            `https://www.restoclub.ru/spb/search/kitajskie-restorany-v-peterburge/${i}`
        );
        selector(".page-search__item").each((i, element) => {
            title = selector(element)
                .find("span.search-place-title__name")
                .text();
            subpageUrl =
                "https://www.restoclub.ru" +
                selector(element)
                    .find("a.search-place-title__link")
                    .attr("href");
            rating = selector(element).find("div.rating__value").text();
            averagePrice = selector(element)
                .find("li.search-place-card__info-item._bill")
                .text();
            shortDescription = selector(element)
                .find("div.search-place-card__about")
                .text();
            kitchen = selector(element)
                .find(".cuisine").toArray().map(child => selector(child).text());
            
            
            

            if (title) {
                rest.push({
                    title: title,
                    kitchen: kitchen,
                    //address: null,
                    rating: rating,
                    imagePath: null,
                    averagePrice: averagePrice,
                    description: null,
                    shortDescription: shortDescription,
                    //workingHours: null,
                    //phone: null,
                    url: subpageUrl,
                });
            }
        });
    }
    //console.log(rest)
    return rest;
    //parseSubPage()
};

const parseSubPage = async (rest) => {
    
    var address;
    var imagePath = [];
    var description;
    var workingHours;
    var phone;

    const getHTML = async (url) => {
        const { data } = await axios.get(url);
        return cheerio.load(data);
    };
     for(var res of rest){
        const $ = await getHTML(res.url)
       
        description = $('div.expandable-text__t').text().split('\n')[0]
        parentAddress = $('h2.place-info__item')
        var  childAddress = 'span.t-dotted'
        imagePath = $('.slider__content')
        .find(".slide").toArray().map(child => $(child).find('img').attr('data-src'));
        //console.log(imagePath)
        address = parentAddress.find(childAddress).text()
        parentData = $('div.place-info__item')
        var  childData = 'div.info__content.d_t-t-b'
        var phone = $('a.place-phone__number').attr('content')
        var data = parentData.find(childData).toArray().map(child => $(child).text());
        //workingHours = data.split('    ')[0]

        rest[rest.indexOf(res)]= Object.assign({}, res, {address: address,
            workingHours: data[0], phone: phone})

        
        //console.log(parentPaths)
        
     }
     
    





    // const $ = await getHTML(rest[0].url)
    // description = $('div.expandable-text__t').text().split('\n')[0]
    // parentAddress = $('h2.place-info__item')
    // var  childAddress = 'span.t-dotted'
    // address = parentAddress.find(childAddress).text()
    // parentData = $('div.place-info__item')
    // var  childData = 'div.info__content.d_t-t-b'
    // var data = parentData.find(childData).text()
    // workingHours = data.split('    ')[0]

    //console.log(description + '\n', address + '\n', workingHours + '\n')
    console.log(rest)
};

(async () => {
    const parsed = await parse();
    parseSubPage(parsed);
    
})();

