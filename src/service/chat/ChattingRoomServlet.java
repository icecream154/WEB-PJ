package service.chat;

import domain.User;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ChattingRoomServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.sendRedirect("/index.jsp");
            return;
        }
        String targetUser = request.getParameter("targetUser");
        User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
        if(!loginUser.getFriendList().contains(targetUser)){
            response.sendRedirect("/index.jsp");
            return;
        }

        request.setAttribute("room", Repo.roomRepository.findOrCreateRoom(loginUsername, targetUser));
        request.getRequestDispatcher("/pages/userAccess/chatting/chattingRoom.jsp").forward(request, response);
    }
}
