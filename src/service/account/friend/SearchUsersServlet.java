package service.account.friend;

import domain.User;
import repositoryImplementation.Repo;
import utils.JSONUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class SearchUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        List<User> users = Repo.userRepository.findUsersByUsernameContains(username);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(JSONUtils.userListToJSON(users));
    }
}
