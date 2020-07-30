package service.picture;

import domain.Picture;
import domain.User;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class DeletePictureServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        if(request.getParameter("picId") == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"picId missing!\"}");
            return;
        }

        Long id = Long.parseLong(request.getParameter("picId"));
        Picture picture;
        if((picture = Repo.pictureRepository.findPictureById(id)) == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"unknown picId!\"}");
            return;
        }

        if(!picture.getAuthor().equals(loginUsername)){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"No access!\"}");
            return;
        }

        Repo.pictureRepository.delete(id);
        User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
        loginUser.setPictureCount(loginUser.getPictureCount() - 1);
        Repo.userRepository.save(loginUser);

        deletePictureFromCollectionsAndFootPrints(id);

        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print("{\"message\":\"Delete success!\"}");

    }

    private void deletePictureFromCollectionsAndFootPrints(Long id){
        List<User> allUsers = Repo.userRepository.getAll();
        for (User user: allUsers) {
            user.getCollectionList().remove(id);
            user.getFootprintList().remove(id);
            Repo.userRepository.save(user);
        }
    }
}
