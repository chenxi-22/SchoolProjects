package root.web.controller;

import com.mysql.jdbc.StringUtils;
import com.mysql.jdbc.jmx.ReplicationGroupManager;
import jdk.nashorn.internal.runtime.regexp.joni.Regex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import root.Util.StringAndListUtil;
import root.service.StudentService;
import root.service.TeacherService;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller("displayController")
public class DispalyController {
    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    /**
     * 主页显示
     * @return
     */
    @RequestMapping(value = {"/"}, method ={RequestMethod.GET})
    public ModelAndView Home() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("login");
        return modelAndView;
    }

    /**
     * 登录操作处理
     * @return
     */
    @RequestMapping(value = {"/login"}, method = {RequestMethod.POST})
    public ModelAndView Login(@RequestParam(value = "id") String id, @RequestParam(value = "password") String password, @RequestParam(value = "identity") String identity) {
        ModelAndView modelAndView = new ModelAndView();
        /**
         * 如果登录成功，判断该用户是学生还是老师，根据不同的身份，来返回不同的界面
         * 如果该用户是学生，那么这里返回 student.jsp，如果是老师返回 teacher.jsp
         */
        if (identity.equals("student")) {
            boolean res = studentService.Login(id, password);
            if (res == false) {
                modelAndView.setViewName("loginfailed");
            } else {
                List<String> press = studentService.getPressSubjectList();
                if (press == null || press.size() == 0 || press.get(0).equals("")) {
                    modelAndView.setViewName("student");
                } else {
                    modelAndView.addObject("list", press);
                    modelAndView.setViewName("student");
                }
            }
        } else {
            boolean res = teacherService.Login(id, password);
            if (res == false) {
                modelAndView.setViewName("loginfailed");
            } else {
                modelAndView.setViewName("teacher");
            }
        }
        return modelAndView;
    }

    /**
     * 学生管理
     */

    /**
     * 查看能够添加的课程
     * @return
     */
    @RequestMapping(value = "/canadd", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String SearchCanChooseSubject() {
        List<String> canChoose = studentService.getCanChooseSubject();
        if (canChoose == null || canChoose.size() == 0 || canChoose.get(0).equals("")) {
            return "nosubjects";
        }
        return StringAndListUtil.listToStr(canChoose);
    }

    /**
     * 查看所有选课
     * @return
     */
    @RequestMapping(value = "/choosed", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String ChoosedSubject() {
        List<String> canDelete = studentService.getSubjects();
        if (canDelete == null || canDelete.size() == 0 || canDelete.get(0).equals("")) {
            return "nosubjects";
        }
        return StringAndListUtil.listToStr(canDelete);
    }

    /**
     *  添加课程
     * @param subject
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String AddSubject(@RequestParam(value = "subject") String subject) {
        studentService.AddSubject(subject);
        List<String> canChoose = studentService.getCanChooseSubject();
        if (canChoose == null || canChoose.size() == 0 || canChoose.get(0).equals("")) {
            return "nosubjects";
        }
        return StringAndListUtil.listToStr(canChoose);
    }

    /**
     * 删除课程
     * @param subject
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String DeleteSubject(@RequestParam(value = "subject") String subject) {
         studentService.DelCourse(subject);
         List<String> choosed = studentService.getSubjects();
         if (choosed == null || choosed.size() == 0 || choosed.get(0).equals("")) {
             return "nosubjects";
         }
         return StringAndListUtil.listToStr(choosed);
    }


    /**
     * 老师管理
     */

    /**
     * 导入选课信息
     * @return
     */
    @RequestMapping(value = "/loadsubjects", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String LoadSbjects() {

        Map<String, List<String>> subjectInfoMap = teacherService.getSubjectInfo();
        String resString = new String();
        if (subjectInfoMap == null) {
            return "没有科目";
        }

        int flag = 0;
        String split = "\4";
        for (String key : subjectInfoMap.keySet()) {
            if (subjectInfoMap.get(key) == null) {
                String tmp = key;
                tmp = tmp + ":没有任何学生选择该科目";

                if(0 == flag){
                    resString = tmp;
                    flag = 1;
                }
                else{
                    resString = resString + split + tmp;
                }
            }
            else{
                String tmp = key;
                tmp = tmp + ":" + subjectInfoMap.get(key);
                System.out.println(subjectInfoMap.get(key));
                if(0 == flag){
                    resString = tmp;
                    flag = 1;
                }
                else{
                    resString = resString + split + tmp;
                }
            }
        }

        String str = StringAndListUtil.removeBracket(resString);
        /**
         * 将'\3'换成','，
         */
        return StringAndListUtil.Replace3To(str);
    }

    /**
     * 催缴问卷
     * @return
     */
    @RequestMapping(value = "/pressnaires", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String PressNaires() {

       return StringAndListUtil.listToStr(teacherService.getALllSubject());
    }

    @RequestMapping(value = "/pressNaire", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String pressNaire(@RequestParam(value = "subject") String subject) {
        if(subject == null)
            return "false";
        /**
         * 催缴
         */
        teacherService.PressQuestionnaire(subject);
        return "true";
    }

    /**
     * 添加问卷
     * @return
     */
    @RequestMapping(value = "/addnaires", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String AddNaires() {

        return StringAndListUtil.listToStr(teacherService.getALllSubject());
    }

    /**
     * 统计结果
     * @return
     */
    @RequestMapping(value = "/getResultCount", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String GetResultCount() {

        return StringAndListUtil.listToStr(teacherService.getALllSubject());
    }

    /**
     * 题目添加管理
     * @return
     */
    @RequestMapping(value = "/questionmanager", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String QuestionManager() {

        return StringAndListUtil.listToStr(teacherService.getALllSubject());
    }
}



