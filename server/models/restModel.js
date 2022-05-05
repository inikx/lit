const mongoose = require('mongoose');

const RestSchema = new mongoose.Schema({
    title: {type: String, required: true},
    kitchen: {type: [String]},
    address: {type: String, required: true},
    rating: {type: String, required: true},
    imagePath: {type: [String]},
    averagePrice: {type: String},
    description: {type: String},
    shortDescription: {type: String},
    workingHours: {type: String},
    phone: {type: String}
})
var Rest = mongoose.model('Rest', RestSchema)
module.exports = Rest