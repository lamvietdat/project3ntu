const connect = require('../config/database');

const getAllDangKyLop = async () => {
  const pool = await connect.connectToDatabase();
  const result = await pool.request().query('SELECT * FROM DangKyLop');
  return result.recordset;
};

module.exports = { getAllDangKyLop };
