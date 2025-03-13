<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

<div class="row mb-4 align-items-center">
    <div class="col-md-6">
        <h2>Tìm lớp học</h2>
    </div>
    <div class="col-md-6">
        <div class="input-group">
            <select class="form-select" id="subjectFilter">
                <option value="">Tất cả môn học</option>
                <c:forEach items="${subjects}" var="subject">
                    <option value="${subject.subjectId}" ${param.subjectId == subject.subjectId ? 'selected' : ''}>${subject.subjectName}</option>
                </c:forEach>
            </select>
            <button class="btn btn-primary" type="button" onclick="filterBySubject()">Lọc</button>
        </div>
    </div>
</div>

<div class="row">
    <c:choose>
        <c:when test="${not empty classes}">
            <c:forEach items="${classes}" var="classInfo">
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">${classInfo.className}</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <strong>Môn học:</strong> ${classInfo.subject.subjectName}
                            </div>
                            <div class="mb-3">
                                <strong>Gia sư:</strong> ${classInfo.tutor.user.fullName}
                            </div>
                            <div class="mb-3">
                                <strong>Thời gian:</strong>
                                <div>
                                    <fmt:formatDate value="${classInfo.startDate}" pattern="dd/MM/yyyy"/> - 
                                    <fmt:formatDate value="${classInfo.endDate}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>
                            <div class="mb-3">
                                <strong>Lịch học:</strong> ${classInfo.schedule}
                            </div>
                            <div class="mb-3">
                                <strong>Học phí:</strong> <fmt:formatNumber value="${classInfo.price}" type="currency" currencySymbol="₫"/>
                            </div>
                            <div>
                                <strong>Sĩ số:</strong> 
                                <span class="badge bg-secondary">${enrollmentCounts[classInfo.classId]} / ${classInfo.maxStudents}</span>
                            </div>
                        </div>
                        <div class="card-footer d-grid">
                            <a href="${pageContext.request.contextPath}/student/browse-classes?action=view&classId=${classInfo.classId}" class="btn btn-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="col-12 text-center py-5">
                <i class="bi bi-search text-muted" style="font-size: 4rem;"></i>
                <h4 class="mt-3">Không tìm thấy lớp học</h4>
                <p class="text-muted">Không có lớp học nào phù hợp với tiêu chí tìm kiếm của bạn.</p>
                <a href="${pageContext.request.contextPath}/student/browse-classes" class="btn btn-primary mt-2">Xem tất cả lớp học</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function filterBySubject() {
    const subjectId = document.getElementById("subjectFilter").value;
    if (subjectId) {
        window.location.href = "${pageContext.request.contextPath}/student/browse-classes?subjectId=" + subjectId;
    } else {
        window.location.href = "${pageContext.request.contextPath}/student/browse-classes";
    }
}
</script>

<jsp:include page="/views/common/footer.jsp"></jsp:include>