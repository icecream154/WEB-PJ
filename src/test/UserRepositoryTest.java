package test;

import domain.User;
import org.junit.jupiter.api.Test;
import repository.UserRepository;
import repositoryImplementation.UserRepositoryImpl;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class UserRepositoryTest {

    private UserRepository userRepository = new UserRepositoryImpl();

    @Test
    void save() {
        User newUser = new User("test002", "newPassword", "tempEmail@gmail.com");
        userRepository.save(newUser);
        List<User> users = userRepository.getAll();
        System.out.println(users);
        newUser = userRepository.findUserByUsername("test002");
        newUser.setEmail("newEmail@gmail.com");
        userRepository.save(newUser);
        users = userRepository.getAll();
        System.out.println(users);
    }

    @Test
    void findUserByUsername() {
        User user = userRepository.findUserByUsername("test001");
        System.out.println(user);
        user = userRepository.findUserByUsername("Sdfe");
        assertNull(user);
    }

    @Test
    void getAll(){
        List<User> users = userRepository.getAll();
        System.out.println(users);
    }
}