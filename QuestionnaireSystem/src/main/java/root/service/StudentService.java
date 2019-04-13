package root.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import root.dao.NaireDao;
import root.dao.StudentDao;
import root.model.Naire;
import root.model.ResCount;
import root.model.Student;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Vector;

import static root.Util.StringAndListUtil.strToList;

@Service
public class StudentService {
    /**
     * 学生最大选课数量, 默认为5门
     */
    private int maxSubject;
    /**
     * 学生对象、问卷对象、问卷数据库对象及，学生数据库对象
     */
    private Student student = new Student();
    private Naire naire = new Naire();

    @Autowired
    private StudentDao studentDao;

    @Autowired
    private NaireDao naireDao;
    /**
     * 学生未选的课程列表
     */
    private List<String> unCompleteSubjectsList = new Vector<>();

    @PostConstruct
    public void init(){
        maxSubject = 5;
        unCompleteSubjectsList = naireDao.getAllSubjects();
    }
    /**
     * 用来获取需要催缴问卷的课程列表
     */
    public List<String> getPressSubjectList(){
        /**
         * 保存naireDao中IsPress为1的科目列表
         */
        List<String> pressSubjectList = new Vector<String>();
        /**
         * 保存最后该student需要催缴的科目列表
         */
        List<String> pressSubjectResList = new Vector<String>();
        /**
         * 拿到所选的课程，首先判断naireDao
         * 中subject对应的IsPress是否为0，
         * 如果为0，则不用，否则需要催缴
         */
        List<String> subjectListTmp = studentDao.getSubjects(student);
        if (subjectListTmp == null) {
            return null;
        }
        for(String str : subjectListTmp) {
            naire.setSubject(str);
            if(naireDao.getPress(naire) == 1){
                pressSubjectList.add(str);
            }
        }
        /**
         * 根据pressSubjectList，去naireDao中根据课程名拿到
         * 未完成的学生名单与之相比，如果姓名与自己相同，则需要
         * 进行催缴，保存到pressSubjectResList
         */
        for(String str : pressSubjectList) {
            naire.setSubject(str);
            List<String> uncompletesListTmp = naireDao.getUncompletes(naire);
            if(uncompletesListTmp.indexOf(student.getName()) != -1){
                pressSubjectResList.add(str);
            }
        }
       return pressSubjectResList;
    }

    /**
     * 学生登陆
     */
    public boolean Login(String id, String password){
        student.setId(id);
        student.setPassword(password);
        if((student = studentDao.isExist(student)) == null)
            return false;
        return true;
    }

    /**
     * 添加课程
     * @param //item为课程名称
     */
    public List<String> AddSubject(String item){
        /**
         * 从数据库拿到对应学生的subjectList
         */
        student.setId(student.getId());
        List<String> subjectsListTmp = studentDao.getSubjects(student);
        if(subjectsListTmp.size() == maxSubject)
            return null;
        /**
         * 是否已经添加该课程
         */
        if(subjectsListTmp.indexOf(item) != -1)
            return null;
        /**
         * 未选课程列表中是否存在
         */
        if(unCompleteSubjectsList.indexOf(item) == -1)
            return null;

        /**
         * 从未选课程列表中将该课程删除
         */
        unCompleteSubjectsList.remove(item);

        subjectsListTmp.add(item);
        student.setSubjects(subjectsListTmp);
        /**
         * 添加成功后更新到数据库
         */
        studentDao.UpdateSubjects(student);
        /**
         * 还要将学生姓名添加到naireDao中
         * 首先，拿到naireDao中的学生姓名List
         * 然后将该学生姓名添加到List，最后将
         * List更新到naireDao中
         */
        naire.setSubject(item);
        List<String> listTmp = naireDao.getStudents(naire);
        listTmp.add(student.getName());
        naire.setStudents(listTmp);
        naireDao.UpdateStudents(naire);

        /**
         * 也需要跟新naireDao中的未完成学生名单
         */
        listTmp = naireDao.getUncompletes(naire);
        listTmp.add(student.getName());
        naireDao.UpdateUncompletes(naire);
        return unCompleteSubjectsList;
    }

    /**
     * 删除科目
     * @param //item表示科目名称
     */
    public boolean DelCourse(String item){
        /**
         * 从数据库拿到对应学生的subjectList
         */
        student.setId(student.getId());
        List<String> subjectsListTmp = studentDao.getSubjects(student);

        if(subjectsListTmp.remove(item)){
            student.setSubjects(subjectsListTmp);
            /**
             * 删除成功后更新到数据库
             */
            studentDao.UpdateSubjects(student);
            /**
             * 还要将学生姓名从naireDao中删除
             * 首先，拿到naireDao中的学生姓名List
             * 然后将该学生姓名从List中删除，最后将
             * List更新到naireDao中
             */
            naire.setSubject(item);
            List<String> listTmp = naireDao.getStudents(naire);
            listTmp.remove(student.getName());
            naire.setStudents(listTmp);
            naireDao.UpdateStudents(naire);

            /**
             * 也需要跟新naireDao中的未完成学生名单
             */
            listTmp = naireDao.getUncompletes(naire);
            listTmp.remove(student.getName());
            naireDao.UpdateUncompletes(naire);
            return true;
        }
        /**
         * 否则，删除失败
         */
        return false;
    }

    public List<String> getUnCompleteSubjectsList() { return unCompleteSubjectsList; }
    public boolean isExist() { return student != null;}
    /**
     * 查看学生所选课程
     */
    public  List<String> getSubjects(){
        /**
         * 从数据库拿到对应学生的subjectList
         */
        List<String> subjectsListTmp = studentDao.getSubjects(student);

        return subjectsListTmp;
    }

    /**
     * 查看某一科问卷
     * @param item //科目名称
     */
    public List<String> getNaire(String item){
        naire.setSubject(item);
        /**
         * 从数据库拉取问卷信息
         * 保存在成员变量naire中
         */
        naire.setQuestionnaires(strToList(naireDao.getQuestionnaires(naire)));
        return naire.getQuestionnaires();
    }

    /**
     * 查看结果
     * 这里返回该学生所选的某一门课程
     * 对应问卷的结果
     */
    public List<ResCount> getSutdentNaireRes(String item){
        List<ResCount> resCountList = TeacherService.getResultCouont(item);
        return resCountList;
    }
}
