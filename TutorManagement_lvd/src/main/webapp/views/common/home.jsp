<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/common/home.css">
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang chủ</a>
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

        <section class="hero-section py-5 text-center text-white bg-primary">
            <div class="container">
                <h1 class="display-4">Chào mừng đến với Trung tâm Gia sư LVD</h1>
                <p class="lead">Nơi kết nối gia sư chất lượng với học viên tại Việt Nam</p>
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-light btn-lg me-2">Đăng ký ngay</a>
                    <a href="#featured-classes" class="btn btn-outline-light btn-lg">Xem lớp học</a>
                </div>
            </div>
        </section>

        <section id="featured-classes" class="py-5">
            <div class="container">
                <h2 class="text-center mb-4">Lớp học nổi bật</h2>
                
                <div class="row">
                    <c:forEach items="${openClasses}" var="classInfo" begin="0" end="3">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-header bg-primary text-white">
                                    <h5 class="card-title mb-0">${classInfo.className}</h5>
                                </div>
                                <div class="card-body">
                                    <p class="card-text"><strong>Môn học:</strong> ${classInfo.subject.subjectName}</p>
                                    <p class="card-text"><strong>Gia sư:</strong> ${classInfo.tutor.user.fullName}</p>
                                    <p class="card-text"><strong>Lịch học:</strong> ${classInfo.schedule}</p>
                                    <p class="card-text"><strong>Học phí:</strong> <fmt:formatNumber value="${classInfo.price}" type="currency" currencySymbol="₫"/></p>
                                </div>
                                <div class="card-footer">
                                    <c:choose>
                                        <c:when test="${loginedUser.role == 'student'}">
                                            <a href="${pageContext.request.contextPath}/student/browse-classes?action=view&classId=${classInfo.classId}" class="btn btn-primary w-100">Xem chi tiết</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary w-100">Đăng nhập để đăng ký</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-outline-primary">Xem tất cả lớp học</a>
                </div>
            </div>
        </section>

        <section class="py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-4">Gia sư nổi bật</h2>
                
                <div class="row">
                    <c:forEach items="${tutors}" var="tutor" begin="0" end="3">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <div class="mb-3">
                                        <img src="${pageContext.request.contextPath}/assets/img/tutors/avatar.jpg" alt="${tutor.user.fullName}" class="rounded-circle" width="100" height="100">
                                    </div>
                                    <h5 class="card-title">${tutor.user.fullName}</h5>
                                    <p class="card-text text-muted">${tutor.qualification}</p>
                                    <p class="card-text">${tutor.experience}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="py-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <h2>Tại sao chọn Trung tâm Gia sư LVD?</h2>
                        <ul class="list-unstyled mt-4">
                            <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Đội ngũ gia sư chất lượng cao, có bằng cấp và kinh nghiệm</li>
                            <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Chương trình học đa dạng, phù hợp với nhiều đối tượng học viên</li>
                            <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Học phí hợp lý, minh bạch</li>
                            <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Hỗ trợ học viên 24/7</li>
                            <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Cam kết đảm bảo chất lượng</li>
                        </ul>
                    </div>
                    <div class="col-lg-6">
                        <img src="${pageContext.request.contextPath}/assets/img/about.jpg" alt="Về chúng tôi" class="img-fluid rounded">
                    </div>
                </div>
            </div>
        </section>
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