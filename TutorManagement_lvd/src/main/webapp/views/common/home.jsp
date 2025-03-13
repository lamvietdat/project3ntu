<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/views/common/header.jsp"></jsp:include>

<section class="hero-section py-5 text-center text-white bg-primary">
    <div class="container">
        <h1 class="display-4">Chào mừng đến với Trung tâm Gia sư LVD</h1>
        <p class="lead">Nơi kết nối gia sư chất lượng với học viên tại Việt Nam</p>
        <div class="mt-4">
            <a href="/common/register" class="btn btn-light btn-lg me-2">Đăng ký ngay</a>
            <a href="#featured-classes" class="btn btn-outline-light btn-lg">Xem lớp học</a>
        </div>
    </div>
</section>

<section id="featured-classes" class="py-5">
    <div class="container">
        <h2 class="text-center mb-4">Lớp học nổi bật</h2>
        
        <div class="row">
            <c:forEach items="${openClasses}" var="classInfo" begin="0" end="3">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">${classInfo.className}</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><strong>Môn học:</strong> ${classInfo.subject.subjectName}</p>
                            <p class="card-text"><strong>Gia sư:</strong> ${classInfo.tutor.user.fullName}</p>
                            <p class="card-text"><strong>Lịch học:</strong> ${classInfo.schedule}</p>
                            <p class="card-text"><strong>Học phí:</strong> <fmt:formatNumber value="${classInfo.price}" type="currency" currencySymbol="₫"/></p>
                        </div>
                        <div class="card-footer">
                            <c:choose>
                                <c:when test="${loginedUser.role == 'student'}">
                                    <a href="/student/browse-classes?action=view&classId=${classInfo.classId}" class="btn btn-primary w-100">Xem chi tiết</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/common/login" class="btn btn-primary w-100">Đăng nhập để đăng ký</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <div class="text-center mt-4">
            <a href="$/student/browse-classes" class="btn btn-outline-primary">Xem tất cả lớp học</a>
        </div>
    </div>
</section>

<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center mb-4">Gia sư nổi bật</h2>
        
        <div class="row">
            <c:forEach items="${tutors}" var="tutor" begin="0" end="3">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <div class="mb-3">
                                <img src="/assets/img/tutors/avatar.jpg" alt="${tutor.user.fullName}" class="rounded-circle" width="100" height="100">
                            </div>
                            <h5 class="card-title">${tutor.user.fullName}</h5>
                            <p class="card-text text-muted">${tutor.qualification}</p>
                            <p class="card-text">${tutor.experience}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h2>Tại sao chọn Trung tâm Gia sư LVD?</h2>
                <ul class="list-unstyled mt-4">
                    <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Đội ngũ gia sư chất lượng cao, có bằng cấp và kinh nghiệm</li>
                    <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Chương trình học đa dạng, phù hợp với nhiều đối tượng học viên</li>
                    <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Học phí hợp lý, minh bạch</li>
                    <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Hỗ trợ học viên 24/7</li>
                    <li class="mb-3"><i class="bi bi-check-circle-fill text-primary me-2"></i> Cam kết đảm bảo chất lượng</li>
                </ul>
            </div>
            <div class="col-lg-6">
                <img src="/assets/img/about.jpg" alt="Về chúng tôi" class="img-fluid rounded">
            </div>
        </div>
    </div>
</section>

<jsp:include page="/views/common/footer.jsp"></jsp:include>