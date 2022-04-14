
const User = require('./models/userModel');
const db_url = 'mongodb+srv://hutor_admin:slKhYG9GFVO8rq3W@cluster0.9jaeb.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
const express = require('express')
const mongoose = require('mongoose');
const app = express()
const port = 3000

app.use(express.json())
app.post('/', async (req, res) => {
    try {
        console.log(req.body)
        const {email, password} = req.body
        const user = await User.create({email, password})
        console.log(req.body)
        res.status(200).json(user)
    } catch (error) {
        console.error(error)
    }
    
    
})

async function startApp(){
    try {
        await mongoose.connect(db_url, {useUnifiedTopology: true, useNewUrlParser: true})
        app.listen(port) 
    } catch (error) {
        console.log(error)
    }
}

startApp()