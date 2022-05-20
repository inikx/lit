const Fav = require('../models/favModel');
const Rest = require('../models/restModel');
const { check, validationResult } = require("express-validator/check");

const addFav = async (req, res) => {
    try {
        const {user_id, rest_id} = req.body;
        
            const favList = await Fav.findOne({user_id: user_id}).exec()
            if(favList){
                await Fav.updateOne({user_id: user_id}, {$push: {rest_id : rest_id}});
                res.status(201).json("favorites added");
            } else {
                const favList = await Fav.create({user_id: user_id})
                await Fav.updateOne({user_id: user_id}, {$push: {rest_id : rest_id}});
                res.status(201).json("favorites added");
            }
        
    } catch (error) {
        console.error(error);
    }
};

const deleteFav = async (req, res) => {
    try {
        const {user_id, rest_id} = req.body;
        
            const favList = await Fav.findOne({user_id: user_id}).exec()
            if(favList){
                await Fav.updateOne({user_id: user_id}, {$pull: {rest_id : rest_id}});
                res.status(201).json("favorites deleted");
            } else {
                res.status(404).json("Favs not found");
            }
        
    } catch (error) {
        console.error(error);
    }
};

const showFav = async (req, res) => {
    try {
        const {user_id} = req.body
        const favList = await Fav.findOne({user_id: user_id}).exec()
        const restList = []
        if(favList){
            for(var fav of favList.rest_id){
                const rest = await Rest.findOne({_id: fav._id}).exec()
                restList.push(rest)
            }
            res.status(201).json(restList);
            return
        }
        res.status(404).json("Favs not found")
    } catch (error) {
        console.log(error)
    }
};

module.exports = {
    addFav,
    deleteFav,
    showFav
    
};