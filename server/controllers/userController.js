const User = require('../models/userModel');

const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");





const { check, validationResult } = require("express-validator/check");

const register = async (req, res) => {
    try {
        
        const {email, password, city } = req.body;
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }
        const old_user = await User.findOne({email}).exec()
        if(old_user){
            res.status(400).json("Email already registered")
            return
        }
        var encryptedPassword = await bcrypt.hash(password, 10);
        const user = await User.create({email: email.toLowerCase(), password:encryptedPassword, city: city})

        res.status(201).json(user);
    } catch (error) {
        console.error(error);
    }
};

const authenticate = async (req, res) => {
    try {
        res.status(200).json("authenticated!");
    } catch (error) {
        console.error(error);
    }
};

const login = async (req, res) => {
    try {
        const { email, password} = req.body;

        if (!(email && password)) {
            res.status(400).json("all inputs is required");
            return;
        }
        const user = await User.findOne({email}).exec()
        if (user && (await bcrypt.compare(password, user.password))) {
            // create token
            const token = jwt.sign(
                { user_id: user.id, email },
                'HESOYAM228',
                {
                    expiresIn: "24h",
                }
            );
            user.token = token;

            // return user
            res.status(200).json({
                token,
                email: user.email,
            });
            return;
        }
        res.status(400).json("invalid credentials");
    } catch (error) {
        console.error(error);
    }
};

module.exports = {
    register,
    login,
    authenticate,
};







