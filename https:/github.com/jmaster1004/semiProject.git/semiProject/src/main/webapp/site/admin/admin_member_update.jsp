<%@page import="xyz.itwill.dto.MemberDTO"%>

<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email_data");
	String name = request.getParameter("name_data");
	String phone = request.getParameter("phone_data");

	MemberDTO member = MemberDAO.getDAO().selectEmailMember(email);

	
	String p1= phone.substring(0, 3);
	String p2= phone.substring(4, 8);
	String p3= phone.substring(9);

 	
%>
<div id="wrap">
	<div class="site-wrap">
		<div class="titleArea">
			<h2>
				<font color="#555555">회원수정</font>
			</h2>
		</div>
		<form class="joinForm" id="joinForm" name="joinForm">
		<input type="hidden" name="emailCheckResult" id="emailCheckResult" value="0">
		<div class="xans-element- xans-member xans-member-join">
			<div class="ec-base-table typeWrite">
				<table border="1" summary="">
			        	<colgroup>
						<col style="width:150px;"/>
						<col style="width:auto;"/>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									이메일
								</th>
								<td>
									<input type="hidden" name="member_email" value="<%= email %>">
									<p><%= email %></p>
								</td>
							</tr>
							<tr>
								<th scope="row">
									비밀번호
								</th>
								<td>
									<button type="button" id="pswdUpdate">비밀번호 수정</button>
								</td>
							</tr>
							<tr>
								<th scope="row">
									이름
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<input type="text" name="member_name" id="member_name" maxlength="20" value="<%= name %>">
									<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
									<div id="nameRegMsg" class="error">이름은 2~6자의 한글로만 입력해 주세요.</div>
									
								</td>
							</tr>
							<tr>
								<th scope="row">
									휴대전화
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<select id="member_phone1" name="member_phone1">											
										<option value="010" selected="selected">&nbsp;010&nbsp;</option>
										<option value="011">&nbsp;011&nbsp;</option>
										<option value="016">&nbsp;016&nbsp;</option>
										<option value="017">&nbsp;017&nbsp;</option>
										<option value="018">&nbsp;018&nbsp;</option>
										<option value="019">&nbsp;019&nbsp;</option>
									</select>
									<input id="member_phone2" name="member_phone2" size="7" maxlength="4" type="text" value="<%= p2 %>">
									<input id="member_phone3" name="member_phone3" size="7" maxlength="4" type="text" value="<%= p3 %>">
									<div id="phoneMsg" class="error">휴대폰번호를 입력해 주세요.</div>
									<div id="phoneRegMsg" class="error">휴대폰번호는 3~4자리의 숫자로만 입력해 주세요.</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									주소
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<div>
										<input type="text" name="member_zipcode" id="member_zipcode" size="7" readonly="readonly" value="<%= member.getMemberZipcode() %>">
										<button type="button" id="postSearch">우편번호 검색</button>
										<input type="hidden" name="member_zipcode">
										<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
									</div>
									<div>
										<input type="text" name="member_address1" id="member_address1" size="50" readonly="readonly" value="<%= member.getMemberAddress1() %>">
										<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
									</div>
									<div>
										<input type="text" name="member_address2" id="member_address2" size="50" value="<%= member.getMemberAddress2() %>">
										<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
										
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									권한설정
								</th>
								<td>
									<select id="member_status" name="member_status">											
										<option value="0"<%if(member.getMemberStatus()==0){ %> selected="selected"<%} %>>일반</option>
										<option value="9"<%if(member.getMemberStatus()==9){ %> selected="selected"<%} %>>관리자</option>
										<option value="11"<%if(member.getMemberStatus()==11){ %> selected="selected"<%} %>>비활성화(삭제)</option>
									</select>
								</td>
							</tr>
							
						</tbody>
				</table>
			</div>
		</div>
		<br>
		<div id="fs">
			<button type="reset" id="btnCancel">다시입력</button>
			<button type="button" id="btnJoin">수정</button>
		</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$("#member_email").focus();
	
	$("#pswdUpdate").click(function() {
		
		$("#joinForm").attr("method", "post");
		$("#joinForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=find_passwd_action");
		$("#joinForm").submit();
	});
	
	$("#btnJoin").click(function() {
		
		$("#joinForm").attr("method", "post");
		$("#joinForm").attr("action", "<%=request.getContextPath()%>/site/index.jsp?workgroup=admin&work=admin_member_update_action");
		$("#joinForm").submit();
	});
	
	
	$("#joinForm").submit(function() {
		var submitResult=true;
		
		$(".error").css("display","none");
		
		var nameReg=/^[가-힣]{2,6}$/;
		if($("#member_name").val()=="") {
			$("#nameMsg").css("display","block");		
			alert("이름을 다시 확인해주세요");
			submitResult=false;
		} else if(!nameReg.test($("#member_name").val())) {
			$("#nameRegMsg").css("display","block");
			alert("이름을 다시 확인해주세요");
			submitResult=false;
		}
		
		var phone2Reg=/\d{3,4}/;
		var phone3Reg=/\d{4}/;
		if($("#member_phone2").val()=="" || $("#member_phone3").val()=="") {
			$("#phoneMsg").css("display","block");
			submitResult=false;
		} else if(!phone2Reg.test($("#member_phone2").val()) || !phone3Reg.test($("#member_phone3").val())) {
			$("#phoneRegMsg").css("display","block");
			submitResult=false;
		}
		
		if($("#member_zipcode").val()=="") {
			$("#zipcodeMsg").css("display","block");
			submitResult=false;
		}
		
		if($("#member_address1").val()=="") {
			$("#address1Msg").css("display","block");
			submitResult=false;
		}
		
		if($("#member_address2").val()=="") {
			$("#address2Msg").css("display","block");
			submitResult=false;
		}
		
		return submitResult;
	});

</script>

<!-- 카카오API연결 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	window.onload = function(){
	document.getElementById("postSearch").addEventListener("click", function(){ //주소입력칸을 클릭하면
		//카카오 지도 발생
		new daum.Postcode({
			oncomplete: function(data) { //선택시 입력값 세팅
				document.getElementById("member_zipcode").value = data.zonecode;
				document.getElementById("member_address1").value = data.address; // 주소 넣기
				document.querySelector("input[name=member_address2]").focus(); //상세입력 포커싱
			}
		}).open();
	});
	}
</script>

<style type="text/css">

.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}

#pswdUpdate {
	font-size: 12px;
	font-weight: bold;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
}

#postSearch {
	font-size: 12px;
	font-weight: bold;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
}

#btnCancel {
    padding: 9px;
    border-top: 1px solid #d7d5d5;
    text-align: center;
    background: #fbfafa;
}

#btnJoin {
	color: #ffffff;
    padding: 9px;
    border-top: 1px solid #d7d5d5;
    text-align: center;
    background: #333333;
}



#fs {
	text-align: center;
}

</style>
