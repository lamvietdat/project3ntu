const DangKyLop = require('../models/dangKyLopModel');

const getAllDangKyLop = async (req, res) => {
  try {
    const dangKyLop = await DangKyLop.getAllDangKyLop();
    res.json(dangKyLop);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching dang ky lop' });
  }
};

module.exports = { getAllDangKyLop };
