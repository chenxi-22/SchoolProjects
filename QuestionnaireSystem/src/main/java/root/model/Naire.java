package root.model;


import java.util.List;
import java.util.Vector;

/**
 * 问卷
 */

public class Naire {
    /**
     * 科目名称
     */
    private String subject;

    /**
     * 问卷内容，两个其实一样都是问题，一个是全部问题
     * 存到一个String，每个问题间用'\3'分隔，另一个是
     * 每一个问题存为一个String，全部问题组成一个List
     */
    private List<String> questionnaires = new Vector<>();

    /**
     * 选择该课程的学生名单
     */
    private List<String> students = new Vector<>();

    /**
     * 未完成问卷的学生名单
     */
    private List<String> uncompletes = new Vector<>();

    public List<String> getUncompletes() {
        return uncompletes;
    }

    public void setUncompletes(List<String> uncompletes) {
        this.uncompletes = uncompletes;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public List<String> getQuestionnaires() {
        return questionnaires;
    }

    public void setQuestionnaires(List<String> questionnairesList) {
        this.questionnaires = questionnaires;
    }

    public List<String> getStudents() {
        return students;
    }

    public void setStudents(List<String> students) {
        this.students = students;
    }
}
