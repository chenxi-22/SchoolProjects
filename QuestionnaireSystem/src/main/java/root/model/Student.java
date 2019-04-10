package root.model;

import java.util.List;
import java.util.Vector;

public class Student{
    private String id;
    private String password;
    private List<String> subjects = new Vector<>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<String> getSubjects() {
        return subjects;
    }

    public void setSubjects(List<String> subjects) {
        this.subjects= subjects;
    }
}
