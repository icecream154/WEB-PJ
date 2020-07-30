package service.account.display;

import domain.User;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UserAccountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        User user = Repo.userRepository.findUserByUsername(username);
        if(user == null){
            // no such user, redirect to index.jsp
            response.sendRedirect("index.jsp");
        }else{
            // add current user in request attributes
            request.setAttribute("user", user);
            // log this visit
            System.out.println(user);
            // get current log status
            String loginUsername = (String) request.getSession().getAttribute("loginUsername");
            // visit one's own account page
            if(loginUsername != null && loginUsername.equals(username)){
                System.out.println("visit [" + loginUsername + "]'s own account");
                request.getRequestDispatcher("/pages/userAccess/account.jsp").forward(request, response);
            }else{
            // visit other's account page
                if(loginUsername != null){
                    System.out.println("[" + loginUsername + "] visit [" + username + "]'s account");
                    Boolean isFriend = Repo.userRepository.findUserByUsername(loginUsername).getFriendList().contains(username);
                    request.setAttribute("isFriend", isFriend);
                }
                request.getRequestDispatcher("/pages/user.jsp").forward(request, response);
            }
        }

    }
}
