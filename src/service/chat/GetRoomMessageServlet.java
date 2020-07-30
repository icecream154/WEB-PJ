package service.chat;

import domain.chatting.Room;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class GetRoomMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        String user1 = request.getParameter("user1");
        String user2 = request.getParameter("user2");
        Room room = Repo.roomRepository.findRoom(user1, user2);

        if(!user1.equals(loginUsername) && !user2.equals(loginUsername)){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"No authority!\"}");
            return;
        }

        if(room == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"No such chatting room!\"}");
            return;
        }

        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(room.getMessages());

    }
}
