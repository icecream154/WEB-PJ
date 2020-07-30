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
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class SearchPicturesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchContent = new String(request.getParameter("searchContent").getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        String searchField = request.getParameter("searchField");
        String searchOrder = request.getParameter("searchOrder");
        String pageSize = request.getParameter("pageSize");
        String pageIndex = request.getParameter("pageIndex");

        List<Picture> results = searchPictures(searchContent, searchField, searchOrder);
        List<Picture> targetPictures = Utils.getTargetPictures(results, Integer.parseInt(pageIndex), Integer.parseInt(pageSize));

        String responseText = "{\"totalPictureCount\":" + results.size() + ",\"pics\":"
                + JSONUtils.pictureListToJSON(targetPictures) + "}";
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(responseText);
    }

    private List<Picture> searchPictures(String searchContent, String searchField, String searchOrder){
        List<Picture> results = new ArrayList<>();
        switch(searchField){
            case "TITLE":
                results = searchPicturesFromTitle(searchContent, searchOrder);
                break;
            case "THEME":
                results = searchPicturesFromTheme(searchContent, searchOrder);
                break;
        }
        return results;
    }

    private List<Picture> searchPicturesFromTitle(String searchContent, String searchOrder){
        List<Picture> results = new ArrayList<>();
        switch (searchOrder){
            case "HEAT":
                results = Repo.pictureRepository.findPicturesByTitleContainsOrderByHeat(searchContent);
                break;
            case "TIME":
                results = Repo.pictureRepository.findPicturesByTitleContainsOrderByReleaseTime(searchContent);
                break;
        }
        return results;
    }

    private List<Picture> searchPicturesFromTheme(String searchContent, String searchOrder){
        List<Picture> results = new ArrayList<>();
        switch (searchOrder){
            case "HEAT":
                results = Repo.pictureRepository.findPicturesByThemeContainsOrderByHeat(searchContent);
                break;
            case "TIME":
                results = Repo.pictureRepository.findPicturesByThemeContainsOrderByReleaseTime(searchContent);
                break;
        }
        return results;
    }

}
