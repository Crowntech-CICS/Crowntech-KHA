package model.connections;
import org.apache.commons.dbcp2.BasicDataSource;
/**
 *  DATABASE CONNECTIONS MANAGER
*/
public class ConnectionPoolManager {
    private static BasicDataSource dataSource;
    
    public static void init(String className, String username, String password, String url) {
        dataSource = new BasicDataSource();
        dataSource.setDriverClassName(className);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        dataSource.setMaxTotal(10); //Maximum connections in pool
        dataSource.setInitialSize(3); //Initial connection size
        dataSource.setMaxWaitMillis(5000); // Maximum time to wait for a connection from the pool
        dataSource.setValidationQuery("SELECT 1"); // SQL query used to validate connections
        dataSource.setTestOnBorrow(true); // Whether to validate connections when borrowed from the pool
        dataSource.setRemoveAbandonedOnBorrow(true); // Whether to remove abandoned connections when borrowed from the pool
        dataSource.setRemoveAbandonedTimeout(60); // Timeout (in seconds) for identifying abandoned connections
    }
    
    public static BasicDataSource getDataSource() {
        return dataSource;
    }
    
    public static void close() {
        if (dataSource != null) {
            try {
                dataSource.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
}
