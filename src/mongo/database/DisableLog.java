package mongo.database;
import org.slf4j.LoggerFactory;
import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.Logger;
public class DisableLog {
	static Logger root = (Logger) LoggerFactory
	        .getLogger(Logger.ROOT_LOGGER_NAME);

	static {
	    root.setLevel(Level.INFO);
	}
	
}
