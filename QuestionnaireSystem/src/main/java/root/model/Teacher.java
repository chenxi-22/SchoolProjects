package root.model;

import lombok.Data;

@Data
public class Teacher{
    /**
     * 账号
     */
    private String id;

    /**
     * 密码
     */
    private String password;

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
}
