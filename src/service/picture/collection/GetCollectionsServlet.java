package service.picture.collection;

import domain.Picture;
import domain.User;
import repositoryImplementation.Repo;
import utils.JSONUtils;
import utils.Utils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class GetCollectionsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        String targetUsername = request.getParameter("username");
        User targetUser;
        if(targetUsername == null || (targetUser = Repo.userRepository.findUserByUsername(targetUsername)) == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Unknown user!\"}");
            return;
        }

        if(!(targetUsername.equals(loginUsername) || targetUser.getFriendList().contains(loginUsername))){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"No access!\"}");
            return;
        }

        int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
        int pageSize = Integer.parseInt(request.getParameter("pageSize"));
        List<Long> ids = targetUser.getCollectionList();
        List<Picture> pictures = new ArrayList<>();
        for (Long id: ids) {
            pictures.add(Repo.pictureRepository.findPictureById(id));
        }
        List<Picture> targetPictures = Utils.getTargetPictures(pictures, pageIndex, pageSize);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(JSONUtils.pictureListToJSON(targetPictures));
    }
}
