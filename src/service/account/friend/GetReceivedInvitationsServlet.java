package service.account.friend;

import domain.Invitation;
import repositoryImplementation.Repo;
import utils.JSONUtils;
import utils.Utils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class GetReceivedInvitationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        Integer status = Utils.getIntegerStatus(request.getParameter("status"));
        List<Invitation> receivedInvitations = Repo.invitationRepository.findInvitationsByReceiverAndStatus(loginUsername, status);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(JSONUtils.invitationListToJSON(receivedInvitations));
    }
}
