const DanhGia = require('../models/danhGiaModel');

const getAllDanhGia = async (req, res) => {
  try {
    const danhGia = await DanhGia.getAllDanhGia();
    res.json(danhGia);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching danh gia' });
  }
};

module.exports = { getAllDanhGia };
