package root.model;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

public class Student extends User {
    /**
     * 学生最大选课数量, 默认为5门
     */
    private int _max_subject;
    /**
     * 学生所选课程
     */
    private Vector<String> _subject = new Vector<String>();
    /**
     * key为课程，value为问卷
     */
    private Map<String, Vector<String>> _questionnaireMap = new HashMap<String, Vector<String>>();

    public Student(int max_subject){
        _max_subject = max_subject;
    }
    public Student(){
        _max_subject = 5;
    }

    /**
     * 添加课程,并将课程与对应的问卷作为键值对插入到map中
     * @param //item为课程名称
     * @param //questionnaire为该课程所对应的问卷
     */
    public boolean AddSubject(String item, Vector<String> questionnaire){
        if(_subject.size() == _max_subject)
            return false;

        _subject.add(item);
        _questionnaireMap.put(item, questionnaire);
        return true;
    }

    /**
     * 删除科目，并从map中删除该键值对
     * @param //item表示科目名称
     */
    public boolean DelCourse(String item){
        if(_subject.isEmpty())
            return false;

        if(_subject.remove(item)){
            /**
             * 删除成功,再去删除map中的
             */
            Iterator<String> iter = _questionnaireMap.keySet().iterator();
            while (iter.hasNext()) {

                String key = iter.next();
                if(key == item){
                    iter.remove();
                }
            }
            return true;
        }
        /**
         * 否则，删除失败
         */
        return false;
    }

    /**
     * 用来获取_questionnaireMap
     */
    public Map GetQuestionMap(){ return _questionnaireMap; }

}
