package service.account.friend;

import domain.Invitation;
import domain.User;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class DealInvitationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        String sender = request.getParameter("sender");
        List<Invitation> invitationList = Repo.invitationRepository.findInvitationBySenderAndReceiverAndStatus(
                sender, loginUsername, Invitation.S_PENDING);
        if(invitationList.size() == 0){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"No such invitation!\"}");
            return;
        }

        String operation = request.getParameter("operation");
        switch (operation){
            case "ACCEPT":
                User senderUser = Repo.userRepository.findUserByUsername(sender);
                User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
//                System.out.println("senderUser: " + senderUser);
//                System.out.println("loginUser: " + loginUser);
                ArrayList<String> senderList = new ArrayList<>(senderUser.getFriendList());
                senderList.add(loginUsername);
                senderUser.setFriendList(senderList);
                ArrayList<String> loginUserList = new ArrayList<>(loginUser.getFriendList());
                loginUserList.add(sender);
                loginUser.setFriendList(loginUserList);
//                System.out.println("senderUser: " + senderUser);
//                System.out.println("loginUser: " + loginUser);
                Repo.userRepository.save(senderUser);
                Repo.userRepository.save(loginUser);

                invitationList.get(0).setStatus(Invitation.S_ACCEPTED);
                Repo.invitationRepository.save(invitationList.get(0));
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().print("{\"message\":\"Invitation accepted!\"}");
                break;
            case "DENY":
                invitationList.get(0).setStatus(Invitation.S_DENIED);
                Repo.invitationRepository.save(invitationList.get(0));
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().print("{\"message\":\"Invitation denied!\"}");
                break;

            default:
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"message\":\"No such operation!\"}");
        }
    }
}
