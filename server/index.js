const db_url = 'mongodb+srv://hutor_admin:slKhYG9GFVO8rq3W@cluster0.9jaeb.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
const mongoose = require('mongoose');
const port = 3000
const app = require('./app')




async function startApp(){
    try {
        await mongoose.connect(db_url, {useUnifiedTopology: true, useNewUrlParser: true})
        app.listen(port) 
    } catch (error) {
        console.log(error)
    }
}

startApp()