const express = require('express')
const router = express.Router()
const restController = require('../controllers/restController')
const { body } = require("express-validator");


router.post(
    "/setRest",
    body("title"),
    body("kitchen"),
    body("address"),
    body("rating"),
    body("imagePath"),
    body("averagePrice"),
    body("description"),
    body("shortDescription"),
    body("workingHours"),
    body("phone"),
    restController.setRest
);

router.post("/getRest",
    body("rest_id"),
    restController.getRest
    );
    
router.get("/getAllRests", restController.getAllRests);

module.exports = router