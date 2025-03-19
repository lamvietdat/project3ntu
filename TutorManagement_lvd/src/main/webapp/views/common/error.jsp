<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/common/error.css">
</head>
<body>
    <!-- Thanh điều hướng -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="LVD Tutor" height="30" class="d-inline-block align-text-top">
                Trung tâm Gia sư LVD
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    </li>
                    
                    <c:if test="${loginedUser != null}">
                        <c:choose>
                            <c:when test="${loginedUser.role == 'admin'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/classes">Quản lý lớp học</a>
                                </li>
                            </c:when>
                            <c:when test="${loginedUser.role == 'tutor'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/tutor/dashboard">Bảng điều khiển</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/tutor/classes">Lớp của tôi</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/tutor/profile">Hồ sơ</a>
                                </li>
                            </c:when>
                            <c:when test="${loginedUser.role == 'student'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/student/dashboard">Bảng điều khiển</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/student/browse-classes">Tìm lớp học</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/student/enrollments">Đăng ký của tôi</a>
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
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Tài khoản</a></li>
                                        </c:when>
                                        <c:when test="${loginedUser.role == 'tutor'}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/tutor/profile">Hồ sơ</a></li>
                                        </c:when>
                                        <c:when test="${loginedUser.role == 'student'}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student/dashboard">Tài khoản</a></li>
                                        </c:when>
                                    </c:choose>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <div class="mt-5 mb-5">
                    <i class="bi bi-exclamation-triangle-fill text-danger" style="font-size: 5rem;"></i>
                    <h2 class="mt-3">Đã xảy ra lỗi</h2>
                    <p class="lead">${errorMessage}</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3">Về trang chủ</a>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="bg-dark text-white mt-5 py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>Trung tâm Gia sư LVD</h5>
                    <p>Cung cấp dịch vụ gia sư chất lượng cao</p>
                </div>
                <div class="col-md-4">
                    <h5>Liên hệ</h5>
                    <p>
                        <i class="bi bi-geo-alt"></i> Địa chỉ: Hà Nội, Việt Nam<br>
                        <i class="bi bi-telephone"></i> Điện thoại: 0123 456 789<br>
                        <i class="bi bi-envelope"></i> Email: info@lvdtutor.com
                    </p>
                </div>
                <div class="col-md-4">
                    <h5>Theo dõi chúng tôi</h5>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-white"><i class="bi bi-facebook fs-4"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-youtube fs-4"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-instagram fs-4"></i></a>
                    </div>
                </div>
            </div>
            <hr>
            <div class="text-center">
                <p class="mb-0">&copy; 2023 LVD Tutor. Đã đăng ký bản quyền.</p>
            </div>
        </div>
    </footer>
    
    <script src="/assets/js/jquery-3.6.0.min.js"></script>
    <script src="/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>