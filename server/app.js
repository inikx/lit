const express = require("express");
const morgan = require("morgan");
const cors = require("cors");
const compression = require("compression");
const userRoutes = require("./routes/userRoutes")
const bookingRoutes = require("./routes/bookingRoutes")
const restRoutes = require("./routes/restRoutes")

const app = express();

app.use(express.json());
app.use(morgan("common"));
app.use(compression());
app.use(cors({ credentials: true, origin: true }));
app.use('/api', userRoutes, bookingRoutes, restRoutes)


// Handle undefined Routes
app.use("*", (req, res, next) => {
    
    res.status(404).json({ error: "undefined route" });
});

module.exports = app;