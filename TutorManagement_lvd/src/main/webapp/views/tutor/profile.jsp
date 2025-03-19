<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ Gia sư - Trung tâm Gia sư LVD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/tutor/profile.css">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/tutor/classes">Lớp của tôi</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/tutor/profile">Hồ sơ</a>
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
                <h2>Hồ sơ gia sư</h2>
            </div>
        </div>

        <div class="row">
            <div class="col-md-3">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <img src="${pageContext.request.contextPath}/assets/img/tutors/avatar.jpg" alt="${tutor.user.fullName}" class="rounded-circle img-fluid" style="width: 150px;">
                        <h5 class="my-3">${tutor.user.fullName}</h5>
                        <p class="text-muted mb-1">${tutor.qualification}</p>
                        <p class="text-muted mb-4">${tutor.user.address}</p>
                        <div class="d-flex justify-content-center mb-2">
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateProfileModal">
                                <i class="bi bi-pencil-square"></i> Cập nhật hồ sơ
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-5">
                                <p class="mb-0">Tài khoản</p>
                            </div>
                            <div class="col-sm-7">
                                <p class="text-muted mb-0">${tutor.user.username}</p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-5">
                                <p class="mb-0">Email</p>
                            </div>
                            <div class="col-sm-7">
                                <p class="text-muted mb-0">${tutor.user.email}</p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-5">
                                <p class="mb-0">Điện thoại</p>
                            </div>
                            <div class="col-sm-7">
                                <p class="text-muted mb-0">${tutor.user.phone}</p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-5">
                                <p class="mb-0">Địa chỉ</p>
                            </div>
                            <div class="col-sm-7">
                                <p class="text-muted mb-0">${tutor.user.address}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0">Đổi mật khẩu</h5>
                        </div>
                        <button type="button" class="btn btn-warning w-100" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                            <i class="bi bi-key"></i> Đổi mật khẩu
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Thông tin gia sư</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-3">
                                <strong>Bằng cấp/Chứng chỉ:</strong>
                            </div>
                            <div class="col-md-9">
                                ${tutor.qualification}
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3">
                                <strong>Kinh nghiệm:</strong>
                            </div>
                            <div class="col-md-9">
                                ${tutor.experience}
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3">
                                <strong>Phí theo giờ:</strong>
                            </div>
                            <div class="col-md-9">
                                <fmt:formatNumber value="${tutor.hourlyRate}" type="currency" currencySymbol="₫"/>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3">
                                <strong>Trạng thái:</strong>
                            </div>
                            <div class="col-md-9">
                                <c:choose>
                                    <c:when test="${tutor.status == 'active'}">
                                        <span class="badge bg-success">Đang hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Không hoạt động</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <strong>Giới thiệu:</strong>
                            </div>
                            <div class="col-md-9">
                                ${tutor.bio}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Đánh giá từ học viên</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-4">
                            <div class="text-center me-4">
                                <h1 class="mb-0"><fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/></h1>
                                <div class="mb-1">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="bi ${i <= avgRating ? 'bi-star-fill text-warning' : (i <= avgRating + 0.5 ? 'bi-star-half text-warning' : 'bi-star')}"></i>
                                    </c:forEach>
                                </div>
                                <small class="text-muted">${reviews.size()} đánh giá</small>
                            </div>
                            <div class="flex-grow-1">
                                <c:forEach begin="5" end="1" step="-1" var="i">
                                    <div class="d-flex align-items-center mb-1">
                                        <small class="me-2">${i} <i class="bi bi-star-fill text-warning"></i></small>
                                        <div class="progress flex-grow-1" style="height: 8px;">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: ${reviews.size() > 0 ? reviews.stream().filter(r -> r.rating == i).count() * 100 / reviews.size() : 0}%"></div>
                                        </div>
                                        <small class="ms-2">${reviews.stream().filter(r -> r.rating == i).count()}</small>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <c:forEach items="${reviews}" var="review" varStatus="status">
                            <div class="review-item mb-3">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <strong>${review.student.user.fullName}</strong>
                                        <span class="ms-2 text-muted"><fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                    <div>
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="bi ${i <= review.rating ? 'bi-star-fill text-warning' : 'bi-star'}"></i>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="mt-2">
                                    ${review.comment}
                                </div>
                                <small class="text-muted">Lớp: ${review.classInfo.className}</small>
                            </div>
                            <c:if test="${!status.last}">
                                <hr>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${empty reviews}">
                            <div class="text-center py-5">
                                <i class="bi bi-emoji-smile text-muted" style="font-size: 3rem;"></i>
                                <p class="mt-3">Chưa có đánh giá nào từ học viên.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal cập nhật hồ sơ -->
        <div class="modal fade" id="updateProfileModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Cập nhật hồ sơ</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/tutor/profile" method="post">
                        <input type="hidden" name="action" value="updateProfile">
                        <div class="modal-body">
                            <h6 class="mb-3">Thông tin cá nhân</h6>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${tutor.user.email}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="fullName" class="form-label">Họ tên</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${tutor.user.fullName}" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${tutor.user.phone}">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="address" class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" id="address" name="address" value="${tutor.user.address}">
                                </div>
                            </div>
                            <hr class="my-4">
                            <h6 class="mb-3">Thông tin gia sư</h6>
                            <div class="mb-3">
                                <label for="qualification" class="form-label">Bằng cấp/Chứng chỉ</label>
                                <input type="text" class="form-control" id="qualification" name="qualification" value="${tutor.qualification}" required>
                            </div>
                            <div class="mb-3">
                                <label for="experience" class="form-label">Kinh nghiệm</label>
                                <textarea class="form-control" id="experience" name="experience" rows="3" required>${tutor.experience}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="hourlyRate" class="form-label">Phí theo giờ (VNĐ)</label>
                                <input type="number" class="form-control" id="hourlyRate" name="hourlyRate" value="${tutor.hourlyRate}" min="0" step="10000" required>
                            </div>
                            <div class="mb-3">
                                <label for="bio" class="form-label">Giới thiệu bản thân</label>
                                <textarea class="form-control" id="bio" name="bio" rows="5">${tutor.bio}</textarea>
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

        <!-- Modal đổi mật khẩu -->
        <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-warning">
                        <h5 class="modal-title">Đổi mật khẩu</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/tutor/profile" method="post">
                        <input type="hidden" name="action" value="changePassword">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">Mật khẩu mới</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-warning">Đổi mật khẩu</button>
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
    
    <script src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script>
        // Kiểm tra xác nhận mật khẩu
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            
            if (newPassword !== confirmPassword) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html>