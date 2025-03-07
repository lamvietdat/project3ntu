import React, { useState, useEffect } from 'react';
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow } from '@mui/material';
import api from '../../services/axios';

const GiaSuList = () => {
  const [giaSuList, setGiaSuList] = useState([]);

  useEffect(() => {
    const fetchGiaSu = async () => {
      try {
        const res = await api.get('/gia-su');
        setGiaSuList(res.data);
      } catch (err) {
        console.error('Lỗi khi lấy danh sách gia sư: ', err);
      }
    };
    fetchGiaSu();
  }, []);

  return (
    <TableContainer>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell>ID</TableCell>
            <TableCell>Môn học</TableCell>
            <TableCell>Kinh nghiệm</TableCell>
            <TableCell>Học phí</TableCell>
            <TableCell>Xác thực</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {giaSuList.map((giaSu) => (
            <TableRow key={giaSu.ID}>
              <TableCell>{giaSu.ID}</TableCell>
              <TableCell>{giaSu.MonHoc}</TableCell>
              <TableCell>{giaSu.KinhNghiem}</TableCell>
              <TableCell>{giaSu.HocPhi}</TableCell>
              <TableCell>{giaSu.XacThuc ? 'Đã xác thực' : 'Chưa xác thực'}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default GiaSuList;
