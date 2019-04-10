package root.service;

import root.dao.NaireDao;
import root.dao.StudentDao;
import root.model.Naire;
import root.model.Student;

import java.util.List;

import static root.Util.StringAndListUtil.strToList;


public class StudentService {

    /**
     * 学生最大选课数量, 默认为5门
     */
    private int maxSubject;
    /**
     * 学生对象、问卷对象、问卷数据库对象及，学生数据库对象
     */
    private Student student;
    private Naire naire;
    private StudentDao studentDao;
    private NaireDao naireDao;


    public StudentService(int max_subject){
        maxSubject = max_subject;
    }
    public StudentService(){
        maxSubject = 5;
    }

    public boolean Login(String id, String password){
        student.setId(id);
        student.setPassword(password);
        return studentDao.isExist(student);
    }

    /**
     * 添加课程,并将课程与对应的问卷作为键值对插入到map中
     * @param //item为课程名称
     */
    public boolean AddSubject(String id, String item){
        /**
         * 从数据库拿到对应学生的subjectList
         */
        student.setId(id);
        List<String> subjectsListTmp = studentDao.getSubjects(student);
        if(subjectsListTmp.size() == maxSubject)
            return false;
        /**
         * 是否已经添加该课程
         */
        if(subjectsListTmp.indexOf(item) != -1)
            return false;
        subjectsListTmp.add(item);
        student.setSubjects(subjectsListTmp);
        /**
         * 添加成功后更新到数据库
         */
        studentDao.UpdateSubjects(student);
        return true;
    }

    /**
     * 删除科目，并从map中删除该键值对
     * @param //item表示科目名称
     */
    public boolean DelCourse(String id, String item){
        /**
         * 从数据库拿到对应学生的subjectList
         */
        student.setId(id);
        List<String> subjectsListTmp = studentDao.getSubjects(student);

        if(subjectsListTmp.remove(item)){
            student.setSubjects(subjectsListTmp);
            /**
             * 删除成功后更新到数据库
             */
            studentDao.UpdateSubjects(student);
            return true;
        }
        /**
         * 否则，删除失败
         */
        return false;
    }

    /**
     * 查看学生所选课程
     */
    public  List<String> getSubjects(String id){
        /**
         * 从数据库拿到对应学生的subjectList
         */
        student.setId(id);
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



}
