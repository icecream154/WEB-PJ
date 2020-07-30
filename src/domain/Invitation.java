package domain;

import java.util.Date;

public class Invitation {

    public static final int S_PENDING = 0;
    public static final int S_ACCEPTED = 1;
    public static final int S_DENIED = -1;

    private Long id;
    private String sender;
    private String receiver;
    // 0: PENDING 1: ACCEPTED 2: DENIED
    private Integer status;
    private Date time;

    public Invitation() {
    }

    public Invitation(String sender, String receiver) {
        this.sender = sender;
        this.receiver = receiver;
    }

    @Override
    public String toString() {
        return "Invitation{" +
                "id=" + id +
                ", sender='" + sender + '\'' +
                ", receiver='" + receiver + '\'' +
                ", status=" + status +
                ", time=" + time +
                '}';
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
