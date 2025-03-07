const connect = require('../config/database');

const getAllThanhToan = async () => {
  const pool = await connect.connectToDatabase();
  const result = await pool.request().query('SELECT * FROM ThanhToan');
  return result.recordset;
};

module.exports = { getAllThanhToan };
