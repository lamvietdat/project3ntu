const express = require("express");
const { getAllDanhGia } = require("../controllers/danhGiaController");


const route = express.Router()

route.get('/danh-gia', getAllDanhGia)

module.exports = route;