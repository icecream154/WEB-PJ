package repository;

import domain.Invitation;
import domain.User;

import java.util.List;

public interface InvitationRepository {
    void save(Invitation invitation);
    Invitation findInvitationById(Long id);
    List<Invitation> findInvitationsBySender(String senderName);
    List<Invitation> findInvitationsByReceiver(String receiverName);
    List<Invitation> findInvitationBySenderAndReceiver(String senderName, String receiverName);
    List<Invitation> findInvitationsBySenderAndStatus(String senderName, Integer status);
    List<Invitation> findInvitationsByReceiverAndStatus(String receiverName, Integer status);
    List<Invitation> findInvitationBySenderAndReceiverAndStatus(String senderName, String receiverName, Integer status);
}
