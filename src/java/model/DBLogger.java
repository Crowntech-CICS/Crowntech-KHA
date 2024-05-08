package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.connections.ConnectionPoolManager;
import model.uniqueId.UniqueIdGenerator;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class DBLogger {
    private static final Log logger = LogFactory.getLog(DBLogger.class);
    public void log(String userId, String message){
        try {
            //Get Connection
            Connection conn = ConnectionPoolManager.getDataSource().getConnection();
            PreparedStatement ps;            
            String logId = new UniqueIdGenerator().logId();
            //LOG ACTION
            ps = conn.prepareStatement("INSERT INTO LOGS(LOGID,USERID,\"action\") VALUES (?,?,?)");
            ps.setString(1, logId);
            ps.setString(2, userId);
            ps.setString(3, message);
            logger.info("Log Status:" + ((ps.executeUpdate() > 0)? "Success" : "Failed"));
            ps.close();
            conn.close();            
        } catch (SQLException ex) {
            logger.error("LogId Check Error - " + ex.getMessage());
        }
    }
}
