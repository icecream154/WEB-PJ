package utils;

import com.mysql.cj.result.SqlDateValueFactory;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class Repository<T> {
    private QueryRunner queryRunner = new QueryRunner();
    private Class<T> clazz;

    public Repository(){
        Type superClass = getClass().getGenericSuperclass();
        if(superClass instanceof ParameterizedType){
            ParameterizedType parameterizedType = (ParameterizedType) superClass;
            Type[] typeArgs = parameterizedType.getActualTypeArguments();
            if(typeArgs != null && typeArgs.length > 0){
                if(typeArgs[0] instanceof Class){
                    clazz = (Class<T>) typeArgs[0];
                }
            }
        }
    }

    public <E> E getForValue(String sql, Object ... args){
        Connection connection = null;
        try {
            connection = C3p0DataSource.getConnection();
            return queryRunner.query(connection, sql, new ScalarHandler<>(), args);
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            C3p0DataSource.releaseConnection(connection);
        }
        return null;
    }

    /**
     *
     * @param sql: SQL 语句
     * @param args: SQL 语句填充占位符的参数
     * @return 对象实体组成的列表
     */
    public List<T> getForList(String sql, Object ... args){
        Connection connection = null;
        try {
            connection = C3p0DataSource.getConnection();
            return queryRunner.query(connection, sql, new BeanListHandler<>(clazz), args);
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            C3p0DataSource.releaseConnection(connection);
        }
        return null;
    }

    /**
     *
     * @param sql: SQL 语句
     * @param args: SQL 语句填充占位符的参数
     * @return 指定的对象实体
     */
    public T get(String sql, Object ... args){
        Connection connection = null;
        try {
            connection = C3p0DataSource.getConnection();
            return queryRunner.query(connection, sql, new BeanHandler<>(clazz), args);
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            C3p0DataSource.releaseConnection(connection);
        }
        return null;
    }

    /**
     * 封装了 INSERT, DELETE, UPDATE 操作
     * @param sql: SQL 语句
     * @param args: SQL 语句填充占位符的参数
     */
    public void update(String sql, Object ... args){
        Connection connection = null;
        try {
            connection = C3p0DataSource.getConnection();
            queryRunner.update(connection, sql, args);
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            C3p0DataSource.releaseConnection(connection);
        }
    }
}
