const { connectToDatabase } = require('../config/database');

const getAllAdmin = async () => {
  try {
    const pool = await connectToDatabase();
    const result = await pool.request().query('SELECT * FROM Admin');
    return result.recordset;
  } catch (err) {
    console.error("Error fetching admins: ", err);
    throw new Error('Error fetching admins');
  }
};

module.exports = { getAllAdmin };
