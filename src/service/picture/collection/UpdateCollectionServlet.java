package service.picture.collection;

import domain.Picture;
import domain.User;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UpdateCollectionServlet extends HttpServlet {

    private static final String O_ADD = "ADD";
    private static final String O_REMOVE = "REMOVE";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        Long id = Long.parseLong((String) request.getParameter("id"));
        String operation = request.getParameter("operation");
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\": \"Please log in first!\"}");
        }else{
            Picture picture = Repo.pictureRepository.findPictureById(id);
            if(picture == null){
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"message\": \"Picture doesn't exist!\"}");
                return;
            }
            User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
            switch (operation){
                case O_ADD:
                    if(loginUser.getCollectionList().contains(id)){
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().print("{\"message\": \"Picture in your collection already!\"}");
                    }else{
                        loginUser.getCollectionList().add(id);
                        Repo.userRepository.save(loginUser);
                        picture.setHeat(picture.getHeat() + 1);
                        Repo.pictureRepository.save(picture);
                        System.out.println(picture);
                        response.setStatus(HttpServletResponse.SC_OK);
                        response.getWriter().print("{\"message\": \"Add to collection success!\"}");
                    }
                    break;
                case O_REMOVE:
                    if(loginUser.getCollectionList().contains(id)){
                        loginUser.getCollectionList().remove(id);
                        Repo.userRepository.save(loginUser);
                        picture.setHeat(picture.getHeat() - 1);
                        Repo.pictureRepository.save(picture);
                        System.out.println(picture);
                        response.setStatus(HttpServletResponse.SC_OK);
                        response.getWriter().print("{\"message\": \"Remove from collection success!\"}");
                    }else{
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().print("{\"message\": \"Picture not in your collection yet!\"}");
                    }
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().print("{\"message\": \"Unknown operation!\"}");
            }

        }

    }
}
