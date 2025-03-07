const LopHoc = require('../models/lopHocModel');

const getAllLopHoc = async (req, res) => {
  try {
    const lopHoc = await LopHoc.getAllLopHoc();
    res.json(lopHoc);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching lop hoc' });
  }
};
const themlophoc = async (req, res) => {
  try {
    const { monhoc, giaSu, lichhoc } = req.body
    const lopHoc = await LopHoc.themlophoc(monhoc, giaSu, lichhoc);
    res.json(lopHoc);
  } catch (err) {
    res.status(500).json({ message: 'Error fetching lop hoc' });
  }
};
const xoalophoc = async (req, res) => {
  try {
    const { idlophoc } = req.params;
    console.log(idlophoc);


    const result = await LopHoc.xoalophoc(idlophoc);

    if (result) {
      res.json({ message: 'Lớp học đã được xóa thành công' });
    } else {
      res.status(404).json({ message: 'Không tìm thấy lớp học với ID này' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Lỗi khi xóa lớp học' });
  }
};
const capnhatlopHoc = async (req, res) => {
  try {
    const { idlophoc } = req.params; // Get the ID of the class to be updated
    const { monhoc, giaSu, lichhoc } = req.body; // Get updated data from the request body

    // Call the service to update the LopHoc
    const result = await LopHoc.capnhatlopHoc(idlophoc, monhoc, giaSu, lichhoc);

    if (result) {
      res.json(result); // Return updated LopHoc data
    } else {
      res.status(404).json({ message: 'Không tìm thấy lớp học' }); // Class not found
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error updating lop hoc' });
  }
};


module.exports = { getAllLopHoc, themlophoc, xoalophoc, capnhatlopHoc };
