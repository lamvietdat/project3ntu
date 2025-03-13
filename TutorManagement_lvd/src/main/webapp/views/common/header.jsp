<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="/common/home">
                    <img src="/assets/img/logo.png" alt="LVD Tutor" height="30" class="d-inline-block align-text-top">
                    Trung tâm Gia sư LVD
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/common/home">Trang chủ</a>
                        </li>
                        
                        <c:if test="${loginedUser != null}">
                            <c:choose>
                                <c:when test="${loginedUser.role == 'admin'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="/admin/dashboard">Bảng điều khiển</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/admin/users">Quản lý người dùng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/admin/classes">Quản lý lớp học</a>
                                    </li>
                                </c:when>
                                <c:when test="${loginedUser.role == 'tutor'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="/tutor/dashboard">Bảng điều khiển</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/tutor/classes">Lớp của tôi</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/tutor/profile">Hồ sơ</a>
                                    </li>
                                </c:when>
                                <c:when test="${loginedUser.role == 'student'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="/student/dashboard">Bảng điều khiển</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/student/browse-classes">Tìm lớp học</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/student/enrollments">Đăng ký của tôi</a>
                                    </li>
                                </c:when>
                            </c:choose>
                        </c:if>
                    </ul>
                    
                    <ul class="navbar-nav">
                        <c:choose>
                            <c:when test="${loginedUser != null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle"></i> ${loginedUser.fullName}
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <c:choose>
                                            <c:when test="${loginedUser.role == 'admin'}">
                                                <li><a class="dropdown-item" href="/admin/dashboard">Tài khoản</a></li>
                                            </c:when>
                                            <c:when test="${loginedUser.role == 'tutor'}">
                                                <li><a class="dropdown-item" href="/tutor/profile">Hồ sơ</a></li>
                                            </c:when>
                                            <c:when test="${loginedUser.role == 'student'}">
                                                <li><a class="dropdown-item" href="/student/dashboard">Tài khoản</a></li>
                                            </c:when>
                                        </c:choose>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="/common/logout">Đăng xuất</a></li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="/common/login">Đăng nhập</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/common/register">Đăng ký</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    
    <div class="container mt-4">
        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <!-- Hiển thị thông báo thành công nếu có -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>