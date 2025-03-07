import React, { useState, useEffect } from 'react';
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow } from '@mui/material';
import api from '../../services/axios';

const ThanhToanList = () => {
  const [thanhToanList, setThanhToanList] = useState([]);

  useEffect(() => {
    const fetchThanhToan = async () => {
      try {
        const res = await api.get('/thanh-toan');
        setThanhToanList(res.data);
      } catch (err) {
        console.error('Lỗi khi lấy danh sách thanh toán: ', err);
      }
    };
    fetchThanhToan();
  }, []);

  return (
    <TableContainer>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>ID</TableCell>
            <TableCell>Học viên</TableCell>
            <TableCell>Lớp học</TableCell>
            <TableCell>Số tiền</TableCell>
            <TableCell>Trạng thái</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {thanhToanList.map((thanhToan) => (
            <TableRow key={thanhToan.ID}>
              <TableCell>{thanhToan.ID}</TableCell>
              <TableCell>{thanhToan.HocVienID}</TableCell>
              <TableCell>{thanhToan.LopID}</TableCell>
              <TableCell>{thanhToan.SoTien}</TableCell>
              <TableCell>{thanhToan.TrangThai}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default ThanhToanList;
