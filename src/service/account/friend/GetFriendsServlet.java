package service.account.friend;

import domain.User;
import repositoryImplementation.Repo;
import utils.JSONUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GetFriendsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }
        User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
        List<String> friendList = loginUser.getFriendList();
        List<User> friends = new ArrayList<>();
        for (String friendUsername: friendList) {
            friends.add(Repo.userRepository.findUserByUsername(friendUsername));
        }
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(JSONUtils.userListToJSON(friends));
    }
}
