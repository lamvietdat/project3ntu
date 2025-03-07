const express = require("express");
const { getAllDangKyLop } = require("../controllers/dangKyLopController");


const route = express.Router()

route.get('/dang-ky-lop', getAllDangKyLop)

module.exports = route;