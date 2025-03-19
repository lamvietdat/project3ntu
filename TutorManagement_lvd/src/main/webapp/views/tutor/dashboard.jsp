<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển Gia sư - Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/tutor/dashboard.css">
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
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/tutor/dashboard">Bảng điều khiển</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/tutor/classes">Lớp của tôi</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/tutor/profile">Hồ sơ</a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> ${loginedUser.fullName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/tutor/profile">Hồ sơ</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                        </ul>
                    </li>
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

        <div class="row mb-4">
            <div class="col">
                <h2>Bảng điều khiển Gia sư</h2>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-journal-richtext text-primary me-3" style="font-size: 2.5rem;"></i>
                            <div>
                                <h6 class="card-subtitle text-muted">Lớp học của tôi</h6>
                                <h2 class="card-title mb-0">${classes.size()}</h2>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/tutor/classes" class="btn btn-outline-primary w-100">Quản lý lớp học</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-mortarboard-fill text-success me-3" style="font-size: 2.5rem;"></i>
                            <div>
                                <h6 class="card-subtitle text-muted">Học viên của tôi</h6>
                                <h2 class="card-title mb-0">${totalStudents}</h2>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/tutor/classes" class="btn btn-outline-success w-100">Xem chi tiết</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-star-fill text-warning me-3" style="font-size: 2.5rem;"></i>
                            <div>
                                <h6 class="card-subtitle text-muted">Đánh giá trung bình</h6>
                                <h2 class="card-title mb-0">
                                    <fmt:formatNumber value="${avgRating}" maxFractionDigits="1" /> <small class="text-muted">/ 5</small>
                                </h2>
                            </div>
                        </div>
                        <div class="progress mb-3">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: ${avgRating * 20}%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Lớp học gần đây</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Tên lớp</th>
                                        <th>Môn học</th>
                                        <th>Trạng thái</th>
                                        <th>Học viên</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${classes}" var="classInfo" begin="0" end="4">
                                        <tr>
                                            <td><a href="${pageContext.request.contextPath}/tutor/classes?action=view&classId=${classInfo.classId}">${classInfo.className}</a></td>
                                            <td>${classInfo.subject.subjectName}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${classInfo.status == 'open'}">
                                                        <span class="badge bg-success">Mở đăng ký</span>
                                                    </c:when>
                                                    <c:when test="${classInfo.status == 'in_progress'}">
                                                        <span class="badge bg-primary">Đang học</span>
                                                    </c:when>
                                                    <c:when test="${classInfo.status == 'completed'}">
                                                        <span class="badge bg-info">Hoàn thành</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <!-- Đếm số học viên trong lớp -->
                                                <c:set var="enrolledCount" value="${enrollmentCounts[classInfo.classId]}" />
                                                <span class="badge bg-secondary">${enrolledCount != null ? enrolledCount : 0} / ${classInfo.maxStudents}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/tutor/classes" class="btn btn-primary btn-sm">Xem tất cả</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Đánh giá gần đây</h5>
                    </div>
                    <ul class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${not empty reviews}">
                                <c:forEach items="${reviews}" var="review" begin="0" end="4">
                                    <li class="list-group-item">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <strong>${review.student.user.fullName}</strong>
                                            <div>
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="bi ${i <= review.rating ? 'bi-star-fill text-warning' : 'bi-star'}"></i>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <p class="mb-1">${review.comment}</p>
                                        <small class="text-muted">
                                            ${review.classInfo.className} | <fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy"/>
                                        </small>
                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li class="list-group-item text-center py-4">
                                    <i class="bi bi-emoji-smile text-muted" style="font-size: 2rem;"></i>
                                    <p class="mt-2 mb-0">Chưa có đánh giá nào.</p>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
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
    
    <script src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>