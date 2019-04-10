package root.model;



public class Student{
    /**
     * 学号，密码
     */
    private String id;
    private String password;
    /**
     * 学生已选科目
     */
    private String hasSubject;

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getPWD() { return password; }
    public void setPWD(String password) { this.password = password; }
    public String getHasSubject() { return hasSubject; }
    public void setHasSubject(String hasSubject) { this.hasSubject = hasSubject; }

}
