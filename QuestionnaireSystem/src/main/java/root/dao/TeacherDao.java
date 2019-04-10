package root.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import root.Util.StringAndListUtil;
import root.model.Naire;
import root.model.Teacher;

import java.util.List;

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

    public boolean UpdateQuestions(Naire naire) {
        String sql = "UPDATE questionnaire_system.naires SET questionnaires=? WHERE subject=?";
        String subject = naire.getSubject();
        List<String> tmp = naire.getQuestionnaires();
        String questionnaires = StringAndListUtil.listToStr(tmp);
        jdbcTemplate.update(sql, questionnaires, subject);
        return true;
    }
}
