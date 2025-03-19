<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển Học viên - Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/student/dashboard.css">
    <style>
        /* Styling cho rating stars */
        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
        }

        .rating input {
            display: none;
        }

        .rating label {
            cursor: pointer;
            width: 30px;
            height: 30px;
            margin: 0 5px;
            position: relative;
            background-color: #ccc;
            clip-path: polygon(50% 0%, 61% 35%, 98% 35%, 68% 57%, 79% 91%, 50% 70%, 21% 91%, 32% 57%, 2% 35%, 39% 35%);
        }

        .rating label:hover,
        .rating label:hover ~ label,
        .rating input:checked ~ label {
            background-color: #ffcc00;
        }
    </style>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/student/dashboard">Bảng điều khiển</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/student/browse-classes">Tìm lớp học</a>
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

        <div class="row mb-4">
            <div class="col">
                <h2>Bảng điều khiển Học viên</h2>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <img src="${pageContext.request.contextPath}/assets/img/avatar.jpg" alt="${student.user.fullName}" class="rounded-circle mb-3" width="100" height="100">
                        <h5>${student.user.fullName}</h5>
                        <p class="text-muted">${student.educationLevel != null ? student.educationLevel : 'Chưa cập nhật trình độ học vấn'}</p>
                        <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#profileModal">
                            <i class="bi bi-pencil-square"></i> Cập nhật hồ sơ
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card h-100">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Thông tin cá nhân</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Email:</div>
                            <div class="col-md-8">${student.user.email}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Số điện thoại:</div>
                            <div class="col-md-8">${student.user.phone != null ? student.user.phone : 'Chưa cập nhật'}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Địa chỉ:</div>
                            <div class="col-md-8">${student.user.address != null ? student.user.address : 'Chưa cập nhật'}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Trình độ học vấn:</div>
                            <div class="col-md-8">${student.educationLevel != null ? student.educationLevel : 'Chưa cập nhật'}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Mục tiêu học tập:</div>
                            <div class="col-md-8">${student.studyGoals != null ? student.studyGoals : 'Chưa cập nhật'}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Liên hệ phụ huynh:</div>
                            <div class="col-md-8">${student.parentContact != null ? student.parentContact : 'Chưa cập nhật'}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card text-white bg-primary h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-journal-bookmark mb-3" style="font-size: 2.5rem;"></i>
                        <h5 class="card-title">Tổng lớp học</h5>
                        <h2 class="card-text">${enrollments.size()}</h2>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/student/enrollments" class="text-white">Xem chi tiết <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-warning h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-hourglass-split mb-3" style="font-size: 2.5rem;"></i>
                        <h5 class="card-title">Đang chờ duyệt</h5>
                        <h2 class="card-text">${pendingCount}</h2>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/student/enrollments" class="text-white">Xem chi tiết <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-success h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-journal-check mb-3" style="font-size: 2.5rem;"></i>
                        <h5 class="card-title">Đã phê duyệt</h5>
                        <h2 class="card-text">${approvedCount}</h2>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/student/enrollments" class="text-white">Xem chi tiết <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-info h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-journal-richtext mb-3" style="font-size: 2.5rem;"></i>
                        <h5 class="card-title">Đã hoàn thành</h5>
                        <h2 class="card-text">${completedCount}</h2>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/student/enrollments" class="text-white">Xem chi tiết <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Lớp học đang tham gia</h5>
                        <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-light btn-sm">
                            <i class="bi bi-search"></i> Tìm lớp học mới
                        </a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty enrollments}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Tên lớp</th>
                                                <th>Gia sư</th>
                                                <th>Môn học</th>
                                                <th>Lịch học</th>
                                                <th>Thời gian</th>
                                                <th>Trạng thái</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${enrollments}" var="enrollment">
                                                <tr>
                                                    <td>${enrollment.classInfo.className}</td>
                                                    <td>${enrollment.classInfo.tutor.user.fullName}</td>
                                                    <td>${enrollment.classInfo.subject.subjectName}</td>
                                                    <td>${enrollment.classInfo.schedule}</td>
                                                    <td>
                                                        <fmt:formatDate value="${enrollment.classInfo.startDate}" pattern="dd/MM/yyyy"/> - 
                                                        <fmt:formatDate value="${enrollment.classInfo.endDate}" pattern="dd/MM/yyyy"/>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${enrollment.status == 'pending'}">
                                                                <span class="badge bg-warning">Chờ duyệt</span>
                                                            </c:when>
                                                            <c:when test="${enrollment.status == 'approved'}">
                                                                <span class="badge bg-success">Đã duyệt</span>
                                                            </c:when>
                                                            <c:when test="${enrollment.status == 'rejected'}">
                                                                <span class="badge bg-danger">Từ chối</span>
                                                            </c:when>
                                                            <c:when test="${enrollment.status == 'completed'}">
                                                                <span class="badge bg-info">Hoàn thành</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group btn-group-sm">
                                                            <a href="${pageContext.request.contextPath}/student/enrollments?action=view&enrollmentId=${enrollment.enrollmentId}" class="btn btn-info">
                                                                <i class="bi bi-eye"></i>
                                                            </a>
                                                            <c:if test="${enrollment.status == 'completed' && enrollment.classInfo.status == 'completed'}">
                                                                <button type="button" class="btn btn-warning" onclick="showReviewModal(${enrollment.enrollmentId}, ${enrollment.classInfo.classId}, ${enrollment.classInfo.tutorId})">
                                                                    <i class="bi bi-star"></i>
                                                                </button>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="bi bi-journal-bookmark text-muted" style="font-size: 3rem;"></i>
                                    <p class="mt-3">Bạn chưa đăng ký lớp học nào.</p>
                                    <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">
                                        Tìm lớp học
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal cập nhật hồ sơ -->
        <div class="modal fade" id="profileModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Cập nhật hồ sơ</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/student/profile" method="post">
                        <input type="hidden" name="action" value="updateProfile">
                        <div class="modal-body">
                            <h6 class="mb-3">Thông tin cá nhân</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${student.user.email}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="fullName" class="form-label">Họ tên</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${student.user.fullName}" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${student.user.phone}">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="address" class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" id="address" name="address" value="${student.user.address}">
                                </div>
                            </div>
                            <hr class="my-4">
                            <h6 class="mb-3">Thông tin học tập</h6>
                            <div class="mb-3">
                                <label for="educationLevel" class="form-label">Trình độ học vấn</label>
                                <input type="text" class="form-control" id="educationLevel" name="educationLevel" value="${student.educationLevel}">
                            </div>
                            <div class="mb-3">
                                <label for="studyGoals" class="form-label">Mục tiêu học tập</label>
                                <textarea class="form-control" id="studyGoals" name="studyGoals" rows="3">${student.studyGoals}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="parentContact" class="form-label">Liên hệ phụ huynh</label>
                                <input type="text" class="form-control" id="parentContact" name="parentContact" value="${student.parentContact}">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal đánh giá -->
        <div class="modal fade" id="reviewModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Đánh giá gia sư</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/student/review" method="post">
                        <input type="hidden" name="enrollmentId" id="reviewEnrollmentId">
                        <input type="hidden" name="classId" id="reviewClassId">
                        <input type="hidden" name="tutorId" id="reviewTutorId">
                        <div class="modal-body">
                            <div class="mb-3 text-center">
                                <h6 class="mb-3">Đánh giá (1-5 sao)</h6>
                                <div class="rating">
                                    <input type="radio" id="star5" name="rating" value="5" /><label for="star5"></label>
                                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4"></label>
                                    <input type="radio" id="star3" name="rating" value="3" checked /><label for="star3"></label>
                                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2"></label>
                                    <input type="radio" id="star1" name="rating" value="1" /><label for="star1"></label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="comment" class="form-label">Nhận xét của bạn</label>
                                <textarea class="form-control" id="comment" name="comment" rows="4" placeholder="Nhập nhận xét của bạn về gia sư và lớp học..."></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                        </div>
                    </form>
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
    <script>
        function showReviewModal(enrollmentId, classId, tutorId) {
            document.getElementById('reviewEnrollmentId').value = enrollmentId;
            document.getElementById('reviewClassId').value = classId;
            document.getElementById('reviewTutorId').value = tutorId;
            
            const modal = new bootstrap.Modal(document.getElementById('reviewModal'));
            modal.show();
        }
    </script>
</body>
</html>