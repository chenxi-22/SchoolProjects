package root.model;


import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;


public class Teacher extends User {
    /**
     * 用来保存答案数量
     */
    private class ResCount{
        public int _yesCount;
        public int _noCount;
    }

    /**
     * 每个问卷默认问题数量最大为20
     */
    private int _max_question_count;
    private static int _static_max_question_count;
    /**
     * 课程名单，为static，所有管理员看到的课程列表是一样的
     */
    private Vector<String> _subject_list = new Vector<String>();

    /**
     * key为课程，value为问卷,数组下标表示问题编号
     */
    private Map<String, Vector<String>> _questionnaireMap = new HashMap<String, Vector<String>>();
    /**
     * key为科目，value为每个问题的统计结果，数组下标表示问题编号
     * 为static类型，所有实例化的类看到的都是一样的
     */

    // TODO 怎么初始化？保证value,即数组的默认大小
    private static Map<String, Vector<ResCount>> _res_count_map = new HashMap<String, Vector<ResCount>>();

    public Teacher(Vector<String> subject, int max_question_count){
        _subject_list = subject;
        _max_question_count = max_question_count;
    }
    public Teacher(Vector<String> subject){
        _subject_list = subject;
        _max_question_count = 20;
    }
    public Teacher() {}

    private boolean IsSubExit(String subject){
        for(Iterator it = _subject_list.iterator(); it.hasNext();) {
            if(it.next() == subject)
                return true;
        }
        return false;
    }
    private boolean IsLegal(String subject){
        if((_questionnaireMap.get(subject) != null) && (IsSubExit(subject)))
            return true;
        return false;
    }

    /**
     * 用来给问卷添加一个问题
     * @param subject //科目名称
     * @param question //问题
     */
    public boolean AddQuestion(String subject, String question){
        /**
         * 判断科目列表中是否合法，即是否有有该科目，_quesetionMap返回结果不为空
         * 问题数量是否已经达到最大数量
         */
        if(IsLegal(subject)){
            return false;
        }
        else if(_questionnaireMap.get(subject).size() >= _max_question_count){
            return false;
        }
        else{
            _questionnaireMap.get(subject).add(question);
        }
        return true;
    }

    /**
     * 用来删除某个科目的问卷中的问题
     */
    public boolean DelQuestion(String subject, String question){
        /**
         * 判断科目列表中是否合法，即是否有有该科目，_quesetionMap返回结果不为空
         * 问题数量是否已经为0
         */
        if(IsLegal(subject)){
            return false;
        }
        else if(_questionnaireMap.get(subject).size() <= 0){
            return false;
        }
        else{
            _questionnaireMap.get(subject).remove(question);
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
        if(srcId < 0 || srcId >= _questionnaireMap.get(subject).size())
            return false;

        _questionnaireMap.get(subject).set(srcId, subject);
        return true;
    }

    public Map<String, Vector<String>> GetQuestonnaireMap() { return _questionnaireMap; }


    private static boolean IsLegalInResultCountMap(String subject, int id){
        if(_res_count_map.get(subject) == null)
            return false;
        if(id < 0 || id >= _static_max_question_count)
            return false;
        return true;
    }

    /**
     * 给问卷中某个问题的答案（是或否）+1
     * @param id //表示问卷中问题的编号,从1开始
     */
    public static boolean AddResultCount(String subject, int id, int answer){
        /**
         * 因为数组下标从0开始，所以这里-1，方便判断
         */
        if(!IsLegalInResultCountMap(subject, id-1)){
            return false;
        }

        if(0 == answer) {
            ++_res_count_map.get(subject).get(id)._yesCount;
        }
        else{
            ++_res_count_map.get(subject).get(id)._noCount;
        }

        return true;
    }

    /**
     * 重置（归零）某一个科目问卷的统计结果
     */
    public static boolean ResetResultCount(String subject){
        if(_res_count_map.get(subject) == null)
            return false;
        /**
         * 遍历Vector
         */

        for (ResCount item : _res_count_map.get(subject)) {
            item._yesCount = 0;
            item._noCount = 0;
        }
    return true;
    }

    /**
     * 获取某一个科目问卷的统计结果（是或否的统计数量）
     */
    public static Vector<ResCount> GetResultCouont(String subject){
        return _res_count_map.get(subject);
    }


}
