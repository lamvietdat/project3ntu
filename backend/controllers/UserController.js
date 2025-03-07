const User = require('../models/UserModel');
const bcrypt = require('bcrypt')
const getAllUsers = async (req, res) => {
  try {

    const users = await User.getAllUsers();

    res.json(users);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching users' });
  }
};
const registerUser = async (req, res) => {
  const { username: HoTen, email: Email, SoDienThoai, password: MatKhau } = req.body;
  const VaiTro = "HocVien";
  // Validate input
  if (!HoTen || !Email || !SoDienThoai || !MatKhau) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  if (!['HocVien', 'GiaSu', 'QuanTri'].includes(VaiTro)) {
    return res.status(400).json({ message: 'Invalid role provided' });
  }

  try {
    // Check if email or phone number already exists
    const { emailExists, phoneExists } = await User.checkEmailOrPhoneExists(Email, SoDienThoai);

    if (emailExists) {
      return res.status(400).json({ message: 'Email already in use' });
    }

    if (phoneExists) {
      return res.status(400).json({ message: 'Phone number already in use' });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(MatKhau, 10);

    // Insert the user into the database
    await User.createUser(HoTen, Email, SoDienThoai, hashedPassword, VaiTro);

    // Send success response
    res.status(201).json({ message: 'User registered successfully' });
  } catch (err) {
    console.error('Registration error: ', err);
    res.status(500).json({ message: 'Error during registration' });
  }
};


const loginUser = async (req, res) => {
  try {
    // Destructure Email and MatKhau (password) from the request body
    const { username: Email, password: MatKhau } = req.body;
    console.log(Email, MatKhau);

    // Check if both email and password are provided
    if (!Email || !MatKhau) {
      return res.status(400).json({ message: 'Email and password are required' });
    }

    // Call the login function from the model
    const user = await User.login(Email, MatKhau);

    // If login is successful, return user data (excluding sensitive info like password)
    return res.status(200).json({
      message: 'Login successful',
      user: {
        id: user.id,
        HoTen: user.HoTen,
        Email: user.Email,
        VaiTro: user.VaiTro, // You may include more details if needed
      },
    });

  } catch (error) {
    // Log error and send a failure response
    console.error('Login error: ', error);
    return res.status(400).json({ message: error.message || 'Login failed' });
  }
};
module.exports = { getAllUsers, registerUser, loginUser };
