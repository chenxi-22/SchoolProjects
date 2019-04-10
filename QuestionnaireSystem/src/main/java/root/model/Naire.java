package root.model;


import java.util.Arrays;
import java.util.List;

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
    private List<String> questionnaires;

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

}
