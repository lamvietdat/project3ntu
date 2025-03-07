const ThanhToan = require('../models/thanhToanModel');

const getAllThanhToan = async (req, res) => {
  try {
    const thanhToan = await ThanhToan.getAllThanhToan();
    res.json(thanhToan);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching thanh toan' });
  }
};

module.exports = { getAllThanhToan };
