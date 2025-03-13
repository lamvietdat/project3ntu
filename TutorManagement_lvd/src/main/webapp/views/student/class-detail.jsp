<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

<div class="row mb-4">
    <div class="col">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/student/browse-classes">Danh sách lớp học</a></li>
                <li class="breadcrumb-item active" aria-current="page">${classInfo.className}</li>
            </ol>
        </nav>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">${classInfo.className}</h5>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Môn học:</div>
                    <div class="col-md-8">${classInfo.subject.subjectName}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Gia sư:</div>
                    <div class="col-md-8">${classInfo.tutor.user.fullName}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Trình độ:</div>
                    <div class="col-md-8">${classInfo.tutor.qualification}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Kinh nghiệm:</div>
                    <div class="col-md-8">${classInfo.tutor.experience}</div>
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
                    <div class="col-md-4 fw-bold">Sĩ số:</div>
                    <div class="col-md-8">${enrollmentCount} / ${classInfo.maxStudents} học viên</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Trạng thái:</div>
                    <div class="col-md-8">
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
                <div class="row">
                    <div class="col-md-4 fw-bold">Mô tả:</div>
                    <div class="col-md-8">${classInfo.description}</div>
                </div>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Đánh giá về gia sư</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty reviews}">
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
                        </div>
                        
                        <hr>
                        
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
                            </div>
                            <c:if test="${!status.last}">
                                <hr>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4">
                            <i class="bi bi-emoji-smile text-muted" style="font-size: 3rem;"></i>
                            <p class="mt-3">Chưa có đánh giá nào về gia sư này.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Thông tin đăng ký</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${isEnrolled}">
                        <div class="text-center py-4">
                            <i class="bi bi-check-circle-fill text-success" style="font-size: 4rem;"></i>
                            <h5 class="mt-3">Bạn đã đăng ký lớp học này</h5>
                            <p>Vui lòng kiểm tra trạng thái đăng ký trong phần "Đăng ký của tôi".</p>
                            <a href="${pageContext.request.contextPath}/student/enrollments" class="btn btn-primary mt-2">
                                Xem đăng ký của tôi
                            </a>
                        </div>
                    </c:when>
                    <c:when test="${classInfo.status == 'open' && enrollmentCount < classInfo.maxStudents}">
                        <p>Lớp học hiện đang mở đăng ký với <strong>${classInfo.maxStudents - enrollmentCount}</strong> chỗ trống.</p>
                        <p class="mb-4">Nhấn vào nút bên dưới để đăng ký tham gia lớp học này.</p>
                        
                        <form action="${pageContext.request.contextPath}/student/enrollments" method="post">
                            <input type="hidden" name="action" value="enroll">
                            <input type="hidden" name="classId" value="${classInfo.classId}">
                            <div class="d-grid">
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="bi bi-journal-check"></i> Đăng ký lớp học
                                </button>
                            </div>
                        </form>
                        
                        <hr>
                        
                        <div class="alert alert-info mt-3">
                            <h6><i class="bi bi-info-circle"></i> Lưu ý khi đăng ký</h6>
                            <ul class="mb-0">
                                <li>Đăng ký sẽ được gia sư xét duyệt.</li>
                                <li>Khi đăng ký được duyệt, bạn cần thanh toán học phí.</li>
                                <li>Học phí đã thanh toán sẽ không được hoàn lại.</li>
                            </ul>
                        </div>
                    </c:when>
                    <c:when test="${classInfo.status == 'open' && enrollmentCount >= classInfo.maxStudents}">
                        <div class="text-center py-4">
                            <i class="bi bi-exclamation-circle text-warning" style="font-size: 4rem;"></i>
                            <h5 class="mt-3">Lớp học đã đầy</h5>
                            <p>Lớp học này đã đạt số lượng học viên tối đa. Vui lòng tìm lớp học khác.</p>
                            <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">
                                Tìm lớp học khác
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4">
                            <i class="bi bi-x-circle text-danger" style="font-size: 4rem;"></i>
                            <h5 class="mt-3">Lớp học không còn mở đăng ký</h5>
                            <p>Lớp học này hiện không còn mở đăng ký. Vui lòng tìm lớp học khác.</p>
                            <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">
                                Tìm lớp học khác
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Thông tin liên hệ</h5>
            </div>
            <div class="card-body">
                <p><i class="bi bi-person-circle me-2"></i> <strong>Gia sư:</strong> ${classInfo.tutor.user.fullName}</p>
                <p><i class="bi bi-envelope me-2"></i> <strong>Email:</strong> ${classInfo.tutor.user.email}</p>
                <p><i class="bi bi-telephone me-2"></i> <strong>Điện thoại:</strong> ${classInfo.tutor.user.phone}</p>
                <hr>
                <p class="text-muted small">Lưu ý: Vui lòng chỉ liên hệ gia sư để tìm hiểu thêm thông tin về lớp học. Mọi đăng ký đều phải thực hiện qua hệ thống.</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"></jsp:include>