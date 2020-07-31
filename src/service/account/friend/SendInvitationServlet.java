package service.account.friend;

import domain.Invitation;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SendInvitationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        String receiver = request.getParameter("receiver");
        if(Repo.userRepository.findUserByUsername(receiver) == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"No such receiver!\"}");
            return;
        }

        if(receiver.equals(loginUsername)){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"You can't send invitation to yourself!\"}");
            return;
        }

        if(Repo.invitationRepository.findInvitationBySenderAndReceiverAndStatus(loginUsername, receiver, Invitation.S_ACCEPTED).size() == 1
            || Repo.invitationRepository.findInvitationBySenderAndReceiverAndStatus(receiver, loginUsername, Invitation.S_ACCEPTED).size() == 1){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"You have become friends!\"}");
            return;
        }

        if(Repo.invitationRepository.findInvitationBySenderAndReceiverAndStatus(loginUsername, receiver, Invitation.S_PENDING).size() == 1){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"You have sent an invitation!\"}");
            return;
        }

        if(Repo.invitationRepository.findInvitationBySenderAndReceiverAndStatus(receiver, loginUsername, Invitation.S_PENDING).size() == 1){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"He/she has sent you an invitation!\"}");
            return;
        }

        Invitation newInvitation = new Invitation(loginUsername, receiver);
        Repo.invitationRepository.save(newInvitation);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print("{\"message\":\"Send invitation success!\"}");

    }
}
