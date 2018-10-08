package com.example.demo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface UserRepository extends Repository<User, Integer>{
    public void save(User user);

    @Query("select u from User u where u.id_users = :id_users")
    @Transactional(readOnly = true)
    public User findByID(@Param("id_users") Integer id_users);

    @Query("select u from User u where u.email = :email")
    @Transactional(readOnly = true)
    public User findByEmail(@Param("email") String email);
    
    /*@Query("select u from User u where u.email and u.password = :email , password")
    @Transactional(readOnly = true)
    public User findUser(@Param("email") String email, @Param("password") String password);*/
}
