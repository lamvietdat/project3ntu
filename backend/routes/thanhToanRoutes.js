const express = require("express");
const { getAllDangKyLop } = require("../controllers/dangKyLopController");
const { getAllThanhToan } = require("../controllers/thanhToanController");


const route = express.Router()

route.get('/thanh-toan', getAllThanhToan)

module.exports = route;