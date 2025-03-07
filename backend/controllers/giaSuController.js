const GiaSu = require('../models/giaSuModel');

const getAllGiaSu = async (req, res) => {
  try {
    const giaSu = await GiaSu.getAllGiaSu();
    res.json(giaSu);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching gia su' });
  }
};
const dangkyGiaSu = async (req, res) => {
  try {
    // Lấy thông tin từ body request
    const { HocVienID, LopID, SoTien } = req.body;
    console.log(req.body);

    // Kiểm tra nếu thông tin không hợp lệ
    if (!HocVienID || !LopID || !SoTien) {
      return res.status(400).json({ message: "Thiếu thông tin yêu cầu." });
    }

    // Gọi service để thực hiện thêm dữ liệu vào cơ sở dữ liệu
    const result = await GiaSu.dangkygiasu(HocVienID, LopID, SoTien);

    // Nếu thành công, trả về phản hồi với dữ liệu đã thêm
    return res.status(201).json({
      message: 'Đăng ký gia sư thành công',
      result: result,
    });

  } catch (error) {
    console.error("Lỗi khi đăng ký gia sư:", error);
    return res.status(500).json({ message: "Lỗi khi xử lý yêu cầu." });
  }
};
const getGiasuDk = async (req, res) => {
  try {
    const giaSu = await GiaSu.getGiasuDk();
    res.json(giaSu);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching gia su' });
  }
};
module.exports = { getAllGiaSu, dangkyGiaSu, getGiasuDk };
