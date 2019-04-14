package root.web.controller;

import com.mysql.jdbc.jmx.ReplicationGroupManager;
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
import java.util.List;

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
                if (press == null) {
                    modelAndView.setViewName("student");
                } else {
                    modelAndView.setViewName("press");
                }
            }
        } else {
            boolean res = teacherService.Login(id, password);
            if (res == false) {
                modelAndView.setViewName("loginfailed");
            } else {
                modelAndView.setViewName("Teacher");
            }
            return modelAndView;
        }
        return modelAndView;
    }

    /**
     * 查看能够添加的课程
     * @return
     */
    @RequestMapping(value = "/canadd", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String SearchCanChooseSubject() {
        List<String> canChoose = studentService.getCanChooseSubject();
        return StringAndListUtil.listToStr(canChoose);
    }

    /**
     * 查看所有选课
     * @return
     */
    @RequestMapping(value = "/choosed", method = RequestMethod.GET, produces="text/html;charset=UTF-8")
    @ResponseBody
    public String ChoosedSbject() {
        List<String> canDelete = studentService.getSubjects();
        if (canDelete == null) {
            String result = "还没有选择任何课程哦！";
            return result;
        }
        return StringAndListUtil.listToStr(canDelete);
    }

}
