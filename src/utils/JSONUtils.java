package utils;

import domain.Invitation;
import domain.Picture;
import domain.User;

import java.util.List;

public class JSONUtils {

    public static String userToJSON(User user){
        StringBuilder result = new StringBuilder("{");
        result.append("\"username\":\"").append(user.getUsername()).append("\",");
        result.append("\"email\":\"").append(user.getEmail()).append("\",");
        result.append("\"registerTime\":\"").append(user.getRegisterTime()).append("\"");
        result.append("}");
        System.out.println(result.toString());
        return result.toString();
    }

    public static String userListToJSON(List<User> userList){
        if(userList == null || userList.size() == 0){
            return "[]";
        }
        StringBuilder result = new StringBuilder("[");
        for (User user: userList) {
            result.append(userToJSON(user)).append(",");
        }
        result.deleteCharAt(result.length() - 1);
        result.append("]");
        System.out.println(result.toString());
        return result.toString();
    }

    public static String invitationToJSON(Invitation invitation){
        StringBuilder result = new StringBuilder("{");
        result.append("\"id\":").append(invitation.getId()).append(",");
        result.append("\"sender\":\"").append(invitation.getSender()).append("\",");
        result.append("\"receiver\":\"").append(invitation.getReceiver()).append("\",");
        result.append("\"status\":\"").append(Utils.getStringStatus(invitation.getStatus())).append("\",");
        result.append("\"time\":\"").append(invitation.getTime()).append("\"");
        result.append("}");
        System.out.println(result.toString());
        return result.toString();
    }

    public static String invitationListToJSON(List<Invitation> invitationList){
        if(invitationList == null || invitationList.size() == 0){
            return "[]";
        }
        StringBuilder result = new StringBuilder("[");
        for (Invitation invitation: invitationList) {
            result.append(invitationToJSON(invitation)).append(",");
        }
        result.deleteCharAt(result.length() - 1);
        result.append("]");
        System.out.println(result.toString());
        return result.toString();
    }

    public static String pictureToJSON(Picture picture){
        StringBuilder result = new StringBuilder("{");
        result.append("\"id\":").append(picture.getId()).append(",");
        result.append("\"author\":\"").append(picture.getAuthor()).append("\",");
        result.append("\"title\":\"").append(dealDoubleQuotes(picture.getTitle())).append("\",");
        result.append("\"theme\":\"").append(dealDoubleQuotes(picture.getTheme())).append("\",");
        result.append("\"introduction\":\"").append(dealDoubleQuotes(picture.getTheme())).append("\",");
        result.append("\"city\":\"").append(picture.getCity()).append("\",");
        result.append("\"country\":\"").append(picture.getCountry()).append("\",");
        result.append("\"releaseTime\":\"").append(picture.getReleaseTime()).append("\",");
        result.append("\"heat\":\"").append(picture.getHeat()).append("\",");
        result.append("\"url\":\"").append(picture.getUrl()).append("\"");
        result.append("}");
        System.out.println(result.toString());
        return result.toString();
    }

    private static String dealDoubleQuotes(String tar){
        StringBuilder stringBuilder = new StringBuilder();
        for (char character: tar.toCharArray()) {
            if(character == '"'){
                stringBuilder.append('\\');
                stringBuilder.append('"');
            }else{
                stringBuilder.append(character);
            }
        }
        return stringBuilder.toString();
    }

    public static String pictureListToJSON(List<Picture> pictureList){
        if(pictureList == null || pictureList.size() == 0){
            return "[]";
        }
        StringBuilder result = new StringBuilder("[");
        for (Picture picture: pictureList) {
            result.append(pictureToJSON(picture)).append(",");
        }
        result.deleteCharAt(result.length() - 1);
        result.append("]");
        System.out.println(result.toString());
        return result.toString();
    }

}
