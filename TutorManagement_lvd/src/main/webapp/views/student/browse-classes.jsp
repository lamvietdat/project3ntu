<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm lớp học - Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/student/browse-classes.css">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/student/dashboard">Bảng điều khiển</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/student/browse-classes">Tìm lớp học</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/student/enrollments">Đăng ký của tôi</a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> ${loginedUser.fullName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student/dashboard">Tài khoản</a></li>
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

        <div class="row mb-4 align-items-center">
            <div class="col-md-6">
                <h2>Tìm lớp học</h2>
            </div>
            <div class="col-md-6">
                <div class="input-group">
                    <select class="form-select" id="subjectFilter">
                        <option value="">Tất cả môn học</option>
                        <c:forEach items="${subjects}" var="subject">
                            <option value="${subject.subjectId}" ${param.subjectId == subject.subjectId ? 'selected' : ''}>${subject.subjectName}</option>
                        </c:forEach>
                    </select>
                    <button class="btn btn-primary" type="button" onclick="filterBySubject()">Lọc</button>
                </div>
            </div>
        </div>

        <div class="row">
            <c:choose>
                <c:when test="${not empty classes}">
                    <c:forEach items="${classes}" var="classInfo">
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <div class="card-header bg-primary text-white">
                                    <h5 class="card-title mb-0">${classInfo.className}</h5>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <strong>Môn học:</strong> ${classInfo.subject.subjectName}
                                    </div>
                                    <div class="mb-3">
                                        <strong>Gia sư:</strong> ${classInfo.tutor.user.fullName}
                                    </div>
                                    <div class="mb-3">
                                        <strong>Thời gian:</strong>
                                        <div>
                                            <fmt:formatDate value="${classInfo.startDate}" pattern="dd/MM/yyyy"/> - 
                                            <fmt:formatDate value="${classInfo.endDate}" pattern="dd/MM/yyyy"/>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <strong>Lịch học:</strong> ${classInfo.schedule}
                                    </div>
                                    <div class="mb-3">
                                        <strong>Học phí:</strong> <fmt:formatNumber value="${classInfo.price}" type="currency" currencySymbol="₫"/>
                                    </div>
                                    <div>
                                        <strong>Sĩ số:</strong> 
                                        <span class="badge bg-secondary">${enrollmentCounts[classInfo.classId]} / ${classInfo.maxStudents}</span>
                                    </div>
                                </div>
                                <div class="card-footer d-grid">
                                    <a href="${pageContext.request.contextPath}/student/browse-classes?action=view&classId=${classInfo.classId}" class="btn btn-primary">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-search text-muted" style="font-size: 4rem;"></i>
                        <h4 class="mt-3">Không tìm thấy lớp học</h4>
                        <p class="text-muted">Không có lớp học nào phù hợp với tiêu chí tìm kiếm của bạn.</p>
                        <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">Xem tất cả lớp học</a>
                    </div>
                </c:otherwise>
            </c:choose>
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
    <script>
        function filterBySubject() {
            const subjectId = document.getElementById("subjectFilter").value;
            if (subjectId) {
                window.location.href = "${pageContext.request.contextPath}/student/browse-classes?subjectId=" + subjectId;
            } else {
                window.location.href = "${pageContext.request.contextPath}/student/browse-classes";
            }
        }
    </script>
</body>
</html>