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

router.post(
    "/deleteFav",
    body("user_id"),
    body("rest_id"),
    favController.deleteFav
);

router.post(
    "/showFav",
    body("user_id"),
    favController.showFav
);

module.exports = router