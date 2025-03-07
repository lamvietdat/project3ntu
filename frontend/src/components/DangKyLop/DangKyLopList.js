import React, { useState, useEffect } from 'react';
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow } from '@mui/material';
import api from '../../services/axios';

const DangKyLopList = () => {
  const [dangKyLopList, setDangKyLopList] = useState([]);

  useEffect(() => {
    const fetchDangKyLop = async () => {
      try {
        const res = await api.get('/dang-ky-lop');
        setDangKyLopList(res.data);
      } catch (err) {
        console.error('Lỗi khi lấy danh sách đăng ký lớp: ', err);
      }
    };
    fetchDangKyLop();
  }, []);

  return (
    <TableContainer>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>ID</TableCell>
            <TableCell>Học viên</TableCell>
            <TableCell>Lớp học</TableCell>
            <TableCell>Trạng thái</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {dangKyLopList.map((dangKy) => (
            <TableRow key={dangKy.ID}>
              <TableCell>{dangKy.ID}</TableCell>
              <TableCell>{dangKy.HocVienID}</TableCell>
              <TableCell>{dangKy.LopID}</TableCell>
              <TableCell>{dangKy.TrangThai}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default DangKyLopList;
