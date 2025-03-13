<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

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
                        <div class="d-flex justify-content-center align-items-center" style="height: 150px;">
                            <div class="position-relative d-inline-block">
                                <div class="progress-circle" style="width: 120px; height: 120px;">
                                    <div class="progress-circle-inner d-flex align-items-center justify-content-center">
                                        <div>
                                            <h2 class="mb-0">12</h2>
                                            <small class="text-muted">/ ${classInfo.maxStudents}</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <p class="card-text mt-3">Còn ${classInfo.maxStudents - 12} chỗ trống</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card-footer">
        <a href="${pageContext.request.contextPath}/tutor/classes" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>
        <button type="button" class="btn btn-primary" onclick="editClass(${classInfo.classId})">
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
                    <c:forEach items="${enrollments}" var="enrollment">
                        <c:if test="${enrollment.status == 'approved' || enrollment.status == 'completed'}">
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
                    <c:forEach items="${enrollments}" var="enrollment">
                        <c:if test="${enrollment.status == 'pending'}">
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
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Form ẩn để cập nhật trạng thái -->
<form id="updateStatusForm" action="${pageContext.request.contextPath}/tutor/classes" method="post" style="display: none;">
    <input type="hidden" name="action" value="updateStatus">
    <input type="hidden" name="classId" id="updateClassId">
    <input type="hidden" name="status" id="updateClassStatus">
</form>

<script>
function editClass(classId) {
    // Chuyển hướng đến trang chỉnh sửa lớp học
    window.location.href = "${pageContext.request.contextPath}/tutor/classes?action=edit&classId=" + classId;
}

function updateStatus(classId, status) {
    document.getElementById("updateClassId").value = classId;
    document.getElementById("updateClassStatus").value = status;
    document.getElementById("updateStatusForm").submit();
}
</script>

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
    background: conic-gradient(#0d6efd 0% 75%, transparent 75% 100%);
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

<jsp:include page="/views/common/footer.jsp"></jsp:include>