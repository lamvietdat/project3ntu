<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

<div class="row mb-4 align-items-center">
    <div class="col-md-6">
        <h2>Đăng ký của tôi</h2>
    </div>
    <div class="col-md-6 text-md-end">
        <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary">
            <i class="bi bi-search"></i> Tìm lớp học mới
        </a>
    </div>
</div>

<ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all-tab-pane" type="button" role="tab">Tất cả</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending-tab-pane" type="button" role="tab">Chờ duyệt</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved-tab-pane" type="button" role="tab">Đã duyệt</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="completed-tab" data-bs-toggle="tab" data-bs-target="#completed-tab-pane" type="button" role="tab">Hoàn thành</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="rejected-tab" data-bs-toggle="tab" data-bs-target="#rejected-tab-pane" type="button" role="tab">Từ chối</button>
    </li>
</ul>

<div class="tab-content" id="myTabContent">
    <!-- Tab tất cả -->
    <div class="tab-pane fade show active" id="all-tab-pane" role="tabpanel" aria-labelledby="all-tab" tabindex="0">
        <c:choose>
            <c:when test="${not empty enrollments}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Tên lớp</th>
                                <th>Gia sư</th>
                                <th>Môn học</th>
                                <th>Ngày đăng ký</th>
                                <th>Học phí</th>
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
                                    <td><fmt:formatDate value="${enrollment.enrollmentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td><fmt:formatNumber value="${enrollment.classInfo.price}" type="currency" currencySymbol="₫"/></td>
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
                                        <a href="${pageContext.request.contextPath}/student/enrollments?action=view&enrollmentId=${enrollment.enrollmentId}" class="btn btn-sm btn-info">
                                            <i class="bi bi-eye"></i> Chi tiết
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                    <p class="mt-3">Bạn chưa đăng ký lớp học nào.</p>
                    <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">
                        Tìm lớp học
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Tab chờ duyệt -->
    <div class="tab-pane fade" id="pending-tab-pane" role="tabpanel" aria-labelledby="pending-tab" tabindex="0">
        <c:choose>
            <c:when test="${not empty enrollments}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Tên lớp</th>
                                <th>Gia sư</th>
                                <th>Môn học</th>
                                <th>Ngày đăng ký</th>
                                <th>Học phí</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${enrollments}" var="enrollment">
                                <c:if test="${enrollment.status == 'pending'}">
                                    <tr>
                                        <td>${enrollment.classInfo.className}</td>
                                        <td>${enrollment.classInfo.tutor.user.fullName}</td>
                                        <td>${enrollment.classInfo.subject.subjectName}</td>
                                        <td><fmt:formatDate value="${enrollment.enrollmentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td><fmt:formatNumber value="${enrollment.classInfo.price}" type="currency" currencySymbol="₫"/></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/student/enrollments?action=view&enrollmentId=${enrollment.enrollmentId}" class="btn btn-sm btn-info">
                                                <i class="bi bi-eye"></i> Chi tiết
                                            </a>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${enrollments.stream().noneMatch(e -> e.status == 'pending')}">
                    <div class="text-center py-5">
                        <i class="bi bi-calendar-check text-muted" style="font-size: 3rem;"></i>
                        <p class="mt-3">Không có đăng ký nào đang chờ duyệt.</p>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                    <p class="mt-3">Bạn chưa đăng ký lớp học nào.</p>
                    <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">
                        Tìm lớp học
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Tab đã duyệt -->
    <div class="tab-pane fade" id="approved-tab-pane" role="tabpanel" aria-labelledby="approved-tab" tabindex="0">
        <c:choose>
            <c:when test="${not empty enrollments}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Tên lớp</th>
                                <th>Gia sư</th>
                                <th>Môn học</th>
                                <th>Ngày đăng ký</th>
                                <th>Học phí</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${enrollments}" var="enrollment">
                                <c:if test="${enrollment.status == 'approved'}">
                                    <tr>
                                        <td>${enrollment.classInfo.className}</td>
                                        <td>${enrollment.classInfo.tutor.user.fullName}</td>
                                        <td>${enrollment.classInfo.subject.subjectName}</td>
                                        <td><fmt:formatDate value="${enrollment.enrollmentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td><fmt:formatNumber value="${enrollment.classInfo.price}" type="currency" currencySymbol="₫"/></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/student/enrollments?action=view&enrollmentId=${enrollment.enrollmentId}" class="btn btn-sm btn-info">
                                                <i class="bi bi-eye"></i> Chi tiết
                                            </a>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${enrollments.stream().noneMatch(e -> e.status == 'approved')}">
                    <div class="text-center py-5">
                        <i class="bi bi-calendar-check text-muted" style="font-size: 3rem;"></i>
                        <p class="mt-3">Không có đăng ký nào đã được duyệt.</p>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                    <p class="mt-3">Bạn chưa đăng ký lớp học nào.</p>
                    <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">
                        Tìm lớp học
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Tab hoàn thành -->
    <div class="tab-pane fade" id="completed-tab-pane" role="tabpanel" aria-labelledby="completed-tab" tabindex="0">
        <c:choose>
            <c:when test="${not empty enrollments}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Tên lớp</th>
                                <th>Gia sư</th>
                                <th>Môn học</th>
                                <th>Ngày đăng ký</th>
                                <th>Học phí</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${enrollments}" var="enrollment">
                                <c:if test="${enrollment.status == 'completed'}">
                                    <tr>
                                        <td>${enrollment.classInfo.className}</td>
                                        <td>${enrollment.classInfo.tutor.user.fullName}</td>
                                        <td>${enrollment.classInfo.subject.subjectName}</td>
                                        <td><fmt:formatDate value="${enrollment.enrollmentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td><fmt:formatNumber value="${enrollment.classInfo.price}" type="currency" currencySymbol="₫"/></td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/student/enrollments?action=view&enrollmentId=${enrollment.enrollmentId}" class="btn btn-info">
                                                    <i class="bi bi-eye"></i> Chi tiết
                                                </a>
                                                <button type="button" class="btn btn-warning" onclick="showReviewModal(${enrollment.enrollmentId}, ${enrollment.classInfo.classId}, ${enrollment.classInfo.tutorId})">
                                                    <i class="bi bi-star"></i> Đánh giá
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${enrollments.stream().noneMatch(e -> e.status == 'completed')}">
                    <div class="text-center py-5">
                        <i class="bi bi-calendar-check text-muted" style="font-size: 3rem;"></i>
                        <p class="mt-3">Không có đăng ký nào đã hoàn thành.</p>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                    <p class="mt-3">Bạn chưa đăng ký lớp học nào.</p>
                    <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">
                        Tìm lớp học
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Tab từ chối -->
    <div class="tab-pane fade" id="rejected-tab-pane" role="tabpanel" aria-labelledby="rejected-tab" tabindex="0">
        <c:choose>
            <c:when test="${not empty enrollments}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Tên lớp</th>
                                <th>Gia sư</th>
                                <th>Môn học</th>
                                <th>Ngày đăng ký</th>
                                <th>Học phí</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${enrollments}" var="enrollment">
                                <c:if test="${enrollment.status == 'rejected'}">
                                    <tr>
                                        <td>${enrollment.classInfo.className}</td>
                                        <td>${enrollment.classInfo.tutor.user.fullName}</td>
                                        <td>${enrollment.classInfo.subject.subjectName}</td>
                                        <td><fmt:formatDate value="${enrollment.enrollmentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td><fmt:formatNumber value="${enrollment.classInfo.price}" type="currency" currencySymbol="₫"/></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/student/enrollments?action=view&enrollmentId=${enrollment.enrollmentId}" class="btn btn-sm btn-info">
                                                <i class="bi bi-eye"></i> Chi tiết
                                            </a>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${enrollments.stream().noneMatch(e -> e.status == 'rejected')}">
                    <div class="text-center py-5">
                        <i class="bi bi-calendar-check text-muted" style="font-size: 3rem;"></i>
                        <p class="mt-3">Không có đăng ký nào bị từ chối.</p>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                    <p class="mt-3">Bạn chưa đăng ký lớp học nào.</p>
                    <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">
                        Tìm lớp học
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
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

<script>
function showReviewModal(enrollmentId, classId, tutorId) {
    document.getElementById('reviewEnrollmentId').value = enrollmentId;
    document.getElementById('reviewClassId').value = classId;
    document.getElementById('reviewTutorId').value = tutorId;
    
    const modal = new bootstrap.Modal(document.getElementById('reviewModal'));
    modal.show();
}
</script>

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

<jsp:include page="/views/common/footer.jsp"></jsp:include>