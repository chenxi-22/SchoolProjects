package root.model;

import java.util.Map;
import java.util.Iterator;


public class Teacher extends User {
    private class ResCount{
        public int _yesCount;
        public int _noCount;
    }

    //问卷，其实就是封装了String数组，数组下标表示问题编号
    private class Naire{
        public String _quest
    }
    private Map<String, String[]> _questionnaireMap;   //key为课程，value为问卷
    private static Map<String, ResCount[]> _res_count_map;    //key为科目，value为每个问题的统计结果，数组下标表示问题编号

    public Teacher(){}

    public boolean AddQuestion(String subject, String question){

    }
    public boolean DelQuestion(String subject, String question){

    }
}
