package root.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import root.Util.StringAndListUtil;
import root.model.Naire;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

@Repository
public class NaireDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 获取调查问卷
     * @param naire
     * @return
     */
    public String getQuestionnaires(Naire naire) {
        String sql = "SELECT questionnaires FROM questionnaire_system.naires WHERE subject=?";
        String subject = naire.getSubject();
        String questionnaires = jdbcTemplate.queryForObject(sql, new Object[]{ subject }, String.class);
        return questionnaires;
    }

    /**
     * 获取科目的选择学生
     * @param naire
     * @return
     */
    public List<String> getStudents(Naire naire) {

        String sql = "SELECT students FROM questionnaire_system.naires WHERE subject=?";
        String subject = naire.getSubject();
        String tmp = jdbcTemplate.queryForObject(sql, new Object[]{ subject }, String.class);
        if (tmp == null) {
            return null;
        }
        List<String> students = StringAndListUtil.strToList(tmp);
        return students;
    }

    /**
     * 更新选课学生信息
     * @param naire
     * @return
     */
    public boolean UpdateStudents(Naire naire) {
        String sql = "UPDATE questionnaire_system.naires SET students=? WHERE subject=?";
        String subject = naire.getSubject();
        List<String> tmp = naire.getStudents();
        String students = "";
        if (tmp == null || tmp.size() == 0 || tmp.get(0).equals("")) {
            students = null;
        } else {
            students = StringAndListUtil.listToStr(tmp);
        }
        jdbcTemplate.update(sql, students, subject);
        return true;
    }

    /**
     * 获取所有能够选择的科目
     * @return
     */
    public List<String> getAllSubjects() {
        String sql = "SELECT subject FROM questionnaire_system.naires";
        List<String> subjects = jdbcTemplate.query(sql, new SubjectsRowMapper());
        return subjects;
    }

    /**
     * 获取为完成问卷的学生
     * @param naire
     * @return
     */
    public List<String> getUncompletes(Naire naire) {
        String sql = "SELECT uncompletes FROM questionnaire_system.naires WHERE subject=?";
        String subject = naire.getSubject();
        String tmp = jdbcTemplate.queryForObject(sql, new Object[]{ subject }, String.class);
        if (tmp == null) {
            return null;
        }
        List<String> uncompletes = StringAndListUtil.strToList(tmp);
        return uncompletes;
    }

    /**
     * 更新未完成问卷的学生
     * @param naire
     * @return
     */
    public boolean UpdateUncompletes(Naire naire) {
        String sql = "UPDATE questionnaire_system.naires SET uncompletes=? WHERE subject=?";
        String subject = naire.getSubject();
        List<String> tmp = naire.getUncompletes();
        String uncompletes = "";
        if (tmp == null || tmp.size() == 0 || tmp.get(0).equals("")) {
            uncompletes = null;
        } else {
            uncompletes = StringAndListUtil.listToStr(tmp);
        }
        jdbcTemplate.update(sql, uncompletes, subject);
        return true;
    }

    /**
     * 更新问卷问题
     * @param naire
     * @return
     */
    public boolean UpdateQuestions(Naire naire) {
        String sql = "UPDATE questionnaire_system.naires SET questionnaires=? WHERE subject=?";
        String subject = naire.getSubject();
        List<String> tmp = naire.getQuestionnaires();


        String questionnaires = "";
        if (tmp == null || tmp.size() == 0 || tmp.get(0).equals("")) {
            questionnaires = null;
        } else {
            questionnaires = StringAndListUtil.listToStr(tmp);
        }

        jdbcTemplate.update(sql, questionnaires, subject);
        return true;
    }

    /**
     * 获取是否催交
     * @param naire
     * @return
     */
    public String getPress(Naire naire) {
        String sql = "SELECT ispress FROM questionnaire_system.naires WHERE subject=?";
        String subject = naire.getSubject();
        String press = jdbcTemplate.queryForObject(sql, new Object[]{ subject }, String.class);
        return press;
    }

    /**
     * 设置催交 press
     * @param naire
     * @return
     */
    public boolean UpdatePress(Naire naire) {
        String sql = "UPDATE questionnaire_system.naires SET questionnaires=1 WHERE subject=?";
        String subject = naire.getSubject();
        jdbcTemplate.update(sql, subject);
        return true;
    }

    /**
     * 获取 SELECT subjects 后的 List<String>
     */
    public static class SubjectsRowMapper implements RowMapper<String> {
        @Override
        public String mapRow(ResultSet rs, int rowNum) throws SQLException {
            String subject = rs.getString("subject");
            return subject;
        }
    }

}
