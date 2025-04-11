package main;
import java.io.Serializable;

public class Account implements Serializable {
    private int id;
    private String email;
    private String username;
    private String password;
    private String role;
    private String status;
    private String createdAt;

    //Constructors
    public Account(int id, String email, String username, String password, String role, String status, String createdAt) {
        this.id = id;
        this.email = email;
        this.username = username;
        this.password = password;
        this.role = role;
        this.status = status;
        this.createdAt = createdAt;
    }

    public Account(String email, String username, String password, String role, String status) {
        this(0, email, username, password, role, status,"");
    }

    public Account(int id, String email, String username, String password) {
        this(id, email, username, password, "", "","");
    }

    public Account() {
        this(0, "", "", "", "", "", "");
    }

    //Getter and setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isManager() {
        return "MANAGER".equals(this.role);
    }

    public boolean isStaff() {
        return "STAFF".equals(this.role);
    }

    @Override
    public String toString() {
        return "Account{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", role='" + role + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}