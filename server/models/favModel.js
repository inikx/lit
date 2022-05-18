const mongoose = require('mongoose');

const FavSchema = new mongoose.Schema({
    user_id:{type: mongoose.Schema.Types.ObjectId, ref: 'User', required:true},
    rest_id: {type: [mongoose.Schema.Types.ObjectId], ref: 'Rest'},
})
var Fav = mongoose.model('Fav', FavSchema)
module.exports = Fav