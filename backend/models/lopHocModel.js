const connect = require('../config/database');
const mssql = require('mssql');

const getAllLopHoc = async () => {
  const pool = await connect.connectToDatabase();
  const result = await pool.request().query('SELECT * FROM LopHoc');
  return result.recordset;
};

const themlophoc = async (monhoc, giaSu, lichhoc) => {
  const pool = await connect.connectToDatabase();

  const result = await pool.request()
    .input('MonHoc', mssql.NVarChar, monhoc)
    .input("GiaSuID", mssql.Int, giaSu)  // Assuming GiaSuID is an integer, change if needed
    .input("LichHoc", mssql.NVarChar, lichhoc)
    .query(`
      INSERT INTO LopHoc (GiaSuID, MonHoc, LichHoc, TrangThai) 
      VALUES (@GiaSuID, @MonHoc, @LichHoc, 'Mo')
    `);

  return result.recordset;  // Returns the inserted records, if needed
};
const xoalophoc = async (idlophoc) => {
  const pool = await connect.connectToDatabase();

  try {
    // Execute the DELETE query to remove the class by its ID
    const result = await pool.request()
      .input('ID', mssql.Int, idlophoc)  // Assuming ID is of type INT
      .query(`
        DELETE FROM LopHoc 
        WHERE ID = @ID
      `);

    // Check if any row was affected
    if (result.rowsAffected[0] > 0) {
      return { message: "Lớp học đã được xóa thành công." };
    } else {
      return { message: "Không tìm thấy lớp học với ID này." };
    }
  } catch (error) {
    console.error("Error deleting class:", error);
    return { message: "Lỗi khi xóa lớp học." };
  }
};


const capnhatlopHoc = async (idlophoc, monhoc, giaSu, lichhoc) => {
  const pool = await connect.connectToDatabase();

  try {
    // SQL query to update the LopHoc
    const result = await pool.request()
      .input('ID', mssql.Int, idlophoc)
      .input('MonHoc', mssql.NVarChar, monhoc)
      .input('GiaSu', mssql.Int, giaSu)
      .input('LichHoc', mssql.NVarChar, lichhoc)
      .query(`
        UPDATE LopHoc 
        SET MonHoc = @MonHoc, GiaSuID = @GiaSu, LichHoc = @LichHoc 
        WHERE ID = @ID
        SELECT * FROM LopHoc WHERE ID = @ID
      `);

    return result.recordset[0]; // Return the updated LopHoc data
  } catch (err) {
    console.error(err);
    return null; // Return null if there's an error
  }
};

module.exports = { getAllLopHoc, themlophoc, xoalophoc, capnhatlopHoc };
