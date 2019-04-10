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

    public boolean isExist(Student student) {
        String sql = "SELECT password FROM questionnaire_system.students WHERE id=?";
        String id = student.getId();
        String password = jdbcTemplate.queryForObject(sql, new Object[]{ id }, String.class);
        if (password.equals(student.getPassword())) {
            return true;
        }
        return false;
    }

    public List<String> getSubjects(Student student) {
        String sql = "SELECT subjects FROM questionnaire_system.students WHERE id=?";
        String id = student.getId();
        String result = jdbcTemplate.queryForObject(sql, new Object[]{ id }, String.class);
        List<String> subjects = StringAndListUtil.strToList(result);
        return subjects;
    }

    public boolean UpdateSubjects(Student student) {
        String sql = "UPDATE questionnaire_system.students SET subjects=? WHERE id=?";
        String id = student.getId();
        List<String> tmp = student.getSubjects();
        String subjects = StringAndListUtil.listToStr(tmp);
        jdbcTemplate.update(sql, subjects, id);
        return true;
    }

    public boolean UpdateUnComplete(Student student) {
        String sql = "UPDATE questionnaire_system.students SET uncomplete=? WHERE id=?";
        String id = student.getId();
        List<String> tmp = student.getUncompletes();
        String uncompletes = StringAndListUtil.listToStr(tmp);
        jdbcTemplate.update(sql, uncompletes, id);
        return true;
    }
}
