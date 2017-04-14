package control.tracker;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import control.login.Database;

public class TrackerModel {
	
	public boolean updateLatLng(String user, String lat, String lng){
		int result=0;
		try {
			Database.makeConnection();
			Connection conn = Database.connect;
			String sql =  "Update User set lat="+lat+", lng="+lng+"where username=\'"+user+"\'";
			Statement statement = conn.createStatement();
			result = statement.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result>0) {
			return true;
		} else {
			return false;
		}
	}
	
	public String[] showAllMarker(){
		String list[]=null;
		try {
			Database.makeConnection();
			Connection conn = Database.connect;
			String sql =  "select * from User";
			Statement statement = conn.createStatement();
			ResultSet rs  = statement.executeQuery(sql);
			rs.last();
			list = new String[rs.getRow()*3];
			int i=0;
			rs.beforeFirst();
			while (rs.next()){
				if (!"off".equals(rs.getString(3))){
					list[i]=rs.getString(1);
					i++;
					list[i]=rs.getString(4);
					i++;
					list[i]=rs.getString(5);
					i++;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return list;
	}

	
	public JSONArray showAllMarkerJson() throws JSONException{		
		JSONArray arrayObj = new JSONArray();
		
		try {
			Database.makeConnection();
			Connection conn = Database.connect;
			String sql =  "select * from User";
			Statement statement = conn.createStatement();
			ResultSet rs  = statement.executeQuery(sql);						
			int i=1;
			while (rs.next()){
				
					JSONObject obj = new JSONObject();
					obj.put("id", i);
					obj.put("name", rs.getString(1));
					obj.put("status", rs.getString(3));
					obj.put("lat", rs.getString(4));
					obj.put("lng", rs.getString(5));
					arrayObj.put(obj);
					i++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return arrayObj;
	}

	public JSONObject[] showAll() throws JSONException{		
		JSONObject[] obj = new JSONObject[100];
		
		try {
			Database.makeConnection();
			Connection conn = Database.connect;
			String sql =  "select * from User";
			Statement statement = conn.createStatement();
			
			ResultSet rs  = statement.executeQuery(sql);						
			int i=0;
			while (rs.next()){				
					//JSONObject obj = new JSONObject();
					obj[i].put("name", rs.getString(1));
					obj[i].put("status", rs.getString(3));
					obj[i].put("lat", rs.getString(4));
					obj[i].put("lng", rs.getString(5));
					//arrayObj.add(obj);
					i++;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return obj;
	}
	
	
	public JSONArray showAllUser() throws JSONException{		
		JSONArray arrayObj = new JSONArray();
		
		try {
			Database.makeConnection();
			Connection conn = Database.connect;
			String sql =  "select * from User";
			Statement statement = conn.createStatement();
			
			ResultSet rs  = statement.executeQuery(sql);						
			
			while (rs.next()){
				
					JSONObject obj = new JSONObject();
					obj.put("name", rs.getString(1));
					obj.put("status", rs.getString(3));
					obj.put("lat", rs.getString(4));
					obj.put("lng", rs.getString(5));
					arrayObj.put(obj);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return arrayObj;
	}
	
	public static void main(String [] args) {
		
		TrackerModel tm =  new TrackerModel();
		JSONArray list;
		try {
			list = tm.showAllMarkerJson();
			for (int i=0; i<list.length(); i++){
				JSONObject jo = list.getJSONObject(i);
				System.out.println("user: "+i);
				System.out.println("name: "+jo.getString("name"));
				System.out.println("status: "+jo.getString("status"));
				System.out.println("lat: "+jo.getString("lat"));
				System.out.println("lng: "+jo.getString("lng"));
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
