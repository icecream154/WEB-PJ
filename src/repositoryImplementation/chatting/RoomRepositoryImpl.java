package repositoryImplementation.chatting;

import domain.chatting.Room;
import repository.chatting.RoomRepository;

import java.util.HashSet;
import java.util.Set;
import java.util.Timer;

public class RoomRepositoryImpl implements RoomRepository {
    protected static Set<Room> allRooms = new HashSet<>();

    static{
        Timer timer = new Timer();
        timer.schedule(new RecycleTask(), 10 * 1000, 60 * 1000);
    }

    @Override
    public Room findOrCreateRoom(String user1, String user2) {
        Room result = findRoomByUserOneAndUserTwo(user1, user2);
        if(result != null){
            return new Room(result.getUser1(), result.getUser2(), result.getMessages());
        }
        Room newRoom = new Room(user1, user2);
        allRooms.add(new Room(user1, user2));
        return newRoom;
    }
    @Override
    public Room findRoom(String user1, String user2) {
        Room room = findRoomByUserOneAndUserTwo(user1, user2);
        if(room == null){
            return null;
        }
        return new Room(room.getUser1(), room.getUser2(), room.getMessages());
    }
    @Override
    public void save(Room room) {
        Room roomInSet = findRoomByUserOneAndUserTwo(room.getUser1(), room.getUser2());
        if(roomInSet != null){
            roomInSet.setMessages(room.getMessages());
            roomInSet.setLastModified(room.getLastModified());
        }
    }
    private Room findRoomByUserOneAndUserTwo(String user1, String user2){
        // not safe for threads
        for (Room room: allRooms) {
            if((room.getUser1().equals(user1) && room.getUser2().equals(user2))
                    || (room.getUser1().equals(user2) && room.getUser2().equals(user1))){
                return room;
            }
        }
        return null;
    }
}
