package service.picture;

import domain.Picture;
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

public class GetMyPicturesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
        int pageSize = Integer.parseInt(request.getParameter("pageSize"));
        List<Picture> myPictures = Repo.pictureRepository.findPicturesByAuthorOrderByReleaseTime(loginUsername);
        List<Picture> targetPictures = Utils.getTargetPictures(myPictures, pageIndex, pageSize);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(JSONUtils.pictureListToJSON(targetPictures));
    }
}
