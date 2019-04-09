package root.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import root.model.Naire;

@Repository
public class NaireDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public String getQuestionnaires(Naire naire) {
        String sql = "SELECT questionnaires FROM questionnaire_system.naires WHERE subject=?";
        String subject = naire.getSubject();
        String questionnaires = jdbcTemplate.queryForObject(sql, new Object[]{ subject }, String.class);
        return questionnaires;
    }
}
