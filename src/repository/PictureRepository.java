package repository;

import domain.Picture;

import java.util.List;

public interface PictureRepository {
    void save(Picture picture);
    void delete(Long id);
    Picture findPictureById(Long id);
    List<Picture> findPicturesByAuthorOrderByReleaseTime(String username);

    List<Picture> findPicturesByTitleContainsOrderByReleaseTime(String searchContent);
    List<Picture> findPicturesByTitleContainsOrderByHeat(String searchContent);
    List<Picture> findPicturesByThemeContainsOrderByReleaseTime(String searchContent);
    List<Picture> findPicturesByThemeContainsOrderByHeat(String searchContent);
}
