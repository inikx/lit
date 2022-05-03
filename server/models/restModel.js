const mongoose = require('mongoose');

const RestSchema = new mongoose.Schema({
    rest_id:{type: mongoose.Schema.Types.ObjectId, ref: 'Rest', required:true},
    title: {type: String, required: true},
    kitchen: {type: Array},
    address: {type: String, required: true},
    rating: {type: Double, required: true},
    imagePath: {type: String},
    averagePrice: {type: Int},
    description: {type: String},
    shortDescription: {type: String},
    workingHours: {type: String},
    phone: {type: String}
})
var Rest = mongoose.model('Rest', RestSchema)
module.exports = Rest