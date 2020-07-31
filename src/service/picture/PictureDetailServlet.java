package service.picture;

import domain.Picture;
import domain.User;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class PictureDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        Long id = Long.parseLong(request.getParameter("id"));
        Picture picture = Repo.pictureRepository.findPictureById(id);
        System.out.println(picture);
        if(picture == null){
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }else{
            System.out.println(picture);
            request.setAttribute("picture", picture);
            String loginUsername = (String) request.getSession().getAttribute("loginUsername");
            if(loginUsername != null){
                User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
                request.setAttribute("isAuthor", picture.getAuthor().equals(loginUsername));
                request.setAttribute("isCollected", loginUser.getCollectionList().contains(id));
                updateFootprintList(loginUser, id);
                Repo.userRepository.save(loginUser);
            }
            request.getRequestDispatcher("/pages/picDetail.jsp").forward(request, response);
        }
    }

    private void updateFootprintList(User user, Long picId){
        List<Long> footprintList = user.getFootprintList();
        if(footprintList.contains(picId)){
            footprintList.remove(picId);
            footprintList.add(0, picId);
        }else{
            if(footprintList.size() == User.FOOTPRINT_SIZE){
                footprintList.remove(User.FOOTPRINT_SIZE - 1);
            }
            footprintList.add(0, picId);
        }
    }

}
