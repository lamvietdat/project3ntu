const express = require("express");
const { pool } = require("../db");
const router = express.Router();

// 📌 Lấy danh sách người dùng
router.get("/", async (req, res) => {
  try {
    const result = await pool.request().query("SELECT * FROM NguoiDung");
    res.json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 📌 Thêm người dùng mới
router.post("/", async (req, res) => {
  const { HoTen, Email, SoDienThoai, MatKhau, VaiTro } = req.body;
  try {
    await pool
      .request()
      .input("HoTen", HoTen)
      .input("Email", Email)
      .input("SoDienThoai", SoDienThoai)
      .input("MatKhau", MatKhau)
      .input("VaiTro", VaiTro)
      .query(
        "INSERT INTO NguoiDung (HoTen, Email, SoDienThoai, MatKhau, VaiTro) VALUES (@HoTen, @Email, @SoDienThoai, @MatKhau, @VaiTro)"
      );
    res.status(201).json({ message: "Thêm người dùng thành công!" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 📌 Xóa người dùng
router.delete("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    await pool.request().input("ID", id).query("DELETE FROM NguoiDung WHERE ID = @ID");
    res.json({ message: "Xóa người dùng thành công!" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
