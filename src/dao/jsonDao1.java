package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;

import util.dbConnection;





public class jsonDao1 {
	

	Connection con;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	public jsonDao1() {

	}
	

	public JSONObject GetCourseList(){
		String sql="select * from course where course_fee > 0";
		JSONObject jobj =new JSONObject();
		List<JSONObject> jlist= new ArrayList();
		
		
		try {
			con = dbConnection.getConnection();
			stmt=con.createStatement();
			rs	=stmt.executeQuery(sql);
			
			int i=0;
			
			while(rs.next()) {
				
				JSONObject jsonobj= new JSONObject();
				
				jsonobj.put("course_id"		, rs.getString("course_id"));
				jsonobj.put("title"			, rs.getString("title"));
				jsonobj.put("c_number"		, rs.getString("c_number"));
				jsonobj.put("professor_id"	, rs.getString("professor_id"));
				jsonobj.put("course_fee"	, rs.getString("course_fee"));
				
				jlist.add(jsonobj);
				i++;
			}
			
			jobj.put("JLIST", jlist);
			jobj.put("JLIST_CNT", i);
			
			rs.close();
			stmt.close();
			con.close();
			return jobj;
			
		}catch(Exception ex) {
			System.out.println("getCourseList :"+ex);
		}

		return jobj;
	}

	
	
}


