<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

<div class="row justify-content-center">
    <div class="col-md-8 text-center">
        <div class="mt-5 mb-5">
            <i class="bi bi-exclamation-triangle-fill text-danger" style="font-size: 5rem;"></i>
            <h2 class="mt-3">Đã xảy ra lỗi</h2>
            <p class="lead">${errorMessage}</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3">Về trang chủ</a>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"></jsp:include>