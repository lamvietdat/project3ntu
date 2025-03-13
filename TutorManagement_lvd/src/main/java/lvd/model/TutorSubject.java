package lvd.model;

public class TutorSubject {
    private int tutorSubjectId;
    private int tutorId;
    private int subjectId;
    private Tutor tutor;
    private Subject subject;

    public TutorSubject() {}

    public TutorSubject(int tutorSubjectId, int tutorId, int subjectId) {
        this.tutorSubjectId = tutorSubjectId;
        this.tutorId = tutorId;
        this.subjectId = subjectId;
    }

    // Getters và Setters
    public int getTutorSubjectId() {
        return tutorSubjectId;
    }

    public void setTutorSubjectId(int tutorSubjectId) {
        this.tutorSubjectId = tutorSubjectId;
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
