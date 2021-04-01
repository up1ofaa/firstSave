package ctl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import dao.jsonDao1;
import vo.courseVO;

/**
 * Servlet implementation class courseCtl
 */
@WebServlet("/jsonCtl1")
public class jsonCtl1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public jsonCtl1() {
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

		jsonDao1 jsonDao1 =new jsonDao1();
		JSONObject jobj =new JSONObject();
		jobj =jsonDao1.GetCourseList();


		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jobj.toString());
		response.getWriter().flush();		
		
	}

}
