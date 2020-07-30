package service.picture.collection;

import domain.Picture;
import domain.User;
import repositoryImplementation.Repo;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class DisplayCollectionsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String currentIndex = request.getParameter("currentIndex");
        if(currentIndex == null){
            currentIndex = "1";
        }

        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        // fail case I
        if(loginUsername == null){
            request.setAttribute("isValid", false);
            request.setAttribute("invalidMessage", "Please log in first");
            request.getRequestDispatcher("/pages/userAccess/collection.jsp").forward(request, response);
            return;
        }

        // fail case II
        User user = Repo.userRepository.findUserByUsername(username);
        if(user == null){
            request.setAttribute("isValid", false);
            request.setAttribute("invalidMessage", "Unknown user");
            request.getRequestDispatcher("/pages/userAccess/collection.jsp").forward(request, response);
            return;
        }

        // success case I
        if(username.equals(loginUsername)){
            request.setAttribute("isValid", true);
            request.setAttribute("isOwnCollection", true);
            request.setAttribute("username", username);
            request.setAttribute("collectionSize", user.getCollectionList().size());
            request.setAttribute("currentIndex", Integer.parseInt(currentIndex));
            List<Picture> footprints = new ArrayList<>();
            List<Long> footprintIds = user.getFootprintList();
            for (Long id: footprintIds) {
                footprints.add(Repo.pictureRepository.findPictureById(id));
            }
            request.setAttribute("footprints", footprints);
            request.getRequestDispatcher("/pages/userAccess/collection.jsp").forward(request, response);
            return;
        }

        // fail case III
        User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
        if(!loginUser.getFriendList().contains(username)){
            request.setAttribute("isValid", false);
            request.setAttribute("invalidMessage", "Sorry, you haven't become friends yet");
            request.getRequestDispatcher("/pages/userAccess/collection.jsp").forward(request, response);
            return;
        }

        // fail case IV
        if(!user.isOpen()){
            request.setAttribute("isValid", false);
            request.setAttribute("invalidMessage", "Sorry, your friend doesn't open his collections.");
            request.getRequestDispatcher("/pages/userAccess/collection.jsp").forward(request, response);
            return;
        }

        // success case II
        request.setAttribute("isValid", true);
        request.setAttribute("isOwnCollection", false);
        request.setAttribute("username", username);
        request.setAttribute("collectionSize", user.getCollectionList().size());
        request.setAttribute("currentIndex", Integer.parseInt(currentIndex));
        request.getRequestDispatcher("/pages/userAccess/collection.jsp").forward(request, response);
    }
}
