<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/all.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<title>Bag&Bag</title>
</head>
<body>
<div id="wrap">
	<div class="site-wrap">
		<div class="titleArea">
			<h2>회원가입</h2>
		</div>
		<form class="joinForm" id="joinForm" name="joinForm" action="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=join_action" method="post">
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
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<input id="member_email" name="member_email" type="text" placeholder="example@example.com">
									<button type="button" id="emailCheck" class="btnNormal">중복검사</button>
									<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
									<div id="emailRegMsg" class="error">이메일 형식에 알맞게 작성해 주세요.</div>
									<div id="emailCheckMsg" class="error">이메일 중복검사를 반드시 실행해 주세요.</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									비밀번호
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<input type="password" name="member_password" id="member_password" placeholder="영어 대소문자/숫자 6~20자">
									<div id="pwMsg" class="error">비밀번호를 입력해 주세요.</div>
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
									<div id="repwMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
									<div id="repwMatchMsg" class="error">비밀번호와 비밀번호확인이 일치하지 않습니다.</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									이름
									<img src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif" alt="필수">
								</th>
								<td>
									<input type="text" name="member_name" id="member_name" maxlength="20">
									<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
									<div id="nameReMsg" class="error">이름은 2~6자의 한글로만 입력해 주세요.</div>
									
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
									<input id="member_phone2" name="member_phone2" size="7" maxlength="4" type="text">
									<input id="member_phone3" name="member_phone3" size="7" maxlength="4" type="text">
									<div id="phoneMsg" class="error">휴대폰번호를 입력해 주세요.</div>
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
										<input type="text" name="member_zipcode" id="member_zipcode" size="7" readonly="readonly">
										<button type="button" id="postSearch" class="btnNormal">우편번호</button>
										<input type="hidden" name="member_zipcode">
										<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
									</div>
									<div>
										<input type="text" name="member_address1" id="member_address1" size="50" readonly="readonly">
										<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
									</div>
									<div>
										<input type="text" name="member_address2" id="member_address2" size="50" >
										<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
										
									</div>
								</td>
							</tr>
						</tbody>
				</table>
			</div>
		</div>
		<br>
		<div id="fs">
			<button type="reset" id="btnCancel" class="btnEmFix sizeM">다시입력</button>
			<button type="submit" id="btnJoin" class="btnSubmitFix sizeM">회원가입</button>
		</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$("#member_email").focus();
	
	$("#joinForm").submit(function() {
		var submitResult=true;
		
		$(".error").css("display","none");
		
		var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
		if($("#member_email").val()=="") {
			$("#emailMsg").css("display","block");
			submitResult=false;
		} else if(!idReg.test($("#member_email").val())) {
			$("#emailRegMsg").css("display","block");
			submitResult=false;
		} else if($("#emailCheckResult").val()=="0") {
			$("#emailCheckMsg").css("display","block");
			submitResult=false;
		}
		
		var pwReg=/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,20}$/g;
		if($("#member_password").val()=="") {
			$("#pwMsg").css("display","block");
			submitResult=false;
		} else if(!pwReg.test($("#member_password").val())) {
			$("#pwRegMsg").css("display","block");
			submitResult=false;
		} 
		
		if($("#repw").val()=="") {
			$("#repwMsg").css("display","block");
			submitResult=false;
		} else if($("#passwd").val()!=$("#repw").val()) {
			$("#repwMatchMsg").css("display","block");
			submitResult=false;
		}
		
		var nameReg=/^[가-힣]{2,6}$/;
		if($("#member_name").val()=="") {
			$("#nameMsg").css("display","block");		
			submitResult=false;
		} else if(!nameReg.test($("#member_name").val())) {
			$("#nameRegMsg").css("display","block");
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
	

	
	//이메일중복검사
	$("#emailCheck").click(function() {
		$("#emailMsg").css("display","none");
		$("#emailRegMsg").css("display","none");
				
		var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g
		if($("#member_email").val()=="") {
			$("#emailMsg").css("display","block");
			return;
		} else if(!emailReg.test($("#member_email").val())) {
			$("#emailRegMsg").css("display","block");
			return;
		}
		window.open("<%=request.getContextPath()%>/site/member/email_check.jsp?email="+$("#member_email").val()
							,"emailcheck","width=450,height=100,left=700,top=400");
		});
						
	$("#member_email").change(function() {
		if($("#emailCheckResult").val()=="1") {
			$("#emailCheckResult").val("0");//아이디 중복 검사 상태를 미실행 상태로 변경
		}
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





#fs {
	text-align: center;
}

</style>
</body>