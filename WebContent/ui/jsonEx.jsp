<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% 
	String baseDir=request.getContextPath();
	System.out.print("baseDir:"+baseDir);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>




window.onload=function DOC_LOAD(){  
	//무한반복된다(무한로딩문제점)
	
	//아래 비동기방식으로 response객체를 받으면 jsp페이지 처음 로딩이후 유지되고
	//response값만 가져와서 활성화된다
	//doSelect();
}

	
	
	
	function doSelect(){
		
		var params="";
			params +="<%=baseDir%>/jsonCtl1";
 		 ajax= ajaxObject();
 		 ajax.open("post",params); 

		 ajax.send(null);		 
		 //ajax응답처리
		 ajax.onreadystatechange = function() {//Call a function when the state changes.
			    if(ajax.readyState == 4 && ajax.status == 200) {			    	
			    	var result =JSON.parse(this.responseText); //jsonObject로 반환받을경우 
			    	var cnt=result.JLIST_CNT;

			    	
			    	var tbObj=document.getElementById('crsTb');
			    	for(var i=0; i <cnt; i++){
			    		var new_row=document.getElementById('crsTb').insertRow();			    		
			    		new_row.onclick= function(){
			    			var rowIdx=this.rowIndex;
			    			document.crs.ul_crsId.value =document.crs.course_id[rowIdx].value;		//tbObj.rows[rowIdx].cells[1].innerHTML;
			    			document.crs.ul_title.value =document.crs.title[rowIdx].value;			//tbObj.rows[rowIdx].cells[2].innerHTML;
			    			document.crs.ul_cNum.value  =document.crs.c_number[rowIdx].value;		//tbObj.rows[rowIdx].cells[3].innerHTML;
			    			document.crs.ul_psId.value  =document.crs.professor_id[rowIdx].value; 	//tbObj.rows[rowIdx].cells[4].innerHTML;
			    			document.crs.ul_crsFee.value=document.crs.course_fee[rowIdx].value;		//tbObj.rows[rowIdx].cells[5].innerHTML;			    			
			    		};
			    		var new_cell1= new_row.insertCell();
			    		var new_cell2= new_row.insertCell();
			    		var new_cell3= new_row.insertCell();
			    		var new_cell4= new_row.insertCell();
			    		var new_cell5= new_row.insertCell();
			    		var new_cell6= new_row.insertCell();
			    		new_cell1.innerHTML= (i+1);
			    		new_cell2.innerHTML= "<input type='text' name='course_id' 		readonly='readonly' value='"+result.JLIST[i].course_id		+"'>";
			    		new_cell3.innerHTML= "<input type='text' name='title'	  		readonly='readonly' value='"+result.JLIST[i].title			+"'>";
			    		new_cell4.innerHTML= "<input type='text' name='c_number'    						value='"+result.JLIST[i].c_number		+"'>";  
			    		new_cell5.innerHTML= "<input type='text' name='professor_id' 	readonly='readonly' value='"+result.JLIST[i].professor_id	+"'>"; 
			    		new_cell6.innerHTML= "<input type='text' name='course_fee'	 						value='"+result.JLIST[i].course_fee		+"'>";   	
			    	}// end-for			    	
			    }//end-if
			};		
	}	

	
	
	function doUpdate(){
		var list_cnt = document.crs.course_id.length;
		var list = new Array(); //import필요없나봄
		var OJ	= new Object(); //리스트와 변수를 모두 담는 Object생성		

		
		for(var i=0; i<list_cnt; i++){
			var obj =new Object();  //import필요없나봄
			obj.course_id	= document.crs.course_id[i].value;
			obj.title		= document.crs.title[i].value;
			obj.c_number	= document.crs.c_number[i].value;
			obj.professor_id= document.crs.professor_id[i].value;
			obj.course_fee	= document.crs.course_fee[i].value;
			list[i]=obj;
		}
		
		OJ.list_cnt=list_cnt;
		OJ.list    =list;

		
		var params="";
		params +="<%=baseDir%>/jsonCtl2";
		
	
		ajax= ajaxObject();
 		ajax.open("post",params); 
 		ajax.send(JSON.stringify(OJ));	
		
 		ajax.onreadystatechange = function() {
 			 if(ajax.readyState == 4 && ajax.status == 200) {
 				var result =JSON.parse(this.responseText); //jsonObject로 반환받을경우 
 				
 				//alert(result);
 				for(var i=(list_cnt+1); i>1 ; i--){
 					document.getElementById('crsTb').deleteRow(i);
 				 }
 				
 				for(var i=0; i<result.rsList.length; i++){
 					var new_row=document.getElementById('crsTb').insertRow();	
 					var new_cell1= new_row.insertCell();
		    		var new_cell2= new_row.insertCell();
		    		var new_cell3= new_row.insertCell();
		    		var new_cell4= new_row.insertCell();
		    		var new_cell5= new_row.insertCell();
		    		var new_cell6= new_row.insertCell();
		    		new_cell1.innerHTML= (i+1);
		    		new_cell2.innerHTML= "<input type='text' name='course_id' 		readonly='readonly' value='"+result.rsList[i].course_id		+"'>";
		    		new_cell3.innerHTML= "<input type='text' name='title'	  		readonly='readonly' value='"+result.rsList[i].title			+"'>";
		    		new_cell4.innerHTML= "<input type='text' name='c_number'    						value='"+result.rsList[i].c_number		+"'>";  
		    		new_cell5.innerHTML= "<input type='text' name='professor_id' 	readonly='readonly' value='"+result.rsList[i].err_cd		+"'>"; 
		    		new_cell6.innerHTML= "<input type='text' name='course_fee'	 						value='"+result.rsList[i].err_msg		+"'>"; 
 				}
 			 }//end-if
 		 }//end ajax : 데이터 반응하고 
	}//end doUpdate


	//ajax 객체 자동생성	
	function ajaxObject(){
		if(window.ActiveXObject){ // IE 6 이하
			xmlHttp	= new ActiveXObject("Microsoft.XMLHTTP");
		}else if(window.XMLHttpRequest){// 모질라, 사파리, IE7+ ...
			xmlHttp = new XMLHttpRequest();
		}
		return xmlHttp;
	}
	
	
	//테이블 클릭시 테이블 값 이동
	function tableOnclick(trObj){
		var tbody=trObj.parentNode;
		var trs=tbody.getElementsByTagName('tr');
		var tbObj= document.getElementById('crsTb');
		var rowIdx=0;
		for(var i=0;i<trs.length; i++){
			if(trs[i]==trObj){
				rowIdx=i;
			}			
		}
		document.crs.ul_crsId.value=tbObj.rows[rowIdx].cells[1].innerHTML;
		document.crs.ul_title.value=tbObj.rows[rowIdx].cells[2].innerHTML;
		document.crs.ul_cNum.value=tbObj.rows[rowIdx].cells[3].innerHTML;
		document.crs.ul_psId.value=tbObj.rows[rowIdx].cells[4].innerHTML;
		document.crs.ul_crsFee.value=tbObj.rows[rowIdx].cells[5].innerHTML; 
	}

