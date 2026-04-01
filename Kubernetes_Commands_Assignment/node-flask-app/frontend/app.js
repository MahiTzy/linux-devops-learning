const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');

const app = express();

const BACKEND_URL = process.env.BACKEND_URL;

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.render('form');
});

app.post('/submit', async (req, res) => {
    try {
        await axios.post('http://BACKEND_URL/submit', {
            name: req.body.name,
            grade: req.body.grade
        });
        res.send("Data submitted successfully");
    } catch (err) {
        res.send("Error: " + err.message);
    }
});

app.listen(3000, () => console.log("Frontend running on port 3000"));
