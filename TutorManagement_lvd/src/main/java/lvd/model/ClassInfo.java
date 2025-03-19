package lvd.model;

import java.math.BigDecimal;
import java.sql.Date;

public class ClassInfo {
    private int classId;
    private int tutorId;
    private int subjectId;
    private String className;
    private String description;
    private Date startDate;
    private Date endDate;
    private String schedule;
    private BigDecimal price;
    private int maxStudents;
    private String status; // open, in_progress, completed, cancelled
    private Tutor tutor;
    private Subject subject;

    public ClassInfo() {}

    public ClassInfo(int classId, int tutorId, int subjectId, String className, String description, Date startDate, Date endDate, String schedule, BigDecimal price, int maxStudents, String status) {
        this.classId = classId;
        this.tutorId = tutorId;
        this.subjectId = subjectId;
        this.className = className;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.schedule = schedule;
        this.price = price;
        this.maxStudents = maxStudents;
        this.status = status;
    }

    // Getters và Setters
    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getTutorId() {
        return tutorId;
    }

    public void setTutorId(int tutorId) {
        this.tutorId = tutorId;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getMaxStudents() {
        return maxStudents;
    }

    public void setMaxStudents(int maxStudents) {
        this.maxStudents = maxStudents;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Tutor getTutor() {
        return tutor;
    }

    public void setTutor(Tutor tutor) {
        this.tutor = tutor;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }
}