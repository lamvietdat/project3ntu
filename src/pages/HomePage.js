import { Link } from "react-router-dom";
import bannerImg from "../assets/images/banner.jpg";
import tutor1Img from "../assets/images/tutor1.jpg";
import tutor2Img from "../assets/images/tutor2.jpg";
import tutor3Img from "../assets/images/tutor3.jpg";
import logoImg from "../assets/images/logo.jpg"; // Thêm logo
import "../styles/HomePage.css";

function HomePage() {
  const tutors = [
    { id: 1, name: "Nguyễn Văn A", subject: "Toán - Lý", experience: "5 năm kinh nghiệm", image: tutor1Img },
    { id: 2, name: "Trần Thị B", subject: "Tiếng Anh", experience: "3 năm kinh nghiệm", image: tutor2Img },
    { id: 3, name: "Lê Văn C", subject: "Hóa học", experience: "4 năm kinh nghiệm", image: tutor3Img },
    { id: 1, name: "Nguyễn Văn A", subject: "Toán - Lý", experience: "5 năm kinh nghiệm", image: tutor1Img },
    { id: 2, name: "Trần Thị B", subject: "Tiếng Anh", experience: "3 năm kinh nghiệm", image: tutor2Img },
    { id: 3, name: "Lê Văn C", subject: "Hóa học", experience: "4 năm kinh nghiệm", image: tutor3Img },
    { id: 1, name: "Nguyễn Văn A", subject: "Toán - Lý", experience: "5 năm kinh nghiệm", image: tutor1Img },
    { id: 2, name: "Trần Thị B", subject: "Tiếng Anh", experience: "3 năm kinh nghiệm", image: tutor2Img },
    { id: 3, name: "Lê Văn C", subject: "Hóa học", experience: "4 năm kinh nghiệm", image: tutor3Img },
    { id: 1, name: "Nguyễn Văn A", subject: "Toán - Lý", experience: "5 năm kinh nghiệm", image: tutor1Img },
    
  ];

  const classes = [
    { id: 1, subject: "Toán lớp 10", schedule: "T2, T4, T6", location: "Hà Nội" },
    { id: 2, subject: "Tiếng Anh lớp 8", schedule: "T3, T5", location: "TP. HCM" },
    { id: 3, subject: "Lý lớp 11", schedule: "T7, CN", location: "Đà Nẵng" },
    { id: 1, subject: "Toán lớp 10", schedule: "T2, T4, T6", location: "Hà Nội" },
    { id: 2, subject: "Tiếng Anh lớp 8", schedule: "T3, T5", location: "TP. HCM" },
    { id: 3, subject: "Lý lớp 11", schedule: "T7, CN", location: "Đà Nẵng" },
    { id: 1, subject: "Toán lớp 10", schedule: "T2, T4, T6", location: "Hà Nội" },
    { id: 2, subject: "Tiếng Anh lớp 8", schedule: "T3, T5", location: "TP. HCM" },
    { id: 3, subject: "Lý lớp 11", schedule: "T7, CN", location: "Đà Nẵng" },
    { id: 1, subject: "Toán lớp 10", schedule: "T2, T4, T6", location: "Hà Nội" },
    
  ];

  return (
    <div className="homepage">
      {/* Header */}
        <header className="header">
            <div className="logo">
                <img src={logoImg} alt="Logo trung tâm gia sư" />
             </div>
             <div className="contact-info">
                <span>Email: lamvietdat.02032004@gmail.com</span>
                <span>Tư vấn 24/7</span>
                <span>📞 0965621585</span>
            </div>
        </header>
      
      {/* Phần banner */}
      <section className="intro">
         <img src={bannerImg} alt="Trung tâm gia sư" className="banner left" />
        <div className="intro-content">
        <h1>Chào mừng đến với Trung tâm Gia Sư</h1>
        <p>Chúng tôi kết nối học viên với những gia sư giỏi nhất.</p>
        </div>
        <img src={bannerImg} alt="Trung tâm gia sư" className="banner right" />
     </section>

      {/* Đăng nhập & Đăng ký */}
      <section className="navbar">
        <div className="left-links">
            <Link to="/thongtingiasu" className="btn">Thông tin gia sư</Link>
            <Link to="/thongtinlophoc" className="btn">Thông tin lớp học</Link>
        </div>
        <div className="right-links">
            <Link to="/login" className="btn">Đăng nhập</Link>
            <Link to="/register" className="btn">Đăng ký</Link>
        </div>
      </section>
      {/* Giới thiệu về trung tâm gia sư */}
      <section className="about-tutoring-center">
  <h2>Giới thiệu về Trung tâm Gia Sư</h2>
  <p>Trung tâm gia sư là một cơ sở giáo dục tư nhân cung cấp dịch vụ gia sư cho học sinh ở nhiều cấp độ khác nhau, từ tiểu học đến đại học.</p>
  
  <div className="info-section">
    <div className="info-item">
      <h3>Mục đích hoạt động:</h3>
      <ul>
        <li><strong>Nâng cao kiến thức:</strong> Giúp học sinh củng cố kiến thức, bù đắp những lỗ hổng trong quá trình học tập.</li>
        <li><strong>Luyện thi:</strong> Hỗ trợ học sinh chuẩn bị cho các kỳ thi quan trọng như thi chuyển cấp, thi tốt nghiệp, thi đại học.</li>
        <li><strong>Phát triển kỹ năng:</strong> Giúp học sinh rèn luyện các kỹ năng học tập, kỹ năng giải quyết vấn đề.</li>
      </ul>
    </div>
    
    <div className="info-item">
      <h3>Các dịch vụ thường cung cấp:</h3>
      <ul>
        <li>Gia sư tại nhà</li>
        <li>Gia sư trực tuyến</li>
        <li>Lớp học nhóm</li>
        <li>Luyện thi chuyên sâu</li>
      </ul>
    </div>
    
    <div className="info-item">
      <h3>Đối tượng gia sư:</h3>
      <ul>
        <li>Giáo viên</li>
        <li>Sinh viên</li>
        <li>Gia sư tự do</li>
      </ul>
    </div>
    
    <div className="info-item">
      <h3>Lợi ích của việc học tại trung tâm gia sư:</h3>
      <ul>
        <li>Cá nhân hóa</li>
        <li>Linh hoạt</li>
        <li>Hiệu quả</li>
        <li>Tiết kiệm thời gian</li>
      </ul>
    </div>
    
    <div className="info-item">
      <h3>Một số lưu ý khi chọn trung tâm gia sư:</h3>
      <ul>
        <li>Uy tín của trung tâm</li>
        <li>Chất lượng gia sư</li>
        <li>Phương pháp giảng dạy</li>
        <li>Học phí</li>
      </ul>
    </div>
  </div>
</section>
      {/* Danh sách gia sư */}
      <section className="tutor-list">
        <h2>Gia sư nổi bật</h2>
        <div className="tutors">
          {tutors.map((tutor) => (
            <div key={tutor.id} className="tutor-card">
              <img src={tutor.image} alt={tutor.name} />
              <h3>{tutor.name}</h3>
              <p>Môn học: {tutor.subject}</p>
              <p>{tutor.experience}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Danh sách lớp học */}
      <section className="class-list">
        <h2>Thông tin lớp học</h2>
        <div className="classes">
          {classes.map((cls) => (
            <div key={cls.id} className="class-card">
              <h3>{cls.subject}</h3>
              <p>Lịch học: {cls.schedule}</p>
              <p>Địa điểm: {cls.location}</p>
            </div>
          ))}
        </div>
      </section>
      <footer className="footer">
        <div className="footer-info">
          <h3>Trung tâm Gia Sư</h3>
          <p>Địa chỉ: Số 1, Ngõ 1, Trần Quốc Hoàn, Cầu Giấy, Hà Nội</p>
          <p>Địa chỉ: Số 1, Ngõ 1, Trần Quốc Hoàn, Cầu Giấy, Đà Nẵng</p>
          <p>Địa chỉ: Số 1, Ngõ 1, Trần Quốc Hoàn, Cầu Giấy, TP HCM</p>
          <p>Liên hệ: 0965621585</p>
          <p>Email: lamvietdat.02032004@gmail.com</p>
        </div>
        <div className="footer-links">
          <h3>Bài viết gần đây</h3>
          <ul>
            <li>Cộng tác viên - Giới thiệu lớp</li>
            <li>Quy trình nhận lớp</li>
            <li>Lý do từ chối tuyển chọn gia sư</li>
          </ul>
        </div>
        <div className="footer-social">
          <h3>Facebook</h3>
          <p>Fanpage: Gia Sư Trung Tâm</p>
          <p>71,439 followers</p>
        </div>
      </footer>
    </div>
  );
}

export default HomePage;