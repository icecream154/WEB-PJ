package repositoryImplementation;

import domain.User;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class UserImpl {
    private static final String SEPARATOR = ",";

    private Long id;
    private String username;
    private String password;
    private String email;
    private String friendList;
    private int pictureCount;
    private String collectionList;
    private String footprintList;
    private Date registerTime;
    private boolean open;

    public UserImpl(){

    }

    public UserImpl(Long id, String username, String password, String email, String friendList, int pictureCount, String collectionList, String footprintList, Date registerTime, boolean open) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.friendList = friendList;
        this.pictureCount = pictureCount;
        this.collectionList = collectionList;
        this.footprintList = footprintList;
        this.registerTime = registerTime;
        this.open = open;
    }

    public static UserImpl toUserImpl(User user){
        if(user != null){
            return new UserImpl(user.getId(), user.getUsername(), user.getPassword(), user.getEmail(),
                    generateStringFromList(user.getFriendList()), user.getPictureCount(), generateStringFromList(user.getCollectionList()),
                    generateStringFromList(user.getFootprintList()), user.getRegisterTime(), user.isOpen());
        }
        return null;
    }

    private static String generateStringFromList(List list){
        if(list == null || list.size() == 0){
            return "";
        }
        StringBuilder result = new StringBuilder();
        for (Object obj: list) {
            result.append(obj.toString()).append(SEPARATOR);
        }
        result.deleteCharAt(result.length() - 1);

        return result.toString();
    }

    public User toUser(){
        List<String> userFriendList = new ArrayList<>();
        if(friendList != null && !friendList.equals("")){
            userFriendList = Arrays.asList(friendList.split(SEPARATOR));
        }

        List<Long> userCollectionList = new ArrayList<>();
        List<Long> userFootprintList = new ArrayList<>();
        List<String> tmpList;
        tmpList = Arrays.asList(collectionList.split(SEPARATOR));
        if(!(tmpList.size() == 1 && tmpList.get(0).equals(""))){
            for (String picId: tmpList) {
                userCollectionList.add(Long.parseLong(picId));
            }
        }
        tmpList = Arrays.asList(footprintList.split(SEPARATOR));
        if(!(tmpList.size() == 1 && tmpList.get(0).equals(""))){
            for (String picId: tmpList) {
                userFootprintList.add(Long.parseLong(picId));
            }
        }
        return new User(id, username, password, email, userFriendList, pictureCount, userCollectionList, userFootprintList, registerTime, open);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFriendList() {
        return friendList;
    }

    public void setFriendList(String friendList) {
        this.friendList = friendList;
    }

    public int getPictureCount() {
        return pictureCount;
    }

    public void setPictureCount(int pictureCount) {
        this.pictureCount = pictureCount;
    }

    public String getCollectionList() {
        return collectionList;
    }

    public void setCollectionList(String collectionList) {
        this.collectionList = collectionList;
    }

    public String getFootprintList() {
        return footprintList;
    }

    public void setFootprintList(String footprintList) {
        this.footprintList = footprintList;
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }
}
