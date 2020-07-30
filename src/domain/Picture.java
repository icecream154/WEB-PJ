package domain;

import java.sql.Blob;
import java.util.Date;

public class Picture {
    private Long id;
    private String author;
    private String title;
    private String theme;
    private String introduction;
    private String country;
    private String city;
    private Date releaseTime;
    private Long heat;
    private String url;

    public Picture() {
    }

    public Picture(String author, String title, String theme, String introduction, String country, String city, String url) {
        this.author = author;
        this.title = title;
        this.theme = theme;
        this.introduction = introduction;
        this.country = country;
        this.city = city;
        this.url = url;
        this.releaseTime = new Date();
        this.heat = 0L;
    }

    @Override
    public String toString() {
        return "Picture{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", theme='" + theme + '\'' +
                ", introduction='" + introduction + '\'' +
                ", country='" + country + '\'' +
                ", city='" + city + '\'' +
                ", releaseTime=" + releaseTime +
                ", heat=" + heat +
                ", url=" + url +
                '}';
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Date getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Date releaseTime) {
        this.releaseTime = releaseTime;
    }

    public Long getHeat() {
        return heat;
    }

    public void setHeat(Long heat) {
        this.heat = heat;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
