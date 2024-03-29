const Rest = require('../models/restModel');
const { check, validationResult } = require("express-validator/check");

const setRest = async (req, res) => {
    try {
        const {title, city, kitchen, address, rating, imagePath, averagePrice, shortDescription, workingHours, phone} = req.body;
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }
        
        const rest = await Rest.create({title: title, city: city, kitchen: kitchen, address: address, rating: rating, imagePath: imagePath, averagePrice: averagePrice, shortDescription: shortDescription, workingHours: workingHours, phone:phone})

        res.status(201).json(rest);
    } catch (error) {
        console.error(error);
    }
};

const getRest = async (req, res) => {
    try {
        const _id = req.body
        const rest = await Rest.findOne({_id: _id}).exec()
        if(rest){
            res.status(200).json(rest)
            return
        }
        res.status(404).json("Rest not found")
    } catch (error) {
        console.log(error)
    }
}

const getAllRests = async (req, res) => {
    try {
        const rest = await Rest.find ().exec()
        if(rest){
            res.status(200).json(rest)
            return
        }
        res.status(404).json("Search error")
    } catch (error) {
        console.log(error)
    }
}

const getAllRestsByCity = async (req, res) => {
    try {
        const {city} = req.body
        const rest = await Rest.find({city: city}).exec()
        if(rest){
            res.status(200).json(rest)
            return
        }
        res.status(404).json("Search error")
    } catch (error) {
        console.log(error)
    }
}

module.exports = {
    setRest,
    getRest,
    getAllRests,
    getAllRestsByCity
};