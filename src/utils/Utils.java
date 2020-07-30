package utils;

import domain.Invitation;
import domain.Picture;

import java.util.ArrayList;
import java.util.List;

public class Utils {
    public static List<Picture> getTargetPictures(List<Picture> myPictures, int pageIndex, int pageSize){
        int totalPage = (myPictures.size() + pageSize - 1) / pageSize;
        List<Picture> targetPictures = new ArrayList<>();
        if(pageIndex > 0 && pageIndex < totalPage){
            for(int i = 0; i < pageSize; i++){
                targetPictures.add(myPictures.get((pageIndex - 1) * pageSize + i));
            }
        }else if(pageIndex != 0 && pageIndex == totalPage){
            int left = myPictures.size() - pageSize * (totalPage - 1);
            for(int i = 0; i < left; i++){
                targetPictures.add(myPictures.get((pageIndex - 1) * pageSize + i));
            }
        }
        return targetPictures;
    }

    public static String getStringStatus(Integer status){
        switch (status){
            case Invitation.S_PENDING: return "PENDING";
            case Invitation.S_ACCEPTED: return "ACCEPTED";
            case Invitation.S_DENIED: return "DENIED";
            default: return "";
        }
    }

    public static Integer getIntegerStatus(String status){
        switch (status){
            case "PENDING": return Invitation.S_PENDING;
            case "ACCEPTED": return Invitation.S_ACCEPTED;
            case "DENIED": return Invitation.S_DENIED;
            default: return null;
        }
    }

}
