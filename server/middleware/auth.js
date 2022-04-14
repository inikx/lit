const jwt = require("jsonwebtoken");

const config = process.env;

// verify token
const verifyToken = (req, res, next) => {
    const token =
        req.body.token || req.query.token || req.headers["x-access-token"];

    if (!token) {
        return res.status(403).json("A token is required for authentication");
    }
    try {
        // decode token and return user
        const decoded = jwt.verify(token, 'HESOYAM228');
        req.user = decoded;
        console.log();
    } catch (err) {
        return res.status(401).json("Invalid Token");
    }
    return next();
};

module.exports = verifyToken;