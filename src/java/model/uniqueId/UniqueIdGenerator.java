
package model.uniqueId;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class UniqueIdGenerator {
    private static final Log logger = LogFactory.getLog(UniqueIdGenerator.class);
    private Connection conn; 
    private PreparedStatement ps;
    private ResultSet rs;
    
    //UserId
    public String userId(String prefix) throws SQLException {
        String userId = "";
        conn = ConnectionPoolManager.getDataSource().getConnection();
        userId = prefix + new IdGenerator().createFormatted("????-??");
        ps = conn.prepareStatement("select userid from users where userid = ?");
        ps.setString(1, userId);
        rs = ps.executeQuery();
        while(rs.next()){
            userId = prefix + new IdGenerator().createFormatted("????-??");
            logger.info("TEST UID: " + userId);
            rs = ps.executeQuery();
        }
        rs.close();
        ps.close();
        conn.close();
        return userId;
    }
    //PropertyId
    public String propertyId() throws SQLException {
        String propertyId = "";
        conn = ConnectionPoolManager.getDataSource().getConnection();
        propertyId = "PR-" + new IdGenerator().createFormatted("????-??");
        ps = conn.prepareStatement("select propertyid from userlot where propertyid = ?");
        ps.setString(1, propertyId);
        rs = ps.executeQuery();
        while(rs.next()){
            propertyId = "PR-" + new IdGenerator().createFormatted("????-??");
            logger.info("PID: " + propertyId);
            rs = ps.executeQuery();
        }
        rs.close();
        ps.close();
        conn.close();
        return propertyId;
    }
    //LogId
    public String logId() throws SQLException {
        String logId = "";
        conn = ConnectionPoolManager.getDataSource().getConnection();
        logId = "LOG" + new IdGenerator().createFormatted("???-???");
        ps = conn.prepareStatement("select userid from logs where logid = ?");
        ps.setString(1, logId);
        rs = ps.executeQuery();
        while(rs.next()){
            logId = "LOG" + new IdGenerator().createFormatted("???-???");
            logger.info("TEST LogID: " + logId);
            rs = ps.executeQuery();
        }
        rs.close();
        ps.close();
        conn.close();
        return logId;
    }
}
