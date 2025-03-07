const mssql = require('mssql');
const { connectToDatabase } = require('../config/database');
const bcrypt = require('bcrypt')

// Get all users from the database
const getAllUsers = async () => {
  try {
    const pool = await connectToDatabase();
    const result = await pool.request().query('SELECT * FROM NguoiDung');
    return result.recordset;
  } catch (err) {
    console.error("Error fetching users: ", err);
    throw new Error('Error fetching users');
  }
};

const login = async (Email, MatKhau) => {
  try {
    // Connect to the database
    const pool = await connectToDatabase();

    // Query to find the user by their email
    const result = await pool.request()
      .input('Email', mssql.NVarChar, Email)
      .query('SELECT * FROM NguoiDung WHERE Email = @Email');

    // If no user is found, return an error message
    if (result.recordset.length === 0) {
      throw new Error('User not found');
    }

    // Get the user record from the result
    const user = result.recordset[0];

    // If the provided password matches the stored password, return the user data
    // (Assuming MatKhau is stored as plaintext in your database)
    const isMatch = await bcrypt.compare(MatKhau, user.MatKhau);

    // If the password doesn't match, return an error message
    if (!isMatch) {
      throw new Error('Invalid password');
    }
    return { id: user.ID, HoTen: user.HoTen, Email: user.Email, VaiTro: user.VaiTro };



  } catch (error) {
    console.error("Error during login: ", error.message);
    throw new Error('Login failed');
  }
};

// Check if email or phone exists
const checkEmailOrPhoneExists = async (email, phone) => {
  const pool = await connectToDatabase();

  const emailResult = await pool.request()
    .input('Email', mssql.NVarChar, email)
    .query('SELECT COUNT(*) AS count FROM NguoiDung WHERE Email = @Email');

  const phoneResult = await pool.request()
    .input('SoDienThoai', mssql.NVarChar, phone)
    .query('SELECT COUNT(*) AS count FROM NguoiDung WHERE SoDienThoai = @SoDienThoai');

  return {
    emailExists: emailResult.recordset[0].count > 0,
    phoneExists: phoneResult.recordset[0].count > 0,
  };
};

// Create a new user
const createUser = async (HoTen, Email, SoDienThoai, MatKhau, VaiTro) => {
  const pool = await connectToDatabase();

  await pool.request()
    .input('HoTen', mssql.NVarChar, HoTen)
    .input('Email', mssql.NVarChar, Email)
    .input('SoDienThoai', mssql.NVarChar, SoDienThoai)
    .input('MatKhau', mssql.NVarChar, MatKhau)
    .input('VaiTro', mssql.NVarChar, VaiTro)
    .query('INSERT INTO NguoiDung (HoTen, Email, SoDienThoai, MatKhau, VaiTro) VALUES (@HoTen, @Email, @SoDienThoai, @MatKhau, @VaiTro)');
};

module.exports = { getAllUsers, createUser, checkEmailOrPhoneExists, login };
