package service.account.basic;

import domain.User;
import repositoryImplementation.Repo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");
        User user;
        User userByName = Repo.userRepository.findUserByUsername(usernameOrEmail);
        User userByEmail = Repo.userRepository.findUserByEmail(usernameOrEmail);
        if(userByName != null || userByEmail != null){
            user = userByName != null ? userByName : userByEmail;
            if(user.getPassword().equals(password)){
                System.out.println("user [" + user.getUsername() + "] login success!");
                request.getSession().setAttribute("loginUsername", user.getUsername());
                response.setStatus(HttpServletResponse.SC_OK);
                response.setCharacterEncoding("UTF-8");
                response.getWriter().print("{\"message\": \"login success\"}");
                return;
            }
        }
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print("{\"message\": \"incorrect info!\"}");
    }
}
