package service.account.basic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        if(request.getSession().getAttribute("loginUsername") != null){
            request.getSession().removeAttribute("loginUsername");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().print("{\"message\": \"Log out success!\"}");
        }else{
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\": \"You haven't logged in yet!\"}");
        }
    }
}
