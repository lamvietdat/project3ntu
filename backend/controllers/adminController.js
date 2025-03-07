const Admin = require('../models/adminModel');

const getAllAdmin = async (req, res) => {
  try {
    const admin = await Admin.getAllAdmin();
    res.json(admin);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching admin' });
  }
};

module.exports = { getAllAdmin };
