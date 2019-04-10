package root.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import root.Util.StringAndListUtil;
import root.model.Student;

import java.util.List;

@Repository
public class StudentDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 用户是否存在
     * @param student
     * @return
     */
    public Student isExist(Student student) {
        String sql = "SELECT password FROM questionnaire_system.students WHERE id=?";
        String id = student.getId();
        String password = jdbcTemplate.queryForObject(sql, new Object[]{ id }, String.class);
        if (password.equals(student.getPassword())) {
            String sql2 = "SELECT name FROM questionnaire_system.students WHERE id=?";
            Student res = new Student();
            res.setId(student.getId());
            res.setPassword(student.getPassword());
            res.setName(jdbcTemplate.queryForObject(sql2, new Object[]{ id }, String.class));
            return res;
        }
        return null;
    }

    /**
     * 获取选择的课程
     * @param student
     * @return
     */
    public List<String> getSubjects(Student student) {
        String sql = "SELECT subjects FROM questionnaire_system.students WHERE id=?";
        String id = student.getId();
        String result = jdbcTemplate.queryForObject(sql, new Object[]{ id }, String.class);
        List<String> subjects = StringAndListUtil.strToList(result);
        return subjects;
    }

    /**
     * 更新选择的课程
     * @param student
     * @return
     */
    public boolean UpdateSubjects(Student student) {
        String sql = "UPDATE questionnaire_system.students SET subjects=? WHERE id=?";
        String id = student.getId();
        List<String> tmp = student.getSubjects();
        String subjects = StringAndListUtil.listToStr(tmp);
        jdbcTemplate.update(sql, subjects, id);
        return true;
    }

}
