package root.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import root.dao.NaireDao;
import root.dao.TeacherDao;
import root.model.Naire;
import root.model.ResCount;
import root.model.Teacher;


import javax.annotation.PostConstruct;
import java.util.*;

@Service
public class TeacherService {
    private Teacher teacher = new Teacher();

    @Autowired
    private TeacherDao teacherDao;

    @Autowired
    private NaireDao naireDao;

    private Naire naire = new Naire();


    /**
     * 每个问卷默认问题数量最大为20
     */
    private int maxQuestionCount;
    private static int staticMaxQuestionCount;

    /**
     * 课程列表，所有管理员都一样
     */
    private List<String> subjectsList = new Vector<>();

    /**
     * key为课程，value为问卷
     */
    private Map<String, Naire> questionnaireMap = new HashMap<String, Naire>();
    /**
     * key为科目，value为每个问题的统计结果，数组下标表示问题编号
     * 为static类型，所有实例化的类看到的都是一样的
     */

    // TODO 这里为了方便测试将其改为public，记得改回private
    public static Map<String, List<ResCount>> resCountMap = new HashMap<>();

    @PostConstruct
    public void init(){
        maxQuestionCount = 20;
        subjectsList = naireDao.getAllSubjects();

    }

    public boolean Login(String id, String password){
        teacher.setId(id);
        teacher.setPassword(password);
        return teacherDao.isExist(teacher);
    }


    private boolean IsSubExit(String subject){
        for(String str : subjectsList) {
            if(str.equals(subject)){
                return true;
            }
        }
        return false;
    }
    private boolean IsLegal(String subject){
        if((questionnaireMap.get(subject) != null) && (IsSubExit(subject)))
            return true;
        return false;
    }

    /**
     * 获取选课信息，也就是说返回当前
     * 已有课程，每门课都有哪些学生选了
     */
    public Map<String, List<String>> getSubjectInfo(){
        Map<String, List<String>> resMap = new HashMap<String, List<String>>();

        for(String str : subjectsList) {
            naire.setSubject(str);
            resMap.put(str, naireDao.getStudents(naire));
        }

        return resMap;
    }

    /**
     * 催缴问卷
     */
    public void PressQuestionnaire(String subject){
        /**
         * 将naireDao中subject对应的IsPress设置为1表示
         * 催缴问卷，学生在登陆时，需要检测自己IsPress
         */
        naire.setSubject(subject);
        naireDao.UpdatePress(naire);
    }

    /**
     * 添加问卷
     */
    public boolean AddNaire(String subject, List<String> questionnaire){
        if(!IsSubExit(subject))
        {
            return false;
        }

        if(questionnaire == null || questionnaire.size() == 0 || questionnaire.get(0).equals(""))
        {
            return false;
        }

        Naire nairetmp = new Naire();
        nairetmp.setSubject(subject);
        nairetmp.setQuestionnaires(questionnaire);
        naireDao.UpdateQuestions(nairetmp);

        /**
         * 添加完问卷后，需要重新设置未答卷的学生
         */

        List<String> students = naireDao.getStudents(nairetmp);
        if(students == null || students.size() == 0 || students.get(0).equals(""))
        {
            students = new Vector<>();
        }
        nairetmp.setUncompletes(students);
        naireDao.UpdateUncompletes(nairetmp);
        return true;
    }

    /**
     * 用来给问卷添加一个问题
     * @param subject //科目名称
     * @param question //问题
     */
    public boolean AddQuestion(String subject, String question){
        /**
         * 判断科目列表中是否合法，即是否有有该科目，quesetionMap返回结果不为空
         * 问题数量是否已经达到最大数量
         */
        if(IsLegal(subject)){
            return false;
        }
        else if(questionnaireMap.get(subject).getQuestionnaires().size() >= maxQuestionCount){
            return false;
        }
        else{
            questionnaireMap.get(subject).getQuestionnaires().add(question);
            /**
             * 添加成功后，更新到数据库
             * 如果是第一次，需要设置naire中的subject
             */
            if(1 == questionnaireMap.get(subject).getQuestionnaires().size()){
                questionnaireMap.get(subject).setSubject(subject);
            }
            /**
             * 数据库操作--传naire对象
             */
            naireDao.UpdateQuestions(questionnaireMap.get(subject));
        }
        return true;
    }

