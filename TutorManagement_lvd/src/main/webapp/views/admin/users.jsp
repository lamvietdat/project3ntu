<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:include page="/views/common/header.jsp"></jsp:include>

<div class="row mb-4 align-items-center">
    <div class="col-md-6">
        <h2>Quản lý người dùng</h2>
    </div>
    <div class="col-md-6 text-md-end">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
            <i class="bi bi-plus-circle"></i> Thêm người dùng
        </button>
    </div>
</div>

<div class="card mb-4">
    <div class="card-header bg-primary text-white">
        <div class="row align-items-center">
            <div class="col">
                <h5 class="mb-0">Danh sách người dùng</h5>
            </div>
            <div class="col-auto">
                <div class="input-group">
                    <select class="form-select" id="roleFilter">
                        <option value="">Tất cả vai trò</option>
                        <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                        <option value="tutor" ${param.role == 'tutor' ? 'selected' : ''}>Gia sư</option>
                        <option value="student" ${param.role == 'student' ? 'selected' : ''}>Học viên</option>
                    </select>
                    <button class="btn btn-light" type="button" onclick="filterByRole()">Lọc</button>
                </div>
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Tên đăng nhập</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Vai trò</th>
                        <th>Ngày tạo</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.fullName}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
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
                            <td><fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <div class="btn-group btn-group-sm">
                                    <button type="button" class="btn btn-primary" onclick="editUser(${user.userId})">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button type="button" class="btn btn-warning" onclick="resetPassword(${user.userId})">
                                        <i class="bi bi-key"></i>
                                    </button>
                                    <button type="button" class="btn btn-danger" onclick="deleteUser(${user.userId})">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal thêm người dùng -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Thêm người dùng mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/users" method="post">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="fullName" class="form-label">Họ tên</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" required>
                        </div>
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
                            <input class="form-check-input" type="radio" name="role" id="roleAdmin" value="admin">
                            <label class="form-check-label" for="roleAdmin">
                                Admin
                            </label>
                        </div>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Thêm người dùng</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal chỉnh sửa người dùng -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Chỉnh sửa người dùng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/users" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="userId" id="editUserId">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editFullName" class="form-label">Họ tên</label>
                            <input type="text" class="form-control" id="editFullName" name="fullName" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="editPhone" class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" id="editPhone" name="phone">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editAddress" class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" id="editAddress" name="address">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Vai trò</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="role" id="editRoleAdmin" value="admin">
                            <label class="form-check-label" for="editRoleAdmin">
                                Admin
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="role" id="editRoleTutor" value="tutor">
                            <label class="form-check-label" for="editRoleTutor">
                                Gia sư
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="role" id="editRoleStudent" value="student">
                            <label class="form-check-label" for="editRoleStudent">
                                Học viên
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal xác nhận xóa người dùng -->
<div class="modal fade" id="deleteUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa người dùng này không? Hành động này không thể hoàn tác.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="userId" id="deleteUserId">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal đặt lại mật khẩu -->
<div class="modal fade" id="resetPasswordModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-warning">
                <h5 class="modal-title">Đặt lại mật khẩu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn đặt lại mật khẩu của người dùng này không?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="action" value="resetPassword">
                    <input type="hidden" name="userId" id="resetPasswordUserId">
                    <button type="submit" class="btn btn-warning">Đặt lại mật khẩu</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function filterByRole() {
    const role = document.getElementById("roleFilter").value;
    if (role) {
        window.location.href = "${pageContext.request.contextPath}/admin/users?role=" + role;
    } else {
        window.location.href = "${pageContext.request.contextPath}/admin/users";
    }
}

function editUser(userId) {
    // Ở đây lẽ ra sẽ cần lấy thông tin người dùng từ server, nhưng để đơn giản thì đang giả định là đã có dữ liệu
    // Trong ứng dụng thực tế, bạn sẽ cần gửi Ajax request để lấy dữ liệu người dùng
    document.getElementById("editUserId").value = userId;
    
    // Hiển thị modal
    const modal = new bootstrap.Modal(document.getElementById("editUserModal"));
    modal.show();
}

function deleteUser(userId) {
    document.getElementById("deleteUserId").value = userId;
    
    // Hiển thị modal
    const modal = new bootstrap.Modal(document.getElementById("deleteUserModal"));
    modal.show();
}

function resetPassword(userId) {
    document.getElementById("resetPasswordUserId").value = userId;
    
    // Hiển thị modal
    const modal = new bootstrap.Modal(document.getElementById("resetPasswordModal"));
    modal.show();
}
</script>

<jsp:include page="/views/common/footer.jsp"></jsp:include>