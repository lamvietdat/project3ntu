package lvd.model;

import java.math.BigDecimal;

public class Tutor {
    private int tutorId;
    private int userId;
    private String qualification;
    private String experience;
    private BigDecimal hourlyRate;
    private String bio;
    private String status; // active, inactive
    private User user;

    public Tutor() {}

    public Tutor(int tutorId, int userId, String qualification, String experience, BigDecimal hourlyRate, String bio, String status) {
        this.tutorId = tutorId;
        this.userId = userId;
        this.qualification = qualification;
        this.experience = experience;
        this.hourlyRate = hourlyRate;
        this.bio = bio;
        this.status = status;
    }

    // Getters và Setters
    public int getTutorId() {
        return tutorId;
    }

    public void setTutorId(int tutorId) {
        this.tutorId = tutorId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public BigDecimal getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(BigDecimal hourlyRate) {
        this.hourlyRate = hourlyRate;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}