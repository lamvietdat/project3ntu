import React, { useState } from 'react';
import { TextField, Button, Container, Box, Typography } from '@mui/material';
import api from '../../services/axios';
import { useNavigate } from "react-router";

const Dangky = () => {
    const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [SoDienThoai, setSoDienThoai] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [error, setError] = useState('');
    const [successMessage, setSuccessMessage] = useState('');
    const navi = useNavigate()
    const handleRegister = async (e) => {
        e.preventDefault();

        if (!username || !email || !password || !confirmPassword || !SoDienThoai) {
            setError('All fields are required');
            return;
        }

        if (password !== confirmPassword) {
            setError('Passwords do not match');
            return;
        }

        try {
            const response = await api.post('/register', { username, email, password, SoDienThoai });
            setSuccessMessage('Registration successful!');
            navi('/dangnhap')
            setError('');
        } catch (err) {
            setError('Error registering user. Please try again.');
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
                    Register
                </Typography>
                <form onSubmit={handleRegister}>
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
                        label="Email"
                        type="email"
                        variant="outlined"
                        fullWidth
                        margin="normal"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                    />
                    <TextField
                        label="SoDienThoai"
                        variant="outlined"
                        fullWidth
                        margin="normal"
                        value={SoDienThoai}
                        onChange={(e) => setSoDienThoai(e.target.value)}
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
                    <TextField
                        label="Confirm Password"
                        type="password"
                        variant="outlined"
                        fullWidth
                        margin="normal"
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        required
                    />
                    {error && (
                        <Typography variant="body2" color="error" align="center" sx={{ mt: 2 }}>
                            {error}
                        </Typography>
                    )}
                    {successMessage && (
                        <Typography variant="body2" color="primary" align="center" sx={{ mt: 2 }}>
                            {successMessage}
                        </Typography>
                    )}
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        color="primary"
                        sx={{ mt: 2 }}
                    >
                        Register
                    </Button>
                </form>
            </Box>
        </Container>
    );
};

export default Dangky;
