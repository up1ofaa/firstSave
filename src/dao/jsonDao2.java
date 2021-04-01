package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

import oracle.jdbc.OracleTypes;
import util.dbConnection;





public class jsonDao2 {
	

	Connection con;
	Statement stmt;
	PreparedStatement pstmt;
	CallableStatement cstmt;
	ResultSet rs;
	
	int result=0;
	private int cnt;
	
	
	public jsonDao2() {

	}
	

	public JSONObject UpdateCourseList(JSONObject inJobj) throws Exception{			
		
			JSONArray jlist= new JSONArray();

			int cnt = inJobj.getInt("list_cnt");
			jlist   = inJobj.getJSONArray("list");
			System.out.println("cnt:"+cnt);
			System.out.println("jlist:"+jlist);
			
			JSONObject outJobj = new JSONObject();
			
			
			for(int i=0; i<jlist.length(); i++) {
				try {	
					
					String squery="";
					squery +=" { call omvc01.omvc01_u01( ? ,?              "; //output
					squery +="                           ,?, ? ,? ,? ,?  )} "; //input	
					con  = dbConnection.getConnection();
					cstmt = con.prepareCall(squery);	
					
					
					cstmt.registerOutParameter(1, OracleTypes.VARCHAR);
					cstmt.registerOutParameter(2, OracleTypes.VARCHAR);
					cstmt.setString(3,jlist.getJSONObject(i).getString("title"));
					cstmt.setString(4,jlist.getJSONObject(i).getString("c_number"));
					cstmt.setString(5,jlist.getJSONObject(i).getString("professor_id"));
					cstmt.setString(6,jlist.getJSONObject(i).getString("course_fee"));
					cstmt.setString(7,jlist.getJSONObject(i).getString("course_id"));
					
					cstmt.execute();
					
					/*JSONObject jsonobj= new JSONObject();
					
					jsonobj.put("err_cd"		, cstmt.getString(1));
					jsonobj.put("err_msg"		, cstmt.getString(2));
					*/
					
					System.out.println("err_cd:"+cstmt.getString(1));
					System.out.println("err_msg:"+cstmt.getString(2));

					jlist.getJSONObject(i).put("err_cd", cstmt.getString(1));	
					jlist.getJSONObject(i).put("err_msg", cstmt.getString(2));	
					//jlist.put(i, jsonobj);
					System.out.println("result:"+result);

					con.commit();
					cstmt.close();
					con.close();
				
				}catch(Exception ex) {
					con.rollback(); //에러발생시 rollback 처리
					System.out.println("getCourseList :"+ex);
				}finally {
					try {
						con.setAutoCommit(true);//트랜잭션 처리를 기본 상태로 되돌린다
						cstmt.close();
						con.close();
					}catch(Exception e) {}
				}//end try
			}// end for문
			
			outJobj.put("rsList", jlist );
			return outJobj;

	}

	
	
}


