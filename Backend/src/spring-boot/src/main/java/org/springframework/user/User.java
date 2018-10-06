package org.springframework.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;

import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Entity
@Table(name = "user")
public class User {
    @Id
    @Column(name = "id_users")
    private Integer id_users;

    @Column(name = "first_name")
    private String first_name;

    @Column(name = "last_name")
    private String last_name;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "phone_number")
    private String phone_number;

    @Column(name = "user_type")
    private String user_type;

    public Integer getIdUsers() {
        return id_users;
    }
    public String getFirstName(){
        return first_name;
    }
    public String getLastName(){
        return last_name;
    }
    public String getEmail(){
        return email;
    }
    public String getPassword(){
        return password;
    }
    public String getPhoneNumber(){
        return phone_number;
    }
    public String getUserType(){
        return user_type;
    }

    public void setIdUsers(Integer id)
    {
        this.id_users = id;
    }
    public void setFirstName(String firstName){
        this.first_name = firstName;
    }
    public void setLastName(String lastName){
        this.last_name = lastName;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public void setPassword(String password){
        this.password = password;
    }
    public void setPhoneNumber(String phoneNumber){
        this.phone_number = phoneNumber;
    }
    public void setUserType(String user_type){
        this.user_type = user_type;
    }
}
