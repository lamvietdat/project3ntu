<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

<div class="row mb-4">
    <div class="col">
        <h2>Bảng điều khiển Admin</h2>
    </div>
</div>

<div class="row mb-4">
    <div class="col-md-3 mb-3">
        <div class="card text-white bg-primary h-100">
            <div class="card-body d-flex align-items-center">
                <i class="bi bi-people-fill me-3" style="font-size: 2.5rem;"></i>
                <div>
                    <h5 class="card-title">Tổng người dùng</h5>
                    <h2 class="card-text">${totalUsers}</h2>
                </div>
            </div>
            <div class="card-footer">
                <a href="/admin/users" class="text-white">Xem chi tiết <i class="bi bi-arrow-right"></i></a>
            </div>
        </div>
    </div>
    <div class="col-md-3 mb-3">
        <div class="card text-white bg-success h-100">
            <div class="card-body d-flex align-items-center">
                <i class="bi bi-person-workspace me-3" style="font-size: 2.5rem;"></i>
                <div>
                    <h5 class="card-title">Gia sư</h5>
                    <h2 class="card-text">${totalTutors}</h2>
                </div>
            </div>
            <div class="card-footer">
                <a href="/admin/users?role=tutor" class="text-white">Xem chi tiết <i class="bi bi-arrow-right"></i></a>
            </div>
        </div>
    </div>
    <div class="col-md-3 mb-3">
        <div class="card text-white bg-info h-100">
            <div class="card-body d-flex align-items-center">
                <i class="bi bi-mortarboard-fill me-3" style="font-size: 2.5rem;"></i>
                <div>
                    <h5 class="card-title">Học viên</h5>
                    <h2 class="card-text">${totalStudents}</h2>
                </div>
            </div>
            <div class="card-footer">
                <a href="/admin/users?role=student" class="text-white">Xem chi tiết <i class="bi bi-arrow-right"></i></a>
            </div>
        </div>
    </div>
    <div class="col-md-3 mb-3">
        <div class="card text-white bg-warning h-100">
            <div class="card-body d-flex align-items-center">
                <i class="bi bi-journal-richtext me-3" style="font-size: 2.5rem;"></i>
                <div>
                    <h5 class="card-title">Lớp học</h5>
                    <h2 class="card-text">${totalClasses}</h2>
                </div>
            </div>
            <div class="card-footer">
                <a href="/admin/classes" class="text-white">Xem chi tiết <i class="bi bi-arrow-right"></i></a>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Người dùng mới đăng ký</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Ngày đăng ký</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users}" var="user" begin="0" end="4">
                                <tr>
                                    <td>${user.fullName}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role == 'admin'}">
                                                <span class="badge bg-danger">Admin</span>
                                            </c:when>
                                            <c:when test="${user.role == 'tutor'}">
                                                <span class="badge bg-success">Gia sư</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-info">Học viên</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer">
                <a href="/admin/users" class="btn btn-primary btn-sm">Xem tất cả</a>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Lớp học mới</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Tên lớp</th>
                                <th>Gia sư</th>
                                <th>Trạng thái</th>
                                <th>Ngày bắt đầu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${classes}" var="class" begin="0" end="4">
                                <tr>
                                    <td>${class.className}</td>
                                    <td>${class.tutor.user.fullName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${class.status == 'open'}">
                                                <span class="badge bg-success">Mở đăng ký</span>
                                            </c:when>
                                            <c:when test="${class.status == 'in_progress'}">
                                                <span class="badge bg-primary">Đang học</span>
                                            </c:when>
                                            <c:when test="${class.status == 'completed'}">
                                                <span class="badge bg-info">Hoàn thành</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Đã hủy</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${class.startDate}" pattern="dd/MM/yyyy"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer">
                <a href="/admin/classes" class="btn btn-primary btn-sm">Xem tất cả</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"></jsp:include>