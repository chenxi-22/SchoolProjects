package root.model;

/**
 * 问卷
 */
public class Naire {
    /**
     * 科目名称
     */
    private String subject;

    /**
     * 问卷内容
     */
    private String questionnaires;

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getQuestionnaires() {
        return questionnaires;
    }

    public void setQuestionnaires(String questionnaires) {
        this.questionnaires = questionnaires;
    }
}
