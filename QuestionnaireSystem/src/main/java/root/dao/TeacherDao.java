package root.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import root.model.Teacher;

@Repository
public class TeacherDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public boolean isExist(Teacher teacher) {
        String sql = "SELECT password FROM questionnaire_system.students WHERE id=?";
        String id = teacher.getId();
        String password = jdbcTemplate.queryForObject(sql, new Object[]{ id }, String.class);
        if (password.equals(teacher.getPassword())) {
            return true;
        }
        return false;
    }
}
