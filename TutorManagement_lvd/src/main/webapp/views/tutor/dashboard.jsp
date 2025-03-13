<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

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
                                        <!-- Giả sử có phương thức để đếm số học viên trong lớp -->
                                        <span class="badge bg-secondary">12 / ${classInfo.maxStudents}</span>
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

<jsp:include page="/views/common/footer.jsp"></jsp:include>