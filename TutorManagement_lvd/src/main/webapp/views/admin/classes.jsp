<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý lớp học - Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/admin/classes.css">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Bảng điều khiển</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/classes">Quản lý lớp học</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> ${loginedUser.fullName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Tài khoản</a></li>
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
                <h2>Quản lý lớp học</h2>
            </div>
            <div class="col-md-6 text-md-end">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addClassModal">
                    <i class="bi bi-plus-circle"></i> Thêm lớp học
                </button>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <div class="row align-items-center">
                    <div class="col">
                        <h5 class="mb-0">Danh sách lớp học</h5>
                    </div>
                    <div class="col-auto">
                        <div class="input-group">
                            <select class="form-select" id="statusFilter">
                                <option value="">Tất cả trạng thái</option>
                                <option value="open">Mở đăng ký</option>
                                <option value="in_progress">Đang học</option>
                                <option value="completed">Hoàn thành</option>
                                <option value="cancelled">Đã hủy</option>
                            </select>
                            <button class="btn btn-light" type="button" onclick="filterByStatus()">Lọc</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên lớp</th>
                                <th>Gia sư</th>
                                <th>Môn học</th>
                                <th>Thời gian học</th>
                                <th>Học phí</th>
                                <th>Sĩ số tối đa</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${classes}" var="classInfo">
                                <tr>
                                    <td>${classInfo.classId}</td>
                                    <td>${classInfo.className}</td>
                                    <td>${classInfo.tutor.user.fullName}</td>
                                    <td>${classInfo.subject.subjectName}</td>
                                    <td>
                                        <fmt:formatDate value="${classInfo.startDate}" pattern="dd/MM/yyyy"/> - 
                                        <fmt:formatDate value="${classInfo.endDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td><fmt:formatNumber value="${classInfo.price}" type="currency" currencySymbol="₫"/></td>
                                    <td>${classInfo.maxStudents}</td>
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
                                        <div class="btn-group btn-group-sm">
                                            <button type="button" class="btn btn-primary" onclick="editClass(${classInfo.classId})">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button type="button" class="btn btn-info" data-bs-toggle="dropdown">
                                                <i class="bi bi-gear"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${classInfo.classId}, 'open')">Mở đăng ký</a></li>
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${classInfo.classId}, 'in_progress')">Đang học</a></li>
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${classInfo.classId}, 'completed')">Hoàn thành</a></li>
                                                <li><a class="dropdown-item" href="#" onclick="updateStatus(${classInfo.classId}, 'cancelled')">Hủy lớp</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal thêm lớp học -->
        <div class="modal fade" id="addClassModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Thêm lớp học mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/classes" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="tutorId" class="form-label">Gia sư</label>
                                    <select class="form-select" id="tutorId" name="tutorId" required>
                                        <c:forEach items="${tutors}" var="tutor">
                                            <option value="${tutor.tutorId}">${tutor.user.fullName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="subjectId" class="form-label">Môn học</label>
                                    <select class="form-select" id="subjectId" name="subjectId" required>
                                        <c:forEach items="${subjects}" var="subject">
                                            <option value="${subject.subjectId}">${subject.subjectName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="className" class="form-label">Tên lớp học</label>
                                <input type="text" class="form-control" id="className" name="className" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="endDate" class="form-label">Ngày kết thúc</label>
                                    <input type="date" class="form-control" id="endDate" name="endDate" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="schedule" class="form-label">Lịch học</label>
                                <input type="text" class="form-control" id="schedule" name="schedule" placeholder="Ví dụ: Thứ 2, 4, 6 từ 18:00-20:00" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="price" class="form-label">Học phí</label>
                                    <input type="number" class="form-control" id="price" name="price" min="0" step="10000" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="maxStudents" class="form-label">Sĩ số tối đa</label>
                                    <input type="number" class="form-control" id="maxStudents" name="maxStudents" min="1" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="status" class="form-label">Trạng thái</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="open">Mở đăng ký</option>
                                    <option value="in_progress">Đang học</option>
                                    <option value="completed">Hoàn thành</option>
                                    <option value="cancelled">Đã hủy</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Thêm lớp học</button>
                        </div>
                    </form>
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
                    <form action="${pageContext.request.contextPath}/admin/classes" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="classId" id="editClassId">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="editClassName" class="form-label">Tên lớp học</label>
                                <input type="text" class="form-control" id="editClassName" name="className" required>
                            </div>
                            <div class="mb-3">
                                <label for="editDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="editStartDate" class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" id="editStartDate" name="startDate" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="editEndDate" class="form-label">Ngày kết thúc</label>
                                    <input type="date" class="form-control" id="editEndDate" name="endDate" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="editSchedule" class="form-label">Lịch học</label>
                                <input type="text" class="form-control" id="editSchedule" name="schedule" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="editPrice" class="form-label">Học phí</label>
                                    <input type="number" class="form-control" id="editPrice" name="price" min="0" step="10000" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="editMaxStudents" class="form-label">Sĩ số tối đa</label>
                                    <input type="number" class="form-control" id="editMaxStudents" name="maxStudents" min="1" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="editStatus" class="form-label">Trạng thái</label>
                                <select class="form-select" id="editStatus" name="status" required>
                                    <option value="open">Mở đăng ký</option>
                                    <option value="in_progress">Đang học</option>
                                    <option value="completed">Hoàn thành</option>
                                    <option value="cancelled">Đã hủy</option>
                                </select>
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
        <form id="updateStatusForm" action="/admin/classes" method="post" style="display: none;">
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
    
    <script src="/assets/js/jquery-3.6.0.min.js"></script>
    <script src="/assets/js/bootstrap.bundle.min.js"></script>
    <script>
    function filterByStatus() {
        const status = document.getElementById("statusFilter").value;
        if (status) {
            window.location.href = "${pageContext.request.contextPath}/admin/classes?status=" + status;
        } else {
            window.location.href = "${pageContext.request.contextPath}/admin/classes";
        }
    }

    function editClass(classId) {
        // Ở đây lẽ ra sẽ cần lấy thông tin lớp học từ server, nhưng để đơn giản thì đang giả định là đã có dữ liệu
        // Trong ứng dụng thực tế, bạn sẽ cần gửi Ajax request để lấy dữ liệu lớp học
        document.getElementById("editClassId").value = classId;
        
        // Hiển thị modal
        const modal = new bootstrap.Modal(document.getElementById("editClassModal"));
        modal.show();
    }

    function updateStatus(classId, status) {
        document.getElementById("updateClassId").value = classId;
        document.getElementById("updateClassStatus").value = status;
        document.getElementById("updateStatusForm").submit();
    }
    </script>
</body>
</html>