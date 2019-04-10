package root.model;


import java.util.List;
import java.util.Vector;

public class Student{
    /**
     * 学号，密码
     */
    private String id;
    private String password;
    /**
     * 学生已选科目,String方便数据库操作
     * List<String>方便外部操作
     */
    private String subjectsStr;
    private List<String> subjectsList = new Vector<String>();

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getPWD() { return password; }
    public void setPWD(String password) { this.password = password; }
    public String getHasSubject() { return subjectsStr; }
    public void setHasSubject(String subjectsStr) { this.subjectsStr = subjectsStr; }

    public List<String> getSubjectsList() { return subjectsList; }

    public void setSubjectsList(List<String> subjectsList) { this.subjectsList = subjectsList; }

}
