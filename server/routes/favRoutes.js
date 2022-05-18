const express = require('express')
const router = express.Router()
const favController = require('../controllers/favController')
const { body } = require("express-validator");


router.post(
    "/addFav",
    body("user_id"),
    body("rest_id"),
    favController.addFav
);


module.exports = router