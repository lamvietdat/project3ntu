const express = require("express");
const { getAllUsers, registerUser, loginUser } = require("../controllers/UserController");


const route = express.Router()

route.get('/users', getAllUsers)
route.post('/register', registerUser);
route.post('/login', loginUser);

module.exports = route;