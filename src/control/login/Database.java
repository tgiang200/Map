package control.login;


import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Database {
    public class java {

	}

	public static String address="localhost";
    public static int port=3306;
    public static String database="tracker";
    public static String username="user1";
    public static String password="user1";
    public static String url="jdbc:mysql://"+address+":"+port+"/"+database;
    public static Connection connect;
    public static boolean status;
    
    public static void makeConnection() throws SQLException{
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Database.connect=(Connection) DriverManager.getConnection(Database.url, Database.username, Database.password);
            //System.out.print("success\n");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            //System.out.print("failed\n");
            ex.printStackTrace();
        }        
    }
}
