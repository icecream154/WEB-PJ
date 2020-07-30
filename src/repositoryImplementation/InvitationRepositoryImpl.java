package repositoryImplementation;

import domain.Invitation;
import repository.InvitationRepository;
import utils.Repository;

import java.util.List;

public class InvitationRepositoryImpl extends Repository<Invitation> implements InvitationRepository {
    @Override
    public void save(Invitation invitation) {
        if(findInvitationById(invitation.getId()) == null){
            String sql = "INSERT INTO invitations(sender, receiver) VALUES(?,?)";
            update(sql, invitation.getSender(), invitation.getReceiver());
        }else{
            String sql = "UPDATE invitations SET status=? WHERE id=?";
            update(sql, invitation.getStatus(), invitation.getId());
        }
    }

    @Override
    public Invitation findInvitationById(Long id) {
        String sql = "SELECT id, sender, receiver, status, time FROM invitations WHERE id=?";
        return get(sql, id);
    }

    @Override
    public List<Invitation> findInvitationsBySender(String senderName) {
        String sql = "SELECT id, sender, receiver, status, time FROM invitations WHERE sender=? ORDER BY time DESC";
        return getForList(sql, senderName);
    }

    @Override
    public List<Invitation> findInvitationsByReceiver(String receiverName) {
        String sql = "SELECT id, sender, receiver, status, time FROM invitations WHERE receiver=? ORDER BY time DESC";
        return getForList(sql, receiverName);
    }

    @Override
    public List<Invitation> findInvitationBySenderAndReceiver(String senderName, String receiverName) {
        String sql = "SELECT id, sender, receiver, status, time FROM invitations WHERE sender=? AND receiver=? ORDER BY time DESC";
        return getForList(sql, senderName, receiverName);
    }

    @Override
    public List<Invitation> findInvitationsBySenderAndStatus(String senderName, Integer status) {
        String sql = "SELECT id, sender, receiver, status, time FROM invitations WHERE sender=? AND status=? ORDER BY time DESC";
        return getForList(sql, senderName, status);
    }

    @Override
    public List<Invitation> findInvitationsByReceiverAndStatus(String receiverName, Integer status) {
        String sql = "SELECT id, sender, receiver, status, time FROM invitations WHERE receiver=? AND status=? ORDER BY time DESC";
        return getForList(sql, receiverName, status);
    }

    @Override
    public List<Invitation> findInvitationBySenderAndReceiverAndStatus(String senderName, String receiverName, Integer status) {
        String sql = "SELECT id, sender, receiver, status, time FROM invitations WHERE sender=? AND receiver=? AND status=? ORDER BY time DESC";
        return getForList(sql, senderName, receiverName, status);
    }
}
