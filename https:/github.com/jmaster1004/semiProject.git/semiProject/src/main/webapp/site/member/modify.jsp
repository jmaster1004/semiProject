<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 비밀번호를 전달받아 로그인 사용자의 비밀번호와 비교하여 같은 경우 입력태그에
회원정보를 초기값으로 설정하고 변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 비정상적인 요청이므로 에러페이지로 이동 --%>
<%-- => 전달받은 비밀번호가 로그인 사용자의 비밀번호와 같지 않은 경우 비밀번호 입력페이지(password_confirm.jsp)로 이동  --%>
<%-- => [회원정보변경]을 클릭한 경우 회원정보변경 처리페이지(member_modify_action.jsp)로 이동 - 입력값 전달 --%>
 <%@include file="/site/security/login_check.jspf" %>
 

<body>
<div id="wrap">
	<div class="site-wrap">

		<div class="path">
			<span>현재 위치</span>
			<ol>
				<li><a href="/">홈</a></li>
				<li title="현재 위치"><strong>회원 정보 수정</strong></li>
			</ol> 
		</div>

		<div class="titleArea">
			<h2>회원 정보 수정</h2>
		</div>

		<form name="modifyForm" id="join" action="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=modify_action" method="post">

			<h3 class="displaynone ">기본정보</h3>
			<p class="required displaynone">
				<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수"> 
				필수입력사항
			</p>
			<div class="ec-base-table typeWrite">
				<table border="1" summary="">
					<caption>회원 기본정보</caption>
					<colgroup>
						<col style="width: 150px;">
						<col style="width: auto;">
					</colgroup>
					<tbody>
						<tr>
								<th scope="row">
									이메일
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<input id="member_email" name="member_email" type="text" value="<%=loginMember.getMemberEmail()%>" readonly="readonly">
									
								</td>
							</tr>
							<tr>
								<th scope="row">
									비밀번호
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<input type="password" name="member_password" id="member_password">
									(영어 대소문자/숫자 포함 6~20자)
									<div>변경하지 않는 경우 입력하지 마세요.</div>
									<div id="pwReglMsg" class="error">비밀번호는 영어 대소문자/숫자가 포함된 6~20 범위로만 작성 가능합니다.</div>			
								</td>
							</tr>
							<tr>
								<th scope="row">
									비밀번호 확인
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<input type="password" name="repw" id="repw">
									<div id="repwMatchMsg" class="error">비밀번호와 비밀번호확인이 일치하지 않습니다.</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									이름
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<input id="member_name" name="member_name" class="ec-member-name" maxlength="30" readonly="readonly" value="<%=loginMember.getMemberName()%>" type="text">
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
									<input id="member_phone2" name="member_phone2" size="7" maxlength="4" type="text" value="<%=(loginMember.getMemberPhone().substring(4, 8))%>">
									<input id="member_phone3" name="member_phone3" size="7" maxlength="4" type="text" value="<%=(loginMember.getMemberPhone().substring(9, 13))%>">
									<div id="phoneReMsg" class="error">휴대폰번호는 3~4자리의 숫자로만 입력해 주세요.</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									주소
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<div>
										<input type="text" name="member_zipcode" id="member_zipcode" size="7" value="<%=loginMember.getMemberZipcode()%>" readonly="readonly">
										<button type="button" id="postSearch" class="btnNormal">우편번호</button>
										<input type="hidden" name="zipcode">
									
									</div>
									<div>
										<input type="text" name="member_address1" id="member_address1" size="50" value="<%=loginMember.getMemberAddress1()%>" readonly="readonly">
									
									</div>
									<div>
										<input type="text" name="member_address2" id="member_address2" size="50" value="<%=loginMember.getMemberAddress2()%>">
										
										
									</div>
								</td>
							</tr>
					</tbody>
				</table>
			</div>

			<div class="ec-base-table typeWrite "></div>
			<div class="ec-base-button justify">
				<button typy="submit" id="btnModify" class="btnSubmitFix sizeM">회원정보수정</button>
				<a href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=mypage" class="btnEmFix sizeM">취소</a>
				<span class="gRight">
				<a id="btnRemove" class="btnNormal sizeS" href="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=password_confirm&action=remove">회원탈퇴</a>
				</span>
			</div>
			
</form>
	</div>
</div>
<script type="text/javascript">
	$("#member_email").focus();
	
	$("#modifyForm").submit(function() {
		var submitResult=true;
		
		$(".error").css("display","none");
				
		var pwReg=/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,20}$/g;
		if(!pwReg.test($("#member_password").val())) {
			$("#pwReglMsg").css("display","block");
			submitResult=false;
		} 
		
		if($("#repw").val()=="") {
			if($("#member_passwd").val()!=$("#repw").val()) {
			$("#repwMatchMsg").css("display","block");
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
				document.getElementById("zipcode").value = data.zonecode;
				document.getElementById("address1").value = data.address; // 주소 넣기
				document.querySelector("input[name=address2]").focus(); //상세입력 포커싱
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

#emailCheck {
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
</body>