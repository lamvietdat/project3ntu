package lvd.model;

public class Subject {
    private int subjectId;
    private String subjectName;
    private String description;
    private String category;

    public Subject() {}

    public Subject(int subjectId, String subjectName, String description, String category) {
        this.subjectId = subjectId;
        this.subjectName = subjectName;
        this.description = description;
        this.category = category;
    }

    // Getters và Setters
    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}