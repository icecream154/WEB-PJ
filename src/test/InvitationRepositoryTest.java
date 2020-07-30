package test;

import domain.Invitation;
import org.junit.jupiter.api.Test;
import repository.InvitationRepository;
import repositoryImplementation.InvitationRepositoryImpl;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class InvitationRepositoryTest {

    private InvitationRepository invitationRepository = new InvitationRepositoryImpl();

    @Test
    void save() {
        Invitation invitation = new Invitation("test001", "test002");
        invitationRepository.save(invitation);
        invitation = invitationRepository.findInvitationBySenderAndReceiver("test001", "test002").get(0);
        invitation.setStatus(1);
        invitationRepository.save(invitation);
        invitation = invitationRepository.findInvitationById(invitation.getId());
        System.out.println(invitation);
    }

    @Test
    void findInvitationsBySender() {
        List<Invitation> invitationList = invitationRepository.findInvitationsBySender("test001");
        System.out.println(invitationList);
    }

    @Test
    void findInvitationsByReceiver() {
        List<Invitation> invitationList = invitationRepository.findInvitationsByReceiver("test002");
        System.out.println(invitationList);
    }

    @Test
    void findInvitationsBySenderAndStatus() {
        List<Invitation> invitationList = invitationRepository.findInvitationsBySenderAndStatus("test001", 0);
        System.out.println(invitationList);
        invitationList = invitationRepository.findInvitationsBySenderAndStatus("test001", 1);
        System.out.println(invitationList);
    }

    @Test
    void findInvitationsByReceiverAndStatus() {
        List<Invitation> invitationList = invitationRepository.findInvitationsByReceiverAndStatus("test002", 0);
        System.out.println(invitationList);
        invitationList = invitationRepository.findInvitationsByReceiverAndStatus("test002", 1);
        System.out.println(invitationList);
    }
}