    /**
     * 用来删除某个科目的问卷中的问题
     */
    public boolean DelQuestion(String subject, String question){
        /**
         * 判断科目列表中是否合法，即是否有有该科目，quesetionMap返回结果不为空
         * 问题数量是否已经为0
         */
        if(IsLegal(subject)){
            return false;
        }
        else if(questionnaireMap.get(subject).getQuestionnaires().size() <= 0){
            return false;
        }
        else{
            questionnaireMap.get(subject).getQuestionnaires().remove(question);
            /**
             * 删除成功，更新数据库
             */
            naireDao.UpdateQuestions(questionnaireMap.get(subject));
        }
        return true;
    }

    /**
     * 用来修改问题
     * @param subject
     * @param srcId //问题原来的编号，即在数组中的下标，这里在使用时要-1
     * @param destQuestion //修改后的问题
     * @return
     */
    public boolean ModefQuestion(String subject, int srcId, String destQuestion){
        /**
         * 判断科目列表中是否合法，即是否有有该科目，_quesetionMap返回结果不为空
         */
        if(IsLegal(subject)){
            return false;
        }

        srcId -= 1;
        if(srcId < 0 || srcId >= questionnaireMap.get(subject).getQuestionnaires().size())
            return false;

        questionnaireMap.get(subject).getQuestionnaires().set(srcId, subject);
        /**
         * 修改成功，更新数据库
         */
        naireDao.UpdateQuestions(questionnaireMap.get(subject));
        return true;
    }


    private static boolean IsLegalInResultCountMap(String subject, int id){

        if(id < 0 || id >= staticMaxQuestionCount)
            return false;
        return true;
    }

    /**
     * 这里只需要修改内存中的resCountMap
     */
    public boolean AnswerQuestion(String subject, List<String> ansList){
        if(!IsSubExit(subject))
        {
            return false;
        }

        System.out.println(ansList.size());
        for(String str : ansList){
            System.out.println(str);
        }
        if(ansList == null || ansList.size() == 0 || ansList.get(0).equals(""))
        {
            System.out.println("##################");
            return false;
        }

        int count = 1;
        for(String str : ansList){
            if(str.equals("yes")){
                AddResultCount(subject, count, 1);
                count++;
            }
            if(str.equals("no")){
                AddResultCount(subject, count, 0);
                count++;
            }
        }

        return true;
    }

    /**
     * 给问卷中某个问题的答案（是或否）+1
     * @param id //表示问卷中问题的编号,从1开始
     */
    private static boolean AddResultCount(String subject, int id, int answer){
        /**
         * 因为数组下标从0开始，所以这里-1，方便判断
         */
        if(!IsLegalInResultCountMap(subject, id-1)){
            return false;
        }
        /**
         * 如果这个问题第一次回答，因为map中并没有该元素
         * 所以需要将该元素插入
         */
        if(resCountMap.get(subject) == null){
            ResCount resTmp = null;
            resTmp._noCount = 0;
            resTmp._yesCount = 0;
            List<ResCount> resCountTmp = Collections.nCopies(staticMaxQuestionCount, resTmp);
            resCountMap.put(subject, resCountTmp);
        }

        if(0 == answer) {
            ++resCountMap.get(subject).get(id)._yesCount;
        }
        else{
            ++resCountMap.get(subject).get(id)._noCount;
        }


        return true;
    }

    /**
     * 重置（归零）某一个科目问卷的统计结果
     */
    public static boolean resetResultCount(String subject){
        if(resCountMap.get(subject) == null)
            return false;
        /**
         * 遍历List
         */

        for (ResCount item : resCountMap.get(subject)) {
            item._yesCount = 0;
            item._noCount = 0;
        }
        return true;
    }

    /**
     * 获取某一个科目问卷的统计结果（是或否的统计数量）
     */
    public static List<ResCount> getResultCount(String subject){
        return resCountMap.get(subject);
    }

    /**
     * 获取所有课程，一般这个不变
     * @return
     */
    public List<String> getALllSubject() { return naireDao.getAllSubjects(); }

}
