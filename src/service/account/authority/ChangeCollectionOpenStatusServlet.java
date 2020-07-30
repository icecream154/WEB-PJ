package service.account.authority;

import domain.User;
import repositoryImplementation.Repo;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ChangeCollectionOpenStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
        loginUser.setOpen(!loginUser.isOpen());
        Repo.userRepository.save(loginUser);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print("{\"message\":\"Changed success!\"}");
    }
}
