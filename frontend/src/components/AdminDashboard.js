import React from 'react';
import { Link } from 'react-router-dom';
import { Container, Button, Grid } from '@mui/material';

const AdminDashboard = () => {
  return (
    <Container>
      <h1>Trang Quản Lý Admin</h1>
      <Grid container spacing={2}>
        <Grid item xs={12} sm={6}>
          <Button variant="contained" color="primary" component={Link} to="/users">
            Quản lý Người Dùng
          </Button>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Button variant="contained" color="primary" component={Link} to="/gia-su">
            Quản lý Gia Sư
          </Button>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Button variant="contained" color="primary" component={Link} to="/lop-hoc">
            Quản lý Lớp Học
          </Button>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Button variant="contained" color="primary" component={Link} to="/dang-ky-lop">
            Quản lý Đăng Ký Lớp
          </Button>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Button variant="contained" color="primary" component={Link} to="/thanh-toan">
            Quản lý Thanh Toán
          </Button>
        </Grid>
      </Grid>
    </Container>
  );
};

export default AdminDashboard;
