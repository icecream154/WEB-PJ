package test;

import utils.C3p0DataSource;

import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class C3p0DataSourceTest {

    @org.junit.jupiter.api.Test
    void getConnection() throws SQLException {
        Connection connection = C3p0DataSource.getConnection();
        System.out.println(connection);
    }
}