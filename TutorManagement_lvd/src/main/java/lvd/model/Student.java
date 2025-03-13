package lvd.model;

public class Student {
    private int studentId;
    private int userId;
    private String educationLevel;
    private String studyGoals;
    private String parentContact;
    private User user;

    public Student() {}

    public Student(int studentId, int userId, String educationLevel, String studyGoals, String parentContact) {
        this.studentId = studentId;
        this.userId = userId;
        this.educationLevel = educationLevel;
        this.studyGoals = studyGoals;
        this.parentContact = parentContact;
    }

    // Getters và Setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(String educationLevel) {
        this.educationLevel = educationLevel;
    }

    public String getStudyGoals() {
        return studyGoals;
    }

    public void setStudyGoals(String studyGoals) {
        this.studyGoals = studyGoals;
    }

    public String getParentContact() {
        return parentContact;
    }

    public void setParentContact(String parentContact) {
        this.parentContact = parentContact;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}