const Booking = require('../models/bookingModel');
const { check, validationResult } = require("express-validator/check");

const setBooking = async (req, res) => {
    try {
        var current_status = "created"
        var current_time = new Date()
        const {title, name, timeOfBooking, personCount, comment} = req.body;
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }
        
        const booking = await Booking.create({user_id: req.user.user_id, title: title, name:name, timeOfBooking: timeOfBooking, timeOfOrder: current_time, personCount: personCount, comment: comment, status: current_status})

        res.status(201).json(booking);
    } catch (error) {
        console.error(error);
    }
};

const getBooking = async (req, res) => {
    try {
        const booking = await Booking.find({user_id : req.user.user_id}).exec()
        if(booking){
            res.status(200).json(booking)
            return
        }
        res.status(404).json("Booking not found")
    } catch (error) {
        console.log(error)
    }
}

const confirmBooking = async (req, res) => {
    try {
        _id = req.body
        const booking = await Booking.findById(_id).exec()
        if(booking){
            const confirmation = {status : 'confirmed'}
            await booking.updateOne(confirmation)
            res.status(201).json("Booking confirmed!")
        }
    } catch (error) {
        console.error(error);
    }
}

const cancelBooking = async (req, res) => {
    try {
        _id = req.body
        var current_time = new Date()
        const booking = await Booking.findById(_id).exec()
        if(booking){
            var cancel_time = {status : 'canceled'}
            await booking.updateOne(cancel_time)
            res.status(201).json("Booking canceled at " + current_time)
        }
    } catch (error) {
        console.error(error);
    }
}


module.exports = {
    setBooking,
    getBooking,
    confirmBooking,
    cancelBooking
};