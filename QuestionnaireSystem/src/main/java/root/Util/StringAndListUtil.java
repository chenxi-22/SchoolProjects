package root.Util;

import java.util.Arrays;
import java.util.List;

public class StringAndListUtil {

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
            }
        }
        return res;
    }

}
