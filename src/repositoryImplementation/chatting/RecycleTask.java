package repositoryImplementation.chatting;

import domain.chatting.Room;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.TimerTask;

public class RecycleTask extends TimerTask {
    private static final long TIMEOUT = 30 * 1000; // 30 seconds

    @Override
    public void run() {
        System.out.println("Recycle Task executed: " + new Date());
        long now = new Date().getTime();
        Set<Room> removeSet = new HashSet<>();
        for (Room room : RoomRepositoryImpl.allRooms) {
            System.out.print(room);
            if(now - room.getLastModified() > TIMEOUT){
                removeSet.add(room);
                System.out.println(" removed");
            }
        }
        RoomRepositoryImpl.allRooms.removeAll(removeSet);
    }
}
