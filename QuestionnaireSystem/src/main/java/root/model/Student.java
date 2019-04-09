package root.model;

import java.util.Map;
import java.util.Iterator;

public class Student extends User {
    private int _max_course;  //学生最大选课数量, 默认为5门
    private String [] _course; //学生所选课程
    private int _index;  //记录当前_course最后一个元素的坐标
    private Map<String, String[]> _questionnaireMap;   //key为课程，value为问卷

    public Student(int max_course){
        _max_course = max_course;
        _course = new String[_max_course];
        _index = 0;
    }
    public Student(){
        _max_course = 5;
        _course = new String[_max_course];
    }

    public boolean AddCourse(String item, String[] questionnaire){
        if(_course.length == _max_course)
            return false;

        _course[_index++] = item;
        _questionnaireMap.put(item, questionnaire);
        return true;
    }

    public boolean DelCourse(String item){
        if(_course.length == 0)
            return false;

        int res = 0;
        int flag = 0;
        for(int i = 0; i < _course.length; ++i){
            if(_course[i] != item){
                _course[res++] = _course[i];
            }
            else{
                flag = 1;
                --_index;

                Iterator<String> iter = _questionnaireMap.keySet().iterator();
                while (iter.hasNext()) {

                    String key = iter.next();
                    if(key == item){
                        iter.remove();
                    }
                }
            }

        }

        if(1 == flag)
            return true;
        return false;
    }

    public Map GetQuestionMap(){ return _questionnaireMap; }

}
