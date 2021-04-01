package ctl;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.json.JSONObject;
import org.json.JSONTokener;

import dao.jsonDao2;

/**
 * Servlet implementation class courseCtl
 */
@WebServlet("/jsonCtl2")
public class jsonCtl2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public jsonCtl2() {
        super();
        // TODO Auto-generated constructor stub
    }



	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		try {
		System.out.println("업데이트 접속성공");	

		String sJson = readJSONStringFromRequestBody(request);
		System.out.println("sJson:"+sJson);
		
		//org.json.simple.JSONObject를 제거
		//org.json.JSONObject로 업데이트 => java-json.jar
		JSONObject obj =new JSONObject(sJson);
		System.out.println("JSONObject:"+obj);
		

		jsonDao2 jsonDao2 =new jsonDao2();
		JSONObject jobj =new JSONObject();
		jobj =jsonDao2.UpdateCourseList(obj);

		System.out.println(jobj.toString());
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jobj.toString());
		response.getWriter().flush();		
		}catch(Exception e) {
					
		} //end try
	}//end method
	
	
	private String readJSONStringFromRequestBody(HttpServletRequest request) {
		 StringBuffer json = new StringBuffer();
	        String line = null;
	        try {
	            BufferedReader reader = request.getReader();
	            while((line = reader.readLine()) != null) {
	                json.append(line);
	            }
	        }
	        catch(Exception e) {
	            System.out.println("Error reading JSON string: " + e.toString());
	        }
	        return json.toString();		
	}

}
