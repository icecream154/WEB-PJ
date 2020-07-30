package repository.chatting;
import domain.chatting.Room;

public interface RoomRepository {
    Room findOrCreateRoom(String user1, String user2);
    Room findRoom(String user1, String user2);
    void save(Room room);
}
