import React from 'react';
import { Link } from 'react-router-dom';
import { AppBar, Toolbar, Typography, Box } from '@mui/material';

const Header = () => {
    return (
        <AppBar position="sticky">
            <Toolbar>
                {/* Title */}
                <Typography variant="h6" sx={{ flexGrow: 1 }}>
                    Tutor Management
                </Typography>

                {/* Navigation Links */}
                <Box>
                    <Link
                        to="/admin"
                        style={{
                            textDecoration: 'none',
                            color: 'white',
                            margin: '0 10px',
                            padding: '8px',
                            borderRadius: '4px',
                            transition: 'background-color 0.3s'
                        }}
                        onMouseEnter={(e) => e.target.style.backgroundColor = '#3f51b5'}
                        onMouseLeave={(e) => e.target.style.backgroundColor = 'transparent'}
                    >
                        Admin Dashboard
                    </Link>

                    <Link
                        to="/dangky"
                        style={{
                            textDecoration: 'none',
                            color: 'white',
                            margin: '0 10px',
                            padding: '8px',
                            borderRadius: '4px',
                            transition: 'background-color 0.3s'
                        }}
                        onMouseEnter={(e) => e.target.style.backgroundColor = '#3f51b5'}
                        onMouseLeave={(e) => e.target.style.backgroundColor = 'transparent'}
                    >
                        Đăng Ký
                    </Link>

                    <Link
                        to="/dangnhap"
                        style={{
                            textDecoration: 'none',
                            color: 'white',
                            margin: '0 10px',
                            padding: '8px',
                            borderRadius: '4px',
                            transition: 'background-color 0.3s'
                        }}
                        onMouseEnter={(e) => e.target.style.backgroundColor = '#3f51b5'}
                        onMouseLeave={(e) => e.target.style.backgroundColor = 'transparent'}
                    >
                        Đăng Nhập
                    </Link>
                </Box>
            </Toolbar>
        </AppBar>
    );
};

export default Header;
