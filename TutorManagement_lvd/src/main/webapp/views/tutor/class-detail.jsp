<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết lớp học - Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/tutor/class-detail.css">
    <style>
        .progress-circle {
            background-color: #e9ecef;
            border-radius: 50%;
            position: relative;
        }

        .progress-circle-inner {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: conic-gradient(#0d6efd 0% var(--progress), transparent var(--progress) 100%);
        }

        .progress-circle-inner:before {
            content: '';
            position: absolute;
            top: 10px;
            left: 10px;
            right: 10px;
            bottom: 10px;
            background: white;
            border-radius: 50%;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/tutor/dashboard">Bảng điều khiển</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/tutor/classes">Lớp của tôi</a>
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

        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">${classInfo.className}</h5>
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
                </div>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-8">
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Môn học:</div>
                            <div class="col-md-8">${classInfo.subject.subjectName}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Thời gian học:</div>
                            <div class="col-md-8">
                                <fmt:formatDate value="${classInfo.startDate}" pattern="dd/MM/yyyy"/> - 
                                <fmt:formatDate value="${classInfo.endDate}" pattern="dd/MM/yyyy"/>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Lịch học:</div>
                            <div class="col-md-8">${classInfo.schedule}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Học phí:</div>
                            <div class="col-md-8"><fmt:formatNumber value="${classInfo.price}" type="currency" currencySymbol="₫"/></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Sĩ số tối đa:</div>
                            <div class="col-md-8">${classInfo.maxStudents} học viên</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Mô tả:</div>
                            <div class="col-md-8">${classInfo.description}</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h6 class="card-subtitle mb-2 text-muted">Học viên đã đăng ký</h6>
                                
                                <!-- Tính phần trăm học viên đã đăng ký -->
                                <c:set var="enrolledCount" value="0" />
                                <c:forEach items="${enrollments}" var="enrollment">
                                    <c:if test="${enrollment.status == 'approved' || enrollment.status == 'completed'}">
                                        <c:set var="enrolledCount" value="${enrolledCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:set var="enrollmentPercentage" value="${(enrolledCount / classInfo.maxStudents) * 100}" />
                                
                                <div class="d-flex justify-content-center align-items-center" style="height: 150px;">
                                    <div class="position-relative d-inline-block">
                                        <div class="progress-circle" style="width: 120px; height: 120px; --progress: ${enrollmentPercentage}%;">
                                            <div class="progress-circle-inner d-flex align-items-center justify-content-center">
                                                <div>
                                                    <h2 class="mb-0">${enrolledCount}</h2>
                                                    <small class="text-muted">/ ${classInfo.maxStudents}</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="card-text mt-3">Còn ${classInfo.maxStudents - enrolledCount} chỗ trống</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <a href="${pageContext.request.contextPath}/tutor/classes" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editClassModal">
                    <i class="bi bi-pencil"></i> Chỉnh sửa
                </button>
                <div class="btn-group">
                    <button type="button" class="btn btn-info dropdown-toggle" data-bs-toggle="dropdown">
                        <i class="bi bi-gear"></i> Thao tác
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" onclick="updateStatus(${classInfo.classId}, 'open')">Mở đăng ký</a></li>
                        <li><a class="dropdown-item" href="#" onclick="updateStatus(${classInfo.classId}, 'in_progress')">Bắt đầu lớp học</a></li>
                        <li><a class="dropdown-item" href="#" onclick="updateStatus(${classInfo.classId}, 'completed')">Hoàn thành</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="#" onclick="updateStatus(${classInfo.classId}, 'cancelled')">Hủy lớp</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="students-tab" data-bs-toggle="tab" data-bs-target="#students-tab-pane" type="button" role="tab">Danh sách học viên</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="enrollments-tab" data-bs-toggle="tab" data-bs-target="#enrollments-tab-pane" type="button" role="tab">Yêu cầu đăng ký</button>
            </li>
        </ul>

        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="students-tab-pane" role="tabpanel" aria-labelledby="students-tab" tabindex="0">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Trình độ</th>
                                <th>Mục tiêu học tập</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="hasStudents" value="false" />
                            <c:forEach items="${enrollments}" var="enrollment">
                                <c:if test="${enrollment.status == 'approved' || enrollment.status == 'completed'}">
                                    <c:set var="hasStudents" value="true" />
                                    <tr>
                                        <td>${enrollment.student.user.fullName}</td>
                                        <td>${enrollment.student.user.email}</td>
                                        <td>${enrollment.student.user.phone}</td>
                                        <td>${enrollment.student.educationLevel}</td>
                                        <td>${enrollment.student.studyGoals}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${enrollment.status == 'approved'}">
                                                    <span class="badge bg-primary">Đang học</span>
                                                </c:when>
                                                <c:when test="${enrollment.status == 'completed'}">
                                                    <span class="badge bg-success">Hoàn thành</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${!hasStudents}">
                                <tr>
                                    <td colspan="6" class="text-center">Chưa có học viên nào trong lớp</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="tab-pane fade" id="enrollments-tab-pane" role="tabpanel" aria-labelledby="enrollments-tab" tabindex="0">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Trình độ</th>
                                <th>Ngày đăng ký</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="hasPendingEnrollments" value="false" />
                            <c:forEach items="${enrollments}" var="enrollment">
                                <c:if test="${enrollment.status == 'pending'}">
                                    <c:set var="hasPendingEnrollments" value="true" />
                                    <tr>
                                        <td>${enrollment.student.user.fullName}</td>
                                        <td>${enrollment.student.user.email}</td>
                                        <td>${enrollment.student.user.phone}</td>
                                        <td>${enrollment.student.educationLevel}</td>
                                        <td><fmt:formatDate value="${enrollment.enrollmentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <form action="${pageContext.request.contextPath}/tutor/enrollments" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="approve">
                                                    <input type="hidden" name="enrollmentId" value="${enrollment.enrollmentId}">
                                                    <input type="hidden" name="classId" value="${classInfo.classId}">
                                                    <button type="submit" class="btn btn-success">
                                                        <i class="bi bi-check-lg"></i> Duyệt
                                                    </button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/tutor/enrollments" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="reject">
                                                    <input type="hidden" name="enrollmentId" value="${enrollment.enrollmentId}">
                                                    <input type="hidden" name="classId" value="${classInfo.classId}">
                                                    <button type="submit" class="btn btn-danger">
                                                        <i class="bi bi-x-lg"></i> Từ chối
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${!hasPendingEnrollments}">
                                <tr>
                                    <td colspan="6" class="text-center">Không có yêu cầu đăng ký nào chờ duyệt</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal chỉnh sửa lớp học -->
        <div class="modal fade" id="editClassModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Chỉnh sửa lớp học</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/tutor/classes" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="classId" value="${classInfo.classId}">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="className" class="form-label">Tên lớp học</label>
                                <input type="text" class="form-control" id="className" name="className" value="${classInfo.className}" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="description" rows="3">${classInfo.description}</textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" value="<fmt:formatDate value="${classInfo.startDate}" pattern="yyyy-MM-dd"/>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="endDate" class="form-label">Ngày kết thúc</label>
                                    <input type="date" class="form-control" id="endDate" name="endDate" value="<fmt:formatDate value="${classInfo.endDate}" pattern="yyyy-MM-dd"/>" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="schedule" class="form-label">Lịch học</label>
                                <input type="text" class="form-control" id="schedule" name="schedule" value="${classInfo.schedule}" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="price" class="form-label">Học phí</label>
                                    <input type="number" class="form-control" id="price" name="price" value="${classInfo.price}" min="0" step="10000" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="maxStudents" class="form-label">Sĩ số tối đa</label>
                                    <input type="number" class="form-control" id="maxStudents" name="maxStudents" value="${classInfo.maxStudents}" min="1" required>
                                </div>
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

        <!-- Form ẩn để cập nhật trạng thái -->
        <form id="updateStatusForm" action="${pageContext.request.contextPath}/tutor/classes" method="post" style="display: none;">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="classId" id="updateClassId">
            <input type="hidden" name="status" id="updateClassStatus">
        </form>
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
    <script>
        function updateStatus(classId, status) {
            document.getElementById("updateClassId").value = classId;
            document.getElementById("updateClassStatus").value = status;
            
            // Xác nhận nếu là hủy lớp
            if (status === 'cancelled' && !confirm('Bạn có chắc chắn muốn hủy lớp học này?')) {
                return;
            }
            
            document.getElementById("updateStatusForm").submit();
        }
    </script>
</body>
</html>