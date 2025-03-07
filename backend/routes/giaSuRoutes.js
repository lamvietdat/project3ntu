const express = require("express");
const { getAllGiaSu, dangkyGiaSu, getGiasuDk } = require("../controllers/giaSuController");


const route = express.Router()

route.get('/gia-su', getAllGiaSu)
route.get('/gia-sudk', getGiasuDk)
route.post('/dangky-gia-su', dangkyGiaSu)

module.exports = route;