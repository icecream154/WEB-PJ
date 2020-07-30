package utils;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class C3p0DataSource {
    public static DataSource dataSource = null;

    static {
        dataSource = new ComboPooledDataSource("travelApp");
    }

    public static Connection getConnection() throws SQLException{
        return dataSource.getConnection();
    }

    public static void releaseConnection(Connection connection){
        try{
            if(connection != null){
                connection.close();
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
    }

}
