package repository;

import domain.User;

import java.util.List;

public interface UserRepository {
    void save(User user);
    User findUserByUsername(String userName);
    List<User> findUsersByUsernameContains(String username);
    User findUserByEmail(String email);
    List<User> getAll();
}
