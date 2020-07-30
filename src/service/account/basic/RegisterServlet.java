package service.account.basic;

import domain.User;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.regex.Pattern;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        response.setCharacterEncoding("UTF-8");
        if(Repo.userRepository.findUserByUsername(username) != null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\": \"username has been registered!\"}");
            return;
        }

        if(Repo.userRepository.findUserByEmail(email) != null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\": \"email has been registered!\"}");
            return;
        }

        if(!isValidUsername(username)){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\": \"username format error!\"}");
            return;
        }

        if(!isValidEmail(email)){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\": \"email format error!\"}");
            return;
        }

        if(!isValidPassword(password)){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\": \"password format error!\"}");
            return;
        }

        User newUser = new User(username, password, email);
        Repo.userRepository.save(newUser);
        request.getSession().setAttribute("loginUsername", username);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print("{\"message\": \"register success!\"}");
    }

    private boolean isValidUsername(String username){
        System.out.println("username: " + username);
        return Pattern.matches("^[a-zA-Z0-9]{4,15}$", username);
    }

    private boolean isValidEmail(String email){
        System.out.println("email: " + email);
        return Pattern.matches("^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$", email);
    }

    private boolean isValidPassword(String password){
        System.out.println("password: " + password);
        return Pattern.matches("^.{6,12}$", password);
    }

}
