package controller;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/**
 * WEB APPLICATION LIFE CYCLE LISTENER
 * 
 */
public class SystemContextListener implements ServletContextListener {
    private static final Log logger = LogFactory.getLog(SystemContextListener.class);
    /**
     * WHEN WEB APP OPENS
     * 
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("SystemContextListener init");
        ServletContext sc = sce.getServletContext();
        //INITIALIZE CONNECTIONS MANAGER
        ConnectionPoolManager.init(
            sc.getInitParameter("jdbcClassName"), 
            sc.getInitParameter("dbUserName"), 
            sc.getInitParameter("dbPassword"), 
            sc.getInitParameter("jdbcDriverURL")
        );
    }
    /**
     * WHEN WEB APP CLOSES
     * 
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        logger.info("SystemContextListener destroy");
        //CLOSE CONNECTIONS
        ConnectionPoolManager.close();
    }
}
