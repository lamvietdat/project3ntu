import React, { useState, useEffect } from 'react';
import { Button, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, TextField, Select, MenuItem, InputLabel, FormControl } from '@mui/material';
import api from '../../services/axios';

const LopHocList = () => {
  const [lopHocList, setLopHocList] = useState([]);
  const [monhoc, setMonhoc] = useState('');
  const [lichhoc, setLichhoc] = useState('');
  const [giaSu, setGiasu] = useState([]);
  const [selectedGiaSu, setSelectedGiaSu] = useState('');
  const [editingLopHoc, setEditingLopHoc] = useState(null); // Track which class is being edited

  useEffect(() => {
    const fetchLopHoc = async () => {
      try {
        const res = await api.get('/lop-hoc');
        setLopHocList(res.data);
      } catch (err) {
        console.error('Lỗi khi lấy danh sách lớp học: ', err);
      }
    };
    fetchLopHoc();
  }, []);

  useEffect(() => {
    const fetchGiasu = async () => {
      try {
        const res = await api.get('/gia-su');
        setGiasu(res?.data);
      } catch (err) {
        console.error('Lỗi khi lấy danh sách gia sư: ', err);
      }
    };
    fetchGiasu();
  }, []);

  const handleAddlop = async () => {
    try {
      const result = await api.post('/themlop-hoc', {
        monhoc,
        lichhoc,
        giaSu: selectedGiaSu,
      });
      console.log("Lớp học đã được thêm:", result);
      setLopHocList([...lopHocList, result.data]);
    } catch (error) {
      console.error("Lỗi khi thêm lớp học:", error);
    }
  };

  const handleEdit = (lopHoc) => {
    setEditingLopHoc(lopHoc);
    setMonhoc(lopHoc.MonHoc);
    setLichhoc(lopHoc.LichHoc);
    setSelectedGiaSu(lopHoc.GiaSuID);
  };

  const handleUpdate = async () => {
    try {
      const result = await api.put(`/capnhat-lop-hoc/${editingLopHoc.ID}`, {
        monhoc,
        lichhoc,
        giaSu: selectedGiaSu,
      });

      const updatedLopHocList = lopHocList.map(lopHoc =>
        lopHoc.ID === editingLopHoc.ID ? result.data : lopHoc
      );
      setLopHocList(updatedLopHocList);
      setEditingLopHoc(null); // Reset editing state
      console.log("Lớp học đã được cập nhật:", result);
    } catch (error) {
      console.error("Lỗi khi cập nhật lớp học:", error);
    }
  };

  const handleDelete = async (id) => {
    try {
      await api.delete(`/xoa-lop-hoc/${id}`);

      setLopHocList(lopHocList.filter(lopHoc => lopHoc.ID !== id));

      console.log("Lớp học đã được xóa:", id);
    } catch (error) {
      console.error("Lỗi khi xóa lớp học:", error);
    }
  };

  return (
    <TableContainer>
      <TextField
        label="Môn học"
        variant="outlined"
        fullWidth
        value={monhoc}
        onChange={(e) => setMonhoc(e.target.value)}
        style={{ marginBottom: '16px' }}
      />
      <TextField
        label="Lịch học"
        variant="outlined"
        fullWidth
        value={lichhoc}
        onChange={(e) => setLichhoc(e.target.value)}
        style={{ marginBottom: '16px' }}
      />

      {/* Dropdown to select GiaSu */}
      <FormControl fullWidth style={{ marginBottom: '16px' }}>
        <InputLabel id="giaSu-label">Giá sư</InputLabel>
        <Select
          labelId="giaSu-label"
          value={selectedGiaSu}
          onChange={(e) => setSelectedGiaSu(e.target.value)}
          label="Giá sư"
        >
          {giaSu.map((giasu) => (
            <MenuItem key={giasu.ID} value={giasu.ID}>
              {giasu.ID} {/* Assuming HoTen is the name of the teacher */}
            </MenuItem>
          ))}
        </Select>
      </FormControl>

      <Button onClick={editingLopHoc ? handleUpdate : handleAddlop}>
        {editingLopHoc ? 'Cập nhật lớp học' : 'Thêm lớp học'}
      </Button>

      <Table>
        <TableHead>
          <TableRow>
            <TableCell>ID</TableCell>
            <TableCell>Môn học</TableCell>
            <TableCell>Giá sư</TableCell>
            <TableCell>Lịch học</TableCell>
            <TableCell>Trạng thái</TableCell>
            <TableCell>Hành động</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {lopHocList.map((lopHoc) => (
            <TableRow key={lopHoc.ID}>
              <TableCell>{lopHoc.ID}</TableCell>
              <TableCell>{lopHoc.MonHoc}</TableCell>
              <TableCell>{lopHoc.GiaSuID}</TableCell>
              <TableCell>{lopHoc.LichHoc}</TableCell>
              <TableCell>{lopHoc.TrangThai}</TableCell>
              <TableCell>
                <Button onClick={() => handleEdit(lopHoc)} color="primary">
                  Sửa
                </Button>
                <Button onClick={() => handleDelete(lopHoc.ID)} color="secondary">
                  Xóa
                </Button>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default LopHocList;
