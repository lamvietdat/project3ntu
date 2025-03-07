const mssql = require('mssql');
const dotenv = require('dotenv');
dotenv.config();

// Database connection config
const dbConfig = {
  server: "LOQ", // Ensure correct server name
  database: "TutorManagement",
  user: "sa", // Ensure credentials are correct
  password: "1",  // Ensure credentials are correct
  port: 1433,
  options: {
    encrypt: false, // Set to `false` if no SSL
    trustServerCertificate: true, // Trust certificate if needed
  },
};

// Connect to database
const connectToDatabase = async () => {
  try {
    const pool = await mssql.connect(dbConfig); // Connect using dbConfig
    console.log('Successfully connected to the database');
    return pool;  // Return the pool to use it in queries
  } catch (err) {
    console.error('Error connecting to the database: ', err);
    throw err;
  }
};

module.exports = { connectToDatabase, dbConfig };
