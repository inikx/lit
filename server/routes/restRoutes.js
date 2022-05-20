const express = require('express')
const router = express.Router()
const restController = require('../controllers/restController')
const { body } = require("express-validator");


router.post(
    "/setRest",
    body("title"),
    body("city"),
    body("kitchen"),
    body("address"),
    body("rating"),
    body("imagePath"),
    body("averagePrice"),
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
router.post("/getAllRestsByCity", body("city"), restController.getAllRestsByCity);

module.exports = router