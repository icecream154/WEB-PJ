package domain;

import java.util.Date;
import java.util.List;

public class User {

    public static final int FOOTPRINT_SIZE = 10;

    private Long id;
    private String username;
    private String password;
    private String email;
    private List<String> friendList;
    private int pictureCount;
    private List<Long> collectionList;
    private List<Long> footprintList;
    private Date registerTime;
    private boolean open;

    public User() {
    }

    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public User(Long id, String username, String password, String email, List<String> friendList, int pictureCount, List<Long> collectionList, List<Long> footprintList, Date registerTime, boolean open) {
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

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", friendList=" + friendList +
                ", pictureCount=" + pictureCount +
                ", collectionList=" + collectionList +
                ", footprintList=" + footprintList +
                ", registerTime=" + registerTime +
                ", open=" + open +
                '}';
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

    public List<String> getFriendList() {
        return friendList;
    }

    public void setFriendList(List<String> friendList) {
        this.friendList = friendList;
    }

    public int getPictureCount() {
        return pictureCount;
    }

    public void setPictureCount(int pictureCount) {
        this.pictureCount = pictureCount;
    }

    public List<Long> getCollectionList() {
        return collectionList;
    }

    public void setCollectionList(List<Long> collectionList) {
        this.collectionList = collectionList;
    }

    public List<Long> getFootprintList() {
        return footprintList;
    }

    public void setFootprintList(List<Long> footprintList) {
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

    public int getFriendSize(){ return friendList.size(); }

    public int getCollectionSize(){ return collectionList.size(); }
}
