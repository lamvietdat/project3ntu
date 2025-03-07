const connect = require('../config/database');
const mssql = require('mssql');

const getAllGiaSu = async () => {
  const pool = await connect.connectToDatabase();
  const result = await pool.request().query('SELECT * FROM GiaSu');
  return result.recordset;
};
const dangkygiasu = async (HocVienID, LopID, SoTien) => {
  try {
    // Tạo kết nối tới cơ sở dữ liệu
    const pool = await connect.connectToDatabase();

    // Sử dụng phương thức `input` để truyền tham số vào câu truy vấn
    const result = await pool.request()
      .input('HocVienID', mssql.Int, HocVienID)
      .input('LopID', mssql.Int, LopID)
      .input('SoTien', mssql.Decimal(10, 2), SoTien)
      .query(`
        INSERT INTO ThanhToan (HocVienID, LopID, SoTien, NgayThanhToan, TrangThai)
        VALUES (@HocVienID, @LopID, @SoTien, GETDATE(), 'ChoDuyet')
      `);

    // Trả về kết quả sau khi thực hiện query
    return result.recordset;
  } catch (error) {
    // Nếu có lỗi, log ra lỗi và ném lại để xử lý ở controller
    console.error("Lỗi khi thêm dữ liệu vào ThanhToan:", error);
    throw error;
  }
};

const getGiasuDk = async () => {
  try {
    const pool = await connect.connectToDatabase();

    // SQL query to select all from Giasu and LopHoc where Giasu.ID == LopHoc.GiaSuID
    const result = await pool.request()
      .query(`
      SELECT 
        lh.ID AS LopHocID, 
        lh.MonHoc, 
        lh.LichHoc, 
        g.KinhNghiem, 
        g.HocPhi
      FROM Giasu g
      JOIN LopHoc lh ON g.ID = lh.GiaSuID
    `);

    return result.recordset;
  } catch (error) {
    console.error("Error fetching data: ", error.message);
    throw new Error('Error fetching data');
  }
};

module.exports = { getAllGiaSu, dangkygiasu, getGiasuDk };
