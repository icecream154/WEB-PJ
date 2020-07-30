package repositoryImplementation;

import repository.InvitationRepository;
import repository.PictureRepository;
import repository.UserRepository;
import repository.chatting.RoomRepository;
import repositoryImplementation.chatting.RoomRepositoryImpl;

public class Repo {
    public static UserRepository userRepository = new UserRepositoryImpl();
    public static PictureRepository pictureRepository = new PictureRepositoryImpl();
    public static InvitationRepository invitationRepository = new InvitationRepositoryImpl();
    public static RoomRepository roomRepository = new RoomRepositoryImpl();
}
