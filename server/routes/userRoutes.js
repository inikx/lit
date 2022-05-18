const express = require('express')
const router = express.Router()
const userController = require('../controllers/userController')
const auth = require("../middleware/auth");
const { body } = require("express-validator");

// Get user from database
router.post(
    "/register",
    body("email").isEmail(),
    body("password").isLength({ min: 5, max: 25 }),
    body("city"),
    userController.register
);
router.post("/login", userController.login);
router.get("/auth", auth, userController.authenticate);
router.post("/showUser",
    body("user_id"),
    userController.showUser
    );
module.exports = router