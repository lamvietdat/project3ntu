import React, { useEffect, useState } from 'react'
import api from '../../services/axios'
import { Card, CardContent, Typography, Grid, Container, Button, Snackbar, Alert } from '@mui/material'

function Home() {
    const [giasu, setGiasu] = useState([]);  // Lưu danh sách gia sư
    const [openSnackbar, setOpenSnackbar] = useState(false); // Để hiển thị thông báo thành công hoặc lỗi
    const [snackbarMessage, setSnackbarMessage] = useState(""); // Nội dung thông báo
    console.log(giasu);

    // Hàm đăng ký gia sư
    const handledangkygiasu = async (LopID, SoTien) => {
        try {
            const HocVienID = JSON.parse(localStorage.getItem("user"))?.id;  // Lấy ID từ localStorage

            // Nếu không có HocVienID thì không thực hiện gì
            if (!HocVienID) {
                setSnackbarMessage("Vui lòng đăng nhập để đăng ký gia sư!");
                setOpenSnackbar(true);
                return;
            }

            // Gọi API để đăng ký gia sư
            const response = await api.post('/dangky-gia-su', {
                HocVienID,
                LopID,
                SoTien,
            });

            // Kiểm tra phản hồi từ server
            if (response.status === 201) {
                setSnackbarMessage("Đăng ký gia sư thành công!");
                setOpenSnackbar(true);
            }
        } catch (error) {
            console.error("Lỗi khi đăng ký gia sư:", error);
            setSnackbarMessage("Đã xảy ra lỗi. Vui lòng thử lại!");
            setOpenSnackbar(true);
        }
    };

    // Fetch dữ liệu gia sư từ API
    useEffect(() => {
        const fetchGiasu = async () => {
            try {
                const re = await api.get('/gia-sudk');
                // setGiasu(re);
                console.log(re?.data);
                setGiasu(re?.data)


            } catch (error) {
                console.error("Lỗi khi tải dữ liệu", error);
            }
        };
        fetchGiasu();
    }, []);

    return (
        <Container>
            <Typography variant="h4" gutterBottom align="center">
                Các Gia Sư Nổi Bật
            </Typography>

            <Grid container spacing={4} justifyContent="center">
                {giasu.map((item, i) => (
                    <Grid item xs={12} sm={6} md={4} key={i}>
                        <Card>
                            <CardContent>
                                <Typography variant="h6" gutterBottom>Lớp: {item?.MonHoc} 3</Typography>
                                <Typography variant="h6" gutterBottom>Môn: {item?.MonHoc}</Typography>
                                <Typography variant="h6" gutterBottom>Kinh nghiệm: {item?.KinhNghiem} Năm</Typography>
                                <Typography variant="h6" gutterBottom>Địa chỉ: Hà Nội</Typography>
                                <Typography variant="h6" gutterBottom>Giá: {item?.HocPhi}  Vnđ/tiếng</Typography>
                                <Button
                                    variant="contained"
                                    color="primary"
                                    onClick={() => handledangkygiasu(item?.LopHocID, item?.HocPhi)}
                                >
                                    Đăng ký Gia sư
                                </Button>
                            </CardContent>
                        </Card>
                    </Grid>
                ))}
            </Grid>

            {/* Hiển thị thông báo khi có kết quả */}
            <Snackbar
                open={openSnackbar}
                autoHideDuration={6000}
                onClose={() => setOpenSnackbar(false)}
            >
                <Alert
                    onClose={() => setOpenSnackbar(false)}
                    severity={snackbarMessage.includes("thành công") ? "success" : "error"}
                >
                    {snackbarMessage}
                </Alert>
            </Snackbar>
        </Container>
    );
}

export default Home;
