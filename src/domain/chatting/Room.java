package domain.chatting;

import java.util.Date;

public class Room {
    private String user1;
    private String user2;
    private String messages;
    private long lastModified;

    public Room(String user1, String user2) {
        this.user1 = user1;
        this.user2 = user2;
        messages = "";
        lastModified = new Date().getTime();
    }

    public Room(String user1, String user2, String messages) {
        this.user1 = user1;
        this.user2 = user2;
        this.messages = messages;
        lastModified = new Date().getTime();
    }

    public String getUser1() {
        return user1;
    }

    public void setUser1(String user1) {
        this.user1 = user1;
    }

    public String getUser2() {
        return user2;
    }

    public void setUser2(String user2) {
        this.user2 = user2;
    }

    public String getMessages() {
        return messages;
    }

    public void setMessages(String messages) {
        this.messages = messages;
    }

    public long getLastModified() {
        return lastModified;
    }

    public void setLastModified(long lastModified) {
        this.lastModified = lastModified;
    }

    @Override
    public String toString() {
        return "Room{" +
                "user1='" + user1 + '\'' +
                ", user2='" + user2 + '\'' +
                ", messages='" + messages + '\'' +
                ", lastModified=" + new Date(lastModified) +
                '}';
    }
}
