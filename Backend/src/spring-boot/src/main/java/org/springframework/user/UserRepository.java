package org.springframework.user;
import org.springframework.data.repository.Repository;

public interface UserRepository extends Repository<User, Integer>{

    public void save(User user);
}
