package service.picture;

import domain.Picture;
import domain.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import repositoryImplementation.Repo;
import utils.StringGenerator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.List;

public class UploadPictureServlet extends HttpServlet {

    private static final int MAX_FILE_SIZE = 1024 * 1024 * 10;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String loginUsername = (String) request.getSession().getAttribute("loginUsername");
        if(loginUsername == null){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"message\":\"Please log in first!\"}");
            return;
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 超过 MAX_FILE_SIZE 就写到临时目录
        factory.setSizeThreshold(MAX_FILE_SIZE);
        File tempDirectory = new File("C:\\Users\\icecr\\Desktop\\xam");
        factory.setRepository(tempDirectory);

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(MAX_FILE_SIZE);
        FileItem picFile = null;
        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item: items) {
                if(item.isFormField()){
                    String name = item.getFieldName();
                    String value = item.getString();
                    request.setAttribute(name, value);
                    System.out.println(name + ": " + request.getAttribute(name));
                }else{
                    System.out.println("picFile found");
                    picFile = item;
                }
            }

            System.out.println(picFile);
            Long id = Long.parseLong((String)(request.getAttribute("id")));
            String changed = (String) request.getAttribute("changed");
            String title = (String) request.getAttribute("title");
            String theme = (String) request.getAttribute("theme");
            String introduction = (String) request.getAttribute("introduction");
            String country = (String) request.getAttribute("country");
            String city = (String) request.getAttribute("city");
            String url = id == -1 ? null : Repo.pictureRepository.findPictureById(id).getUrl();

            boolean saveFile = (id == -1) || (changed.equals("true"));
            boolean fileMissing = saveFile && picFile == null;
            if(fileMissing || title == null || theme == null || introduction == null || country == null || city == null
                || title.equals("") || theme.equals("") || introduction.equals("") || country.equals("") || city.equals("")){
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"message\":\"form data missing!\"}");
                return;
            }

            if(saveFile && !picFile.getContentType().startsWith("image")){
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"message\":\"not picture file!\"}");
                return;
            }
            System.out.println("contentType: " + (picFile == null ? "null" : picFile.getContentType()));

            if(picFile != null && picFile.getSize() > MAX_FILE_SIZE){
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"message\":\"too big file!\"}");
                return;
            }

            String absPath = request.getServletContext().getRealPath("");
            System.out.println(absPath);
            if(saveFile){
                if((url = savePicFile(picFile, absPath)) == null){
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().print("{\"message\":\"fail to save picture!\"}");
                    return;
                }
            }

            //String author, String title, String theme, String introduction, String country, String city, String url
            Picture picture = new Picture(loginUsername, title, theme, introduction, country, city, url);
            picture.setReleaseTime(new Date());
            if(id != -1){
                picture.setId(id);
            }
            System.out.println("PIC: \n" + picture);
            Repo.pictureRepository.save(picture);
            //author's picture count++
            if(id == -1){
                User loginUser = Repo.userRepository.findUserByUsername(loginUsername);
                loginUser.setPictureCount(loginUser.getPictureCount() + 1);
                Repo.userRepository.save(loginUser);
            }
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().print("{\"message\": \"upload success!\"}");
            response.sendRedirect(request.getContextPath() + "/pages/userAccess/picture.jsp?currentIndex=1");
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
    }

    private String savePicFile(FileItem item, String absPath){
        String fileName = item.getName();
        String filePath;
        try {
            InputStream in = item.getInputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            filePath = "/images/" + new Date().getTime()
                    + StringGenerator.getRandomString(6, 6, StringGenerator.DIGITS_AND_LETTERS_SET)
                    + fileName.substring(fileName.lastIndexOf('.'));
            System.out.println(absPath + filePath);
            OutputStream out = new FileOutputStream(absPath + filePath);
            while((len = in.read(buffer)) != -1){
                out.write(buffer, 0, len);
            }
            in.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            filePath = null;
        }
        return filePath == null ? null : "." + filePath;
    }
}