</script>
</head>
<body>
<form name="crs">

<center>	
<div>
<input type="text"  name ="key_title" >
<input type="button" value="비동기조회" onclick="doSelect();">
<input type="button" value="전체수정(프로시져 호출)" onclick="doUpdate();">
</div>
	<table id ="crsTb" border="1" cellspacing="1">
	<tr>
			<th colspan="6">Course 테이블</th>
	</tr>
	
	<tr>
		<th>순번</th>
		<th>과목ID</th>
		<th>과목명</th>
		<th>과목점수</th>
		<th>교수ID</th>
		<th>수강료</th>
	</tr>
	</table>

 	
	<table  cellspacing="1"border="1"  >
	<tr>
	<td>과목ID <input type="text" name ="ul_crsId" disabled="disabled" style="width:40px"></td>
	<td>과목명 <input type="text" name ="ul_title" disabled="disabled" style="width:40px"></td>
	<td>과목점수<input type="text" name="ul_cNum" style="width:40px"></td>
	<td>교수ID <input type="text" name ="ul_psId" disabled="disabled" style="width:40px"></td>
	<td>수강료<input type="text" name="ul_crsFee" style="width:40px" ></td>
	</tr>
	</table>

</center>
</form>
<h5>1. json </h5>
json사용하려면 json-simple-1.1jar </br>
jsp페이지에 관련 json import하기</br>
org.json.simple.parser.JSONParser</br>
org.json.simple.JSONObject</br>
org.json.simple.JSONArray</br>
java의  response객체로 데이터를 가져오려면 텍스트값만 가져오므로</br>
jsonObject또는 jsonArray로 맵핑하여 데이터를 가져와서 parse하여 사용한다</br>
org.json.simple.JSONObject를 제거</br>
org.json.JSONObject로 업데이트 => java-json.jar</br>
<h5></h5>
<h5>2. ajax통신을 이용한 비동기식 조회 필요 </h5>
단순 서블릿으로 request객체에 데이터를 매핑하여  </br>
jsp페이지를 포워딩할경우 로딩시 화면을 유지하고 데이터만 가져오고 싶을떄</br>
포워딩이 포함된 request객체를 가져오면 무한반복된다.</br>
때문에 response객체에 담아서 ajax로 response를 구현하면<</br>
비동기식으로 화면은 유지하고 데이터만 가져온다. 화면을 다시 포워딩할필요없음</br>

<p>1. 기본 struts와 ajax 통신 확인하기</p>
<p><a href="./aa/aa01.jsp">aa01.jsp 이동하기!!</a> </p>
<p>2. 기본 oracle 연동하기 </p>
<p>oracle 버전에 따른 ojdbc6.jar 또는 ojdbc14.jar파일 다운받기</p>
<p>ojdbc6.jar 파일 위치는 jvm하고 함께 구동되도록 아래경로로 넣기</p>
<p>C:\Program Files (x86)\Java\jdk1.7.0_79\jre\lib\ext</p>
<p><a href="./aa/aa02.jsp">aa02.jsp 이동하기!!</a> </p>
<p>3. ibatis 연동하기, sqlmapping하여 오라클연결</p>
<p>ibatis.jar와  commons-logging-1.1.1.jar 파일을 다운로드하여 경로는 jvm하고 구동되도록 설정</p>
<p>C:\Program Files (x86)\Java\jdk1.7.0_79\jre\lib\ext</p>
<p><a href="./aa/aa03.jsp">aa03.jsp 이동하기!!</a> </p>
<p>4. JSON 이용한 검색 또는 입력</p>
<p>common-collection-3.2.1.jar, common-lang-2.4.jar, ezmorph-1.0.jar, json-lib2.4jdk.jar ,common-beaunutils-1.8.3.jar, commons-logging-1.1.1.jar</p>
<p>C:\Program Files (x86)\Java\jdk1.7.0_79\jre\lib\ext</p>
<p><a href="./aa/aa04.jsp">aa04.jsp 이동하기!!</a> </p>
<p>5. 파일 업로드 및 다운로드, 경로는 로컬로 지정</p>
<p><a href="./aa/aa05.jsp">aa05.jsp 이동하기!!</a> </p>
</body>
</html>