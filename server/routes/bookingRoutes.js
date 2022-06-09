const express = require('express')
const router = express.Router()
const bookingController = require('../controllers/bookingController')
const { body } = require("express-validator");
const auth = require('../middleware/auth')

router.post(
    "/setBooking",
    auth,
    body("name"),
    body("timeOfBooking"),
    body("timeOfOrder"),
    body("personCount"),
    body("comment"),
    body("status"),
    body("phone"),
    bookingController.setBooking
);

router.get("/getBooking", auth, bookingController.getBooking);
router.post("/confirmBooking", bookingController.confirmBooking)
router.post("/cancelBooking", bookingController.cancelBooking)
module.exports = router

