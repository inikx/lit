const mongoose = require('mongoose');

const BookingSchema = new mongoose.Schema({
    user_id:{type: mongoose.Schema.Types.ObjectId, ref: 'User', required:true},
    title: {type: String, required: true},
    name: {type: String, required: true},
    timeOfBooking: {type: Date, required: true},
    timeOfOrder: {type: Date, required: true},
    personCount: {type: Number, required: true},
    comment: {type: String},
    status: {type: String, required: true},
    phone: {type: String, required: true},
})
var Booking = mongoose.model('Booking', BookingSchema)
module.exports = Booking