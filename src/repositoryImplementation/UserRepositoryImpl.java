package repositoryImplementation;

import domain.User;
import repository.UserRepository;
import utils.Repository;

import java.util.ArrayList;
import java.util.List;

public class UserRepositoryImpl extends Repository<UserImpl> implements UserRepository {

    @Override
    public void save(User user){
        UserImpl userImpl = UserImpl.toUserImpl(user);
        User userByName = findUserByUsername(userImpl.getUsername());
        User userByEmail = findUserByEmail(userImpl.getEmail());
        if(userByName == null && userByEmail == null){
            String sql = "INSERT INTO users(username, password, email, friendList, pictureCount, collectionList, footprintList) VALUES(?,?,?,?,?,?,?)";
            update(sql, userImpl.getUsername(), userImpl.getPassword(), userImpl.getEmail(),
                    userImpl.getFriendList(), userImpl.getPictureCount(), userImpl.getCollectionList(), userImpl.getFootprintList());
        }else if(userByName != null && userByEmail != null && userByName.getId().equals(userByEmail.getId())){
            System.out.println("update called for user [" + user.getUsername() + "]");
            String sql = "UPDATE users SET password=?, friendList=?, pictureCount=?, collectionList=?, footprintList=?, open=? WHERE username=?";
            update(sql, userImpl.getPassword(), userImpl.getFriendList(), userImpl.getPictureCount(),
                    userImpl.getCollectionList(), userImpl.getFootprintList(), userImpl.isOpen(), userImpl.getUsername());
        }
    }

    @Override
    public User findUserByUsername(String username){
        String sql = "SELECT id, username, password, email, friendList, pictureCount, collectionList, footprintList, registerTime, open FROM users WHERE username=?";
        UserImpl userImpl = get(sql, username);
        return userImpl != null? userImpl.toUser() : null;
    }

    @Override
    public List<User> findUsersByUsernameContains(String username) {
        String sql =
                "SELECT id, username, password, email, friendList, pictureCount, collectionList, footprintList, registerTime, open FROM users WHERE username LIKE '%" + username + "%'";
        List<UserImpl> userImpls = getForList(sql);
        System.out.println("userImpls: " + userImpls);
        List<User> results = new ArrayList<>();
        for (UserImpl userImpl: userImpls) {
            results.add(userImpl.toUser());
        }
        return results;
    }

    @Override
    public User findUserByEmail(String email) {
        String sql = "SELECT id, username, password, email, friendList, pictureCount, collectionList, footprintList, registerTime, open FROM users WHERE email=?";
        UserImpl userImpl = get(sql, email);
        return userImpl != null? userImpl.toUser() : null;
    }

    @Override
    public List<User> getAll(){
        String sql = "SELECT id, username, password, email, friendList, pictureCount, collectionList, footprintList, registerTime, open FROM users";
        List<UserImpl> userImpls = getForList(sql);
        List<User> results = new ArrayList<>();
        for (UserImpl userImpl: userImpls) {
            results.add(userImpl.toUser());
        }
        return results;
    }
}
