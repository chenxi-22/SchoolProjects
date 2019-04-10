package root.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import root.service.StudentService;
import root.service.TeacherService;

@Controller
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
     * TODO
     * @return
     */
    @RequestMapping(value = {"/login"}, method = {RequestMethod.POST})
    public ModelAndView Login(@RequestParam(value = "id") String id, @RequestParam(value = "password") String password) {
        ModelAndView modelAndView = new ModelAndView();
        /**
         * 如果登录成功，判断该用户是学生还是老师，根据不同的身份，来返回不同的界面
         * 如果该用户是学生，那么这里返回 student.jsp，如果是老师返回 teacher.jsp
         */
        return modelAndView;
    }

    /**
     * 添加选课信息
     * TODO
     * @return
     */
    @RequestMapping(value = {"/student_add"}, method = {RequestMethod.GET})
    public ModelAndView StudentAddSubject() {
        ModelAndView modelAndView = new ModelAndView();
        return modelAndView;
    }

    /**
     * 浏览问卷
     * TODO
     * @return
     */
    @RequestMapping(value = {"/student_watch"}, method = {RequestMethod.GET})
    public ModelAndView StudentWatch() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("student_watch");
        return modelAndView;
    }

    /**
     * 做问卷，采用 POST 方式提交问卷的结果
     * TODO
     * @return
     */
    @RequestMapping(value = {"/student_do"}, method = {RequestMethod.POST})
    public ModelAndView StudentDo() {
        ModelAndView modelAndView = new ModelAndView();
        return modelAndView;
    }

    /**
     * 查看问卷结果
     * TODO
     * @return
     */
    @RequestMapping(value = {"/student_get_result"}, method = {RequestMethod.GET})
    public ModelAndView StudentGetResult() {
        ModelAndView modelAndView = new ModelAndView();
        return modelAndView;
    }

}
