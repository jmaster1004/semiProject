<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
.xans-member-findpasswd .findPw {
    width: 375px;
    margin: 0 auto;
}
.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}
</style>
<div id="wrap">
	<div class="site-wrap">

		<div class="path">
			<span>현재 위치</span>
			<ol>
				<li><a href="/">홈</a></li>
				<li title="현재 위치"><strong>비밀번호 찾기</strong></li>
			</ol>
		</div>

		<div class="titleArea">
			<h2>비밀번호 변경</h2>
			<ul>
				<li>비밀번호 변경이 가능합니다.</li>
				<li>가입하실때 등록한 이메일과 이름, 핸드폰 번호를 입혁해 주세요.</li>
			</ul>
		</div>

		<form id="findPasswdForm" name="findPasswdForm" action="<%=request.getContextPath() %>/site/index.jsp?workgroup=member&work=find_passwd_action" method="post">
			<input id="nextUrl" name="nextUrl" value="/member/passwd/find_passwd_question.html" type="hidden">
			<input id="resultURL" name="resultURL" value="" type="hidden">
			<div class="xans-element- xans-member xans-member-findpasswd ec-base-box typeThin ">
			
				<div class="findPw">
					
					<fieldset>
						<legend>비밀번호 찾기</legend>
						<ul class="ec-base-desc">
							<li></li>
							
							<li class="gBlank20">
							<strong class="term">이메일</strong>
							<span class="desc">
								<input id="member_email" name="member_email" fw-filter="isFill&amp;isIdentity" fw-label="이메일" class="lostInput"type="text">
							</span>
							</li>
							
							<li id="name_view" class="name" style="">
							<strong
								class="term" id="name_lable">이름</strong>
								<span class="desc">
								<input id="member_name" name="member_name" fw-filter="" fw-label="이름" fw-msg="" class="lostInput ec-member-name" placeholder="" value="" type="text">
									</span>
							</li>
									
							<li id="mobile_view" class="mobile" style="">
								<strong class="term">휴대폰 번호</strong>
								<span class="desc">
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
								</span>
							</li>
							
						</ul>
						<div id="message" class="error"></div>
						<div class="ec-base-button gColumn">
							<button type="submit" class="btnSubmit sizeM" id="btnFindPasswd">확인</button>
						</div>
					</fieldset>
				</div>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">


$("#findPasswdForm").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#member_email").val()=="") {
		$("#message").css("display","block");
		$("#message").text("이메일을 입력해 주세요.");
		submitResult=false;
	} else if(!idReg.test($("#member_email").val())) {
		$("#message").css("display","block");
		$("#message").text("이메일 형식에 알맞게 작성해 주세요.");
		submitResult=false;
	}
	
	var nameReg=/^[가-힣]{2,6}$/;
	if($("#member_name").val()=="") {
		$("#message").css("display","block");
		$("#message").text("이름을 입력해 주세요.");	
		submitResult=false;
	} else if(!nameReg.test($("#member_name").val())) {
		$("#message").css("display","block");
		$("#message").text("이름은 2~6자의 한글로만 입력해 주세요.");
		submitResult=false;
	}
	
	var phone2Reg=/\d{3,4}/;
	var phone3Reg=/\d{4}/;
	if($("#member_phone2").val()=="" || $("#member_phone3").val()=="") {
		$("#message").css("display","block");
		$("#message").text("휴대폰 번호를 입력해 주세요.");
		submitResult=false;
	} else if(!phone2Reg.test($("#member_phone2").val()) || !phone3Reg.test($("#member_phone3").val())) {
		$("#message").css("display","block");
		$("#message").text("휴대폰번호는 3~4자리의 숫자로만 입력해 주세요.");
		submitResult=false;
	}
	
	return submitResult;
});
</script>

<style>
.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}
</style>