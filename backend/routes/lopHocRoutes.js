const express = require("express");
const { getAllLopHoc, themlophoc, xoalophoc, capnhatlopHoc } = require("../controllers/lopHocController");


const route = express.Router()

route.get('/lop-hoc', getAllLopHoc)
route.post('/themlop-hoc', themlophoc)
route.delete('/xoa-lop-hoc/:idlophoc', xoalophoc)
route.put('/capnhat-lop-hoc/:idlophoc', capnhatlopHoc);

module.exports = route;