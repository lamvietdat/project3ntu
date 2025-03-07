import React, { useState } from 'react';
import { TextField, Button, Container, Box, Typography } from '@mui/material';
import api from '../../services/axios';
import { useNavigate } from "react-router";

const Dangnhap = () => {
    const navigate = useNavigate();

    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    // Handle form submission
    const handleLogin = async (e) => {
        e.preventDefault();

        // Simple validation check
        if (username === '' || password === '') {
            setError('Username and password are required');
            return;
        }

        try {
            // Gọi API login để xác thực người dùng
            const response = await api.post('/login', { username, password });

            // Giả sử API trả về thông tin người dùng với id và username
            console.log(response.data);

            if (response.data) {
                // Lưu thông tin người dùng vào localStorage (bao gồm id và username)
                localStorage.setItem('user', JSON.stringify({
                    id: response.data.user.id,
                    username: response.data.user.Email
                }));
                navigate('/')
            } else {
                setError('Invalid credentials. Please try again.');
            }
        } catch (error) {
            console.error('Lỗi đăng nhập:', error);
            setError('There was an error logging in. Please try again later.');
        }
    };

    return (
        <Container component="main" maxWidth="xs">
            <Box
                sx={{
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                    justifyContent: 'center',
                    padding: 3,
                    backgroundColor: 'white',
                    borderRadius: 2,
                    boxShadow: 3,
                }}
            >
                <Typography variant="h5" gutterBottom>
                    Login
                </Typography>
                <form onSubmit={handleLogin}>
                    <TextField
                        label="Username"
                        variant="outlined"
                        fullWidth
                        margin="normal"
                        value={username}
                        onChange={(e) => setUsername(e.target.value)}
                        required
                    />
                    <TextField
                        label="Password"
                        type="password"
                        variant="outlined"
                        fullWidth
                        margin="normal"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required
                    />
                    {error && (
                        <Typography variant="body2" color="error" align="center">
                            {error}
                        </Typography>
                    )}
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        color="primary"
                        sx={{ mt: 2 }}
                    >
                        Log In
                    </Button>
                </form>
            </Box>
        </Container>
    );
};

export default Dangnhap;
