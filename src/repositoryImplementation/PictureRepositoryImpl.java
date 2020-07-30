package repositoryImplementation;

import domain.Picture;
import repository.PictureRepository;
import utils.Repository;

import java.sql.Timestamp;
import java.util.List;

public class PictureRepositoryImpl extends Repository<Picture> implements PictureRepository {
    @Override
    public void save(Picture picture) {
        if(findPictureById(picture.getId()) == null){
            String sql = "INSERT INTO pictures(author, title, theme, introduction, country, city, releaseTime, url) VALUES(?,?,?,?,?,?,?,?)";
            update(sql, picture.getAuthor(), picture.getTitle(), picture.getTheme(), picture.getIntroduction(), picture.getCountry(),
                    picture.getCity(), new Timestamp(picture.getReleaseTime().getTime()), picture.getUrl());
        }else{
            String sql = "UPDATE pictures SET title=?, theme=?, introduction=?, country=?, city=?, releaseTime=?, url=?, heat=? WHERE id=?";
            update(sql, picture.getTitle(), picture.getTheme(), picture.getIntroduction(), picture.getCountry(),
                    picture.getCity(), new Timestamp(picture.getReleaseTime().getTime()), picture.getUrl(), picture.getHeat(), picture.getId());
        }
    }

    @Override
    public void delete(Long id) {
        String sql = "DELETE FROM pictures WHERE id=?";
        update(sql, id);
    }

    @Override
    public Picture findPictureById(Long id) {
        String sql = "SELECT id, author, title, theme, introduction, country, city, releaseTime, heat, url FROM pictures WHERE id=?";
        return get(sql, id);
    }

    @Override
    public List<Picture> findPicturesByAuthorOrderByReleaseTime(String username) {
        String sql = "SELECT id, author, title, theme, introduction, country, city, releaseTime, heat, url FROM pictures WHERE author=? ORDER BY releaseTime DESC";
        return getForList(sql, username);
    }

    @Override
    public List<Picture> findPicturesByTitleContainsOrderByReleaseTime(String searchContent) {
        String sql =
                "SELECT id, author, title, theme, introduction, country, city, releaseTime, heat, url FROM pictures " +
                        "WHERE title LIKE '%" + searchContent + "%' ORDER BY releaseTime DESC";
        return getForList(sql);
    }

    @Override
    public List<Picture> findPicturesByTitleContainsOrderByHeat(String searchContent) {
        String sql =
                "SELECT id, author, title, theme, introduction, country, city, releaseTime, heat, url FROM pictures " +
                        "WHERE title LIKE '%" + searchContent + "%' ORDER BY heat DESC";
        return getForList(sql);
    }

    @Override
    public List<Picture> findPicturesByThemeContainsOrderByReleaseTime(String searchContent) {
        String sql =
                "SELECT id, author, title, theme, introduction, country, city, releaseTime, heat, url FROM pictures " +
                        "WHERE theme LIKE '%" + searchContent + "%' ORDER BY releaseTime DESC";
        return getForList(sql);
    }

    @Override
    public List<Picture> findPicturesByThemeContainsOrderByHeat(String searchContent) {
        String sql =
                "SELECT id, author, title, theme, introduction, country, city, releaseTime, heat, url FROM pictures " +
                        "WHERE theme LIKE '%" + searchContent + "%' ORDER BY heat DESC";
        return getForList(sql);
    }
}
