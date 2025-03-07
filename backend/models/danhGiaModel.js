const connect = require('../config/database');

const getAllDanhGia = async () => {
  const pool = await connect.connectToDatabase();
  const result = await pool.request().query('SELECT * FROM DanhGia');
  return result.recordset;
};

module.exports = { getAllDanhGia };
