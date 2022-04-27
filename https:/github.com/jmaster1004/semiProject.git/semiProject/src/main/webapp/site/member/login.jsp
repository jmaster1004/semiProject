<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	if(!(loginMember==null)) {//로그인 사용자인 경우
		//request.getRequestURI() : 클라이언트가 요청한 URI 주소를 반환하는 메소드
		//ex) http://localhost:8000/jsp/site/index.jsp?workgroup=cart&work=cart_list
		// => URI 주소 - http://localhost:8000/jsp/site/index.jsp
		// => request.getRequestURI() : /jsp/site/index.jsp
		String requestURI=request.getRequestURI();
		//System.out.println("requestURI = "+requestURI);
		
		//request.getQueryString() : 클라이언트가 요청한 URL 주소의 QueryString을 반환하는 메소드
		//ex) http://localhost:8000/jsp/site/index.jsp?workgroup=cart&work=cart_list
		// => request.getQueryString() : workgroup=cart&work=cart_list
		String queryString=request.getQueryString();
		//System.out.println("queryString = "+queryString);
		
		if(queryString==null || queryString.equals("")) {
			queryString="";	
		} else {
			queryString="?"+queryString;
		}
		
		//세션에 요청 페이지의 URL 주소를 저장
		session.setAttribute("url", requestURI+queryString);
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?workgroup=admin&work=admin_member_list';");
		out.println("</script>");
		return;
	}




	if(request.getParameter("status")!=null){
		if(request.getParameter("status").equals("1")) {
		session.removeAttribute("url");
		}
	}

	String email=(String)session.getAttribute("member_email");
	if(email==null) {
		email="";
	}else {
		session.removeAttribute("member_email");
	}
	
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>

<style>
SS Code are here!
                            
                            body {
    background: #f9f9f9;
    font-family: "Raleway", sans-serif;
    color: #151515;
}

a {
    color: black;
    font-weight: 600;
    font-size: 0.85em;
    text-decoration: none;
}

label {
    color: black;
    font-weight: 600;
    font-size: .85em;
}

input:focus {
    outline: none;
}

.container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 60vh;
}

.form {
    display: flex;
    width: auto;
    background: #fff;
    margin: 15px;
    padding: 25px;
    border-radius: 25px;
    box-shadow: 0px 10px 25px 5px #0000000f;
}

.sign-in-section {
    padding: 30px;
}

.sign-in-section h6 {
    margin-top: 0px;
    font-size: 0.75em;
}

.sign-in-section h1 {
    text-align: center;
    font-weight: 700;
    position: relative;
}

.sign-in-section h1:after {
    position: absolute;
    content: "";
    height: 5px;
    bottom: -15px;
    margin: 0 auto;
    left: 0;
    right: 0;
    width: 40px;
    background: #f700ff;
    background: -webkit-linear-gradient(to right, #e100ff, #7f00ff);
    background: linear-gradient(to right, #e100ff, #7f00ff);
    -o-transition: 0.25s;
    -ms-transition: 0.25s;
    -moz-transition: 0.25s;
    -webkit-transition: 0.25s;
    transition: 0.25s;
}

.sign-in-section h1:hover:after {
    width: 100px;
}

.sign-in-section ul {
    list-style: none;
    padding: 0;
    margin: 0;
    text-align: center;
}

.sign-in-section ul>li {
    display: inline-block;
    padding: 10px;
    font-size: 15px;
    width: 20px;
    text-align: center;
    text-decoration: none;
    margin: 5px 2px;
    border-radius: 50%;
    box-shadow: 0px 3px 1px #0000000f;
    border: 1px solid #e2e2e2;
}

.sign-in-section p {
    text-align: center;
    font-size: 0.85em;
}

.form-field {
    display: block;
    width: 300px;
    margin: 10px auto;
}

.form-field label {
    display: block;
    margin-bottom: 10px;
}

.form-field input[type="email"],
input[type="password"] {
    width: -webkit-fill-available;
    padding: 15px;
    border-radius: 10px;
    border: 1px solid #e8e8e8;
}

.form-field input::placeholder {
    color: #e8e8e8;
}

.form-field input:focus {
    border: 1px solid #ae00ff;
}

.form-field input[type="checkbox"] {
    display: inline-block;
}

.form-options {
    display: block;
    margin: auto;
    width: 300px;
}

.checkbox-field {
    display: inline-block;
    float: left;
}

.form-options a {
    float: right;
    text-decoration: none;
}

.btn {
    padding: 15px;
    font-size: 1em;
    width: 100%;
    border-radius: 25px;
    border: none;
    margin: 20px 0px;
}

.btn-signin {
    cursor: pointer;
    background: #7f00ff;
    background: -webkit-linear-gradient(to right, #e100ff, #7f00ff);
    background: linear-gradient(to right, #e100ff, #7f00ff);
    box-shadow: 0px 5px 15px 5px #840fe440;
    color: #fff;
}

.link a:nth-child(2) {
    float: right;
}

.link a:nth-child(1) {
    float: left;
}

</style>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form Design HTML & CSS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="style.css">
</head>

<body>


    <div class="container">
        <div class="form">
            <div class="sign-in-section">
                <h1>Log In</h1>
					<form class="loginForm" id="loginForm" name="loginForm" action="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=login_action" method="post">
                    <div class="form-field">
                        <label for="email">Email</label>
                        <input type="email" id="member_email" name="member_email" placeholder="이메일">
                    </div>
                    <div class="form-field">
                        <label for="password">Password</label>
                        <input type="password" id="member_password" name="member_password" placeholder="비밀번호">
                    </div>
                    <div class="form-options">
                        <div class="checkbox-field">
                            <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=find_passwd" style="margin-left:5px; font-size:12px; font-weight:bold;">비밀번호 찾기</a>
                            <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=find_email" style="margin-right:5px; font-size:12px; font-weight:bold;">이메일 찾기</a>
                        </div>
                        <a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=join" class="right" style="font-size:12px;">가입하기</a>
                    </div>
                    <div class="form-field">
                        <input type="button" id="btnLoin" class="btn btn-signin" value="LOGIN" />
                    </div>
                </form>
                <div class="link">
					<div id="message" class="error" style="color:red"><%=message %></div>
                </div>
            </div>
        </div>
    </div>

</body>
<script type="text/javascript">
	$(document).ready(function() {
	
	$("#btnLoin").click(function() {
		if($("#member_email").val()=="") {
			$("#message").text("이메일을 입력해 주세요.");
			return;

		}
					
		if($("#member_password").val()=="") {
			$("#message").text("비밀번호를 입력해 주세요.");
			return;
		}		
					
		$("#loginForm").submit();
			
	});
				
	});
</script>