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
}
