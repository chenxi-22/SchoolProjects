package root.model;

public class User {
    private String _type; //stu OR tea
    private String _id;
    private String _password;

    public User() {}

    public User(String type, String id, String password){
        _type = type;
        _id = id;
        _password = password;
    }

    public void setType(String type){
        _type = type;
    }
    public String getType() {
        return _type;
    }

    public void setId(String id) {
        _id = id;
    }

    public String getId() {
        return _id;
    }

    public void setPassword(String password) {
        _password = password;
    }
    public String getPassword() {
        return _password;
    }
}
