<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h4 class="mb-0">Đăng ký tài khoản</h4>
            </div>
            <div class="card-body">
                <form action="/register" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Họ tên</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" id="phone" name="phone">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" id="address" name="address">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Vai trò</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="role" id="roleTutor" value="tutor">
                            <label class="form-check-label" for="roleTutor">
                                Gia sư
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="role" id="roleStudent" value="student" checked>
                            <label class="form-check-label" for="roleStudent">
                                Học viên
                            </label>
                        </div>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Đăng ký</button>
                    </div>
                </form>
            </div>
            <div class="card-footer text-center">
                <p class="mb-0">Đã có tài khoản? <a href="/login">Đăng nhập</a></p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp"></jsp:include>