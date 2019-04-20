package root.Util;

import root.model.ResCount;

import java.util.Arrays;
import java.util.List;
import java.util.Vector;

public class StringAndListUtil {

    public static List<String> deleteStr(List<String> str, String todelete) {
        List<String> res = new Vector<>();
        for (String tmp : str) {
            if (!tmp.equals(todelete)) {
                res.add(tmp);
            }
        }
        return res;
    }


    public static List<String> strToList(String str){
        String[] tmp = str.split("\3");
        return Arrays.asList(tmp);
    }

    public static String listToStr(List<String> list){
        String res = null;
        int flag = 0;
        String split = "\3";
        for(String str : list) {
            if(0 == flag){
                res = str;
                flag = 1;
            }
            else{
                res = res + split + str;
            }
        }

        return res;
    }

    /**
     * 去除方括号
     */
    public static String removeBracket(String str)
    {
        String removeString = "[";
        str = str.replace(removeString, "");
        removeString = "]";
        str = str.replace(removeString, "");
        return str;
    }

    public static String Replace3To(String str){

        String res = new String();
        String tmp = "\\";
        String tmp1 = "3";
        for(int i=0;i < str.length();i++) {
            if(str.charAt(i) == tmp.charAt(0)){
                res = res + ",";
            }else if(str.charAt(i) == tmp1.charAt(0)){ }
            else{
                res = res + str.charAt(i);
            }        }

        return res;
    }

    public static String CountToString(List<ResCount> resCount){
        String resString = "";
        int flag = 0;
        /**
         * 每个答案之间用','分隔，每个问题用'\3'分隔
         */
        for(ResCount rc : resCount){
            if(0 == flag){
                String tmp = String.valueOf(rc._yesCount) + ',' + String.valueOf(rc._noCount);
                resString = tmp;
                flag = 1;
            }
            else{
                String tmp = String.valueOf(rc._yesCount) + ',' + String.valueOf(rc._noCount);
                resString = resString + '\3' + tmp;
            }
        }

        return resString;
    }

    /**
     * 将';'去除，转List
     */
    public static List<String> ReplaceTo3AndStrToListWith(String str){
        String[] tmp = str.split(";");
        return Arrays.asList(tmp);
    }


}
