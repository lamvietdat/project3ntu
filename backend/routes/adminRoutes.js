const express = require("express");
const { getAllAdmin } = require("../controllers/adminController");


const route = express.Router()

route.get('/admin', getAllAdmin)

module.exports = route;