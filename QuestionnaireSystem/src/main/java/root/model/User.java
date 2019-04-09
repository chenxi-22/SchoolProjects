package root.model;

import javax.jws.soap.SOAPBinding;

public class User {
    private String _type; //stu OR tea
    private long _id;
    private String _password;

    public User() {}
    public User(String type, long id, String password){
        _type = type;
        _id = id;
        _password = password;
    }

    public void SetType(String type){ _type = type; }
    public String GetType() { return _type; }
    public void SetId(long id) { _id = id; }
    public long GetId() { return _id; }
    public void SetPWD(String password) { _password = password; }
    public String GetPWD() { return _password; }
}
