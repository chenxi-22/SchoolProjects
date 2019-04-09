package root.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import root.model.Student;

import java.util.Arrays;
import java.util.Vector;

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

    public Vector<String> getSubjects(Student student) {
        String sql = "SELECT subjects FROM questionnaire_system.students WHERE id=?";
        String id = student.getId();
        String result = jdbcTemplate.queryForObject(sql, new Object[]{ id }, String.class);
        Vector<String> subjects = new Vector<String>(Arrays.asList(result.split("\\,")));
        return subjects;
    }
}
