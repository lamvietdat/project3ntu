<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

<div class="row mb-4">
    <div class="col">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/student/enrollments">Đăng ký của tôi</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết đăng ký</li>
            </ol>
        </nav>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Thông tin đăng ký</h5>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Tên lớp:</div>
                    <div class="col-md-8">${enrollment.classInfo.className}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Môn học:</div>
                    <div class="col-md-8">${enrollment.classInfo.subject.subjectName}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Gia sư:</div>
                    <div class="col-md-8">${enrollment.classInfo.tutor.user.fullName}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Lịch học:</div>
                    <div class="col-md-8">${enrollment.classInfo.schedule}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Thời gian học:</div>
                    <div class="col-md-8">
                        <fmt:formatDate value="${enrollment.classInfo.startDate}" pattern="dd/MM/yyyy"/> - 
                        <fmt:formatDate value="${enrollment.classInfo.endDate}" pattern="dd/MM/yyyy"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Học phí:</div>
                    <div class="col-md-8"><fmt:formatNumber value="${enrollment.classInfo.price}" type="currency" currencySymbol="₫"/></div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Ngày đăng ký:</div>
                    <div class="col-md-8"><fmt:formatDate value="${enrollment.enrollmentDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4 fw-bold">Trạng thái:</div>
                    <div class="col-md-8">
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
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <a href="${pageContext.request.contextPath}/student/enrollments" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
                <c:if test="${enrollment.status == 'approved' && enrollment.classInfo.status != 'cancelled'}">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#paymentModal">
                        <i class="bi bi-credit-card"></i> Thanh toán
                    </button>
                </c:if>
                <c:if test="${enrollment.status == 'completed' && enrollment.classInfo.status == 'completed'}">
                    <button type="button" class="btn btn-warning" onclick="showReviewModal(${enrollment.enrollmentId}, ${enrollment.classInfo.classId}, ${enrollment.classInfo.tutorId})">
                        <i class="bi bi-star"></i> Đánh giá gia sư
                    </button>
                </c:if>
            </div>
        </div>
        
        <c:if test="${not empty payments}">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Lịch sử thanh toán</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Số tiền</th>
                                    <th>Phương thức</th>
                                    <th>Ngày thanh toán</th>
                                    <th>Mã giao dịch</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${payments}" var="payment">
                                    <tr>
                                        <td><fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫"/></td>
                                        <td>${payment.paymentMethod}</td>
                                        <td><fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td>${payment.transactionId}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${payment.status == 'pending'}">
                                                    <span class="badge bg-warning">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${payment.status == 'completed'}">
                                                    <span class="badge bg-success">Hoàn thành</span>
                                                </c:when>
                                                <c:when test="${payment.status == 'failed'}">
                                                    <span class="badge bg-danger">Thất bại</span>
                                                </c:when>
                                                <c:when test="${payment.status == 'refunded'}">
                                                    <span class="badge bg-info">Hoàn tiền</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <div class="col-md-4">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Thông tin lớp học</h5>
            </div>
            <div class="card-body">
                <div class="d-flex align-items-center mb-4">
                    <div class="flex-shrink-0">
                        <i class="bi bi-journal-richtext text-primary" style="font-size: 2.5rem;"></i>
                    </div>
                    <div class="ms-3">
                        <h5 class="mb-0">${enrollment.classInfo.className}</h5>
                        <p class="text-muted mb-0">${enrollment.classInfo.subject.subjectName}</p>
                    </div>
                </div>
                
                <div class="mb-3">
                    <p class="mb-1 fw-bold">Trạng thái lớp học:</p>
                    <c:choose>
                        <c:when test="${enrollment.classInfo.status == 'open'}">
                            <span class="badge bg-success">Mở đăng ký</span>
                        </c:when>
                        <c:when test="${enrollment.classInfo.status == 'in_progress'}">
                            <span class="badge bg-primary">Đang học</span>
                        </c:when>
                        <c:when test="${enrollment.classInfo.status == 'completed'}">
                            <span class="badge bg-info">Hoàn thành</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger">Đã hủy</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="mb-3">
                    <p class="mb-1 fw-bold">Mô tả:</p>
                    <p class="text-muted">${enrollment.classInfo.description}</p>
                </div>
                
                <hr>
                
                <div class="mb-3">
                    <p class="mb-1 fw-bold">Thông tin gia sư:</p>
                    <div class="d-flex align-items-center mt-2">
                        <img src="${pageContext.request.contextPath}/assets/img/tutors/avatar.jpg" alt="${enrollment.classInfo.tutor.user.fullName}" class="rounded-circle me-2" width="40" height="40">
                        <div>
                            <p class="mb-0 fw-bold">${enrollment.classInfo.tutor.user.fullName}</p>
                            <p class="text-muted mb-0">${enrollment.classInfo.tutor.qualification}</p>
                        </div>
                    </div>
                </div>
                
                <a href="${pageContext.request.contextPath}/student/browse-classes?action=view&classId=${enrollment.classInfo.classId}" class="btn btn-outline-primary w-100">
                    <i class="bi bi-eye"></i> Xem chi tiết lớp học
                </a>
            </div>
        </div>
        
        <c:if test="${enrollment.status == 'pending'}">
            <div class="card mb-4">
                <div class="card-header bg-warning text-dark">
                    <h5 class="mb-0">Đăng ký đang chờ duyệt</h5>
                </div>
                <div class="card-body">
                    <p>Đăng ký của bạn đang được gia sư xem xét. Bạn sẽ nhận được thông báo khi đăng ký được duyệt.</p>
                    <p class="mb-0">Thông thường, việc xét duyệt sẽ được thực hiện trong vòng 24-48 giờ.</p>
                </div>
            </div>
        </c:if>
        
        <c:if test="${enrollment.status == 'rejected'}">
            <div class="card mb-4">
                <div class="card-header bg-danger text-white">
                    <h5 class="mb-0">Đăng ký bị từ chối</h5>
                </div>
                <div class="card-body">
                    <p>Rất tiếc, đăng ký của bạn đã bị từ chối.</p>
                    <p class="mb-0">Có thể do lớp học đã đủ số lượng học viên hoặc không phù hợp với trình độ của bạn.</p>
                    <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-3 w-100">
                        <i class="bi bi-search"></i> Tìm lớp học khác
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- Modal thanh toán -->
<div class="modal fade" id="paymentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Thanh toán học phí</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/student/enrollments" method="post">
                <input type="hidden" name="action" value="pay">
                <input type="hidden" name="enrollmentId" value="${enrollment.enrollmentId}">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Thông tin lớp học</label>
                        <div class="card">
                            <div class="card-body">
                                <p class="mb-1"><strong>Tên lớp:</strong> ${enrollment.classInfo.className}</p>
                                <p class="mb-1"><strong>Môn học:</strong> ${enrollment.classInfo.subject.subjectName}</p>
                                <p class="mb-1"><strong>Gia sư:</strong> ${enrollment.classInfo.tutor.user.fullName}</p>
                                <p class="mb-0"><strong>Học phí:</strong> <fmt:formatNumber value="${enrollment.classInfo.price}" type="currency" currencySymbol="₫"/></p>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="paymentMethod" class="form-label">Phương thức thanh toán</label>
                        <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                            <option value="" selected disabled>Chọn phương thức thanh toán</option>
                            <option value="Chuyển khoản">Chuyển khoản ngân hàng</option>
                            <option value="Tiền mặt">Tiền mặt</option>
                            <option value="Ví điện tử">Ví điện tử (MoMo, ZaloPay...)</option>
                        </select>
                    </div>
                    <div class="alert alert-info">
                        <h6 class="alert-heading"><i class="bi bi-info-circle"></i> Lưu ý:</h6>
                        <ul class="mb-0">
                            <li>Học phí đã thanh toán sẽ không được hoàn lại.</li>
                            <li>Sau khi thanh toán, bạn sẽ được xác nhận tham gia lớp học.</li>
                            <li>Với hình thức chuyển khoản, vui lòng chuyển đúng số tiền và ghi rõ mã đăng ký.</li>
                        </ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Xác nhận thanh toán</button>
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
                <input type="hidden" name="enrollmentId" id="reviewEnrollmentId" value="${enrollment.enrollmentId}">
                <input type="hidden" name="classId" id="reviewClassId" value="${enrollment.classInfo.classId}">
                <input type="hidden" name="tutorId" id="reviewTutorId" value="${enrollment.classInfo.tutorId}">
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