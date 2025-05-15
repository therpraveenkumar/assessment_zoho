<!DOCTYPE html> <%-- No I18N --%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.adventnet.iam.security.SecurityUtil"%>
<html lang="en">
<head>
<meta charset="utf-8">
		<title><%=com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.VERIFY.PASSWORD")%> </title>

<% 
String jsurl = request.getContextPath() + "/static"; //No I18N
String imgurl = request.getContextPath();
%>
<script src="<%=IAMEncoder.encodeHTMLAttribute(jsurl)%>/jquery-3.6.0.min.js" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
@font-face {
	font-family: 'Roboto';
	font-style: normal;
	font-weight: 400;
	src: local('Roboto'), local('Roboto-Regular'), url(<%=IAMEncoder.encodeHTMLAttribute(imgurl)%>/images/robotoregular/font.woff2) format('woff2');
}
@font-face {
	font-family: 'Roboto';
	font-style: normal;
	font-weight: 500;
	src: local('Roboto Medium'), local('Roboto-Medium'), url(<%=IAMEncoder.encodeHTMLAttribute(imgurl)%>/images/robotomedium/font.woff2) format('woff2');
}

	body 
	{
		font-family: 'Roboto', sans-serif;
		margin: 0;
	}
	.signin_container {
		width: 100%;
		box-shadow: none;
		margin: 0 auto;
		position: relative;
		z-index: 1;
		margin-top: 100px;
		overflow: hidden;
		height: 520px;
	}
	.signin_box {
		width: 100%;
		margin-top: 50px;
		padding: 0px 30px;
		min-height: 360px;
		height: auto;
		background: #fff;
		box-sizing: border-box;
		border-radius: 2px;
		transition: all .1s ease-in-out;
		float: left;
		overflow-y: auto;
	}
	.zoho_logo {
		display: block;
		height: 30px;
		width: auto;
		margin-bottom: 20px;
		background: url(/accounts/images/newoauth/Zoho_logo.png) no-repeat transparent;
		background-size: auto 100%;
	}
	.signin_head {
		margin-bottom: 30px;
		display: block;
		font-size: 24px;
		font-weight: 500;
		transition: all .1s ease-in-out;
	}
	.service_name {
		display: block;
		font-size: 16px;
		color: #555;
		font-weight: 400;
		margin-top: 10px;
		line-height: 24px;
	}
	.hellouser {
		margin-bottom: 30px;
	}
	.username {
		display:block;
		max-width: 100%;
		font-size: 18px;
		font-weight: 500;
		line-height: 34px;
		overflow: hidden;
		text-overflow: ellipsis;
		padding-right: 10px;
		margin-bottom: 30px;		
	}

	.bluetext {
		color: #309FF4;
		cursor: pointer;
	}
	.textbox_div {
		display: block;
		margin-bottom: 30px;
	}
	.textbox {
		background-color: #fff;
		border: none;
		border-bottom: 2px solid #F4F6F8;
		text-indent: 0px;
		border-radius: 0;
		display: block;
		width: 100%;
		height: 44px;
		box-sizing: border-box;
		font-size: 16px;
		outline: none;
		padding-right: 12px;
		transition: all .2s ease-in-out;
	}
	.show_hide_password {
		height: 28px;
		width: 28px;
		display: block;
		position: relative;
		float: right;
		cursor: pointer;
		background: url(/accounts/images/newoauth/show.png) no-repeat transparent;
		background-size: 100%;
		margin-top: -35px;
		margin-right: 12px;
	}
	.hidetext {
		background: url(/accounts/images/newoauth/hide.png) no-repeat transparent;
		background-size: 100%;
	}
	.btn {
		margin-top: 10px;
		border-radius: 4px;
		cursor: pointer;
		display: block;
		width: 100%;
		height: 44px;
		font-size: 14px;
		font-weight: 600;
		outline: none;
		border: none;
		margin: auto;
		text-transform: uppercase;
		margin-bottom: 30px;
		transition: all .2s ease-in-out;
		letter-spacing: .5px;
	}
	.blue {
		box-shadow: 0px 2px 2px #fff;
		background-color: #159AFF;
		color: #fff;
	}
	.fielderror
	{
		display: none;
		color: #ff5151;
		margin-top: 10px;
		font-size: 14px;
	}
	
</style>
</head>
<body>

		<div class="signin_box" id="signin_flow">
			<div class="zoho_logo"></div>
			<div id="signin_div">				
				<div class="signin_head">
					<span><%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.VERIFY.PASSWORD")%></span>
					<div class="service_name"><%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.VERIFY.PASSWORD.CHANGE.REVERIFY")%></div>
				</div>
				<div class="username"><%=IAMEncoder.encodeHTML(String.valueOf(request.getAttribute("EMAIL")))%> </div>
				<div class="textbox_div">
					<input id="password" placeholder="Password" type="password" class="textbox" required=""> 
					<span class="show_hide_password"></span>
					<div class="fielderror"><%I18NUtil.getMessage("IAM.CONFIRMATION.ERROR.PASSWORD.INVALID"); %></div> <%-- No I18N --%>
				</div>
				<button class="btn blue" id="nextbtn"><%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.CONFIRM")%></button>
			</div>
		</div>

</body>
<script>
	$(".show_hide_password").click(function() {
    	var passType = $("#password").attr("type");//no i18n
    	if(passType==="password")
		{
   			$("#password").attr("type","text");//no i18n		
   			$(".show_hide_password").addClass("hidetext");
    	}
		else
		{
   			$("#password").attr("type","password");//no i18n
   			$(".show_hide_password").removeClass("hidetext");
    	}
    });
	
	$("#nextbtn").unbind("click").click(function(){
	    var password = $("#password").val();
	    if(isEmpty(password)){
	    	$(".fielderror").text("<%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.ERROR.ENTER.LOGINPASS")%>");
	    	$(".fielderror").slideDown(200);
	    	return;
	    }
        $("#nextbtn").prop("disabled", true); <%-- No I18N --%>
		var xhttp = new XMLHttpRequest();
	   	var params = "pass="+encodeURIComponent(password) + "&" + getcsrfParams(); <%-- No I18N --%>
	    xhttp.open("POST", "/oauth/v2/mobile/inactive/token/activate", true);
	    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    xhttp.send(params);
	    xhttp.onreadystatechange = function () {
	    	if(this.readyState == 4 && this.status == 200) {
	    		var response = this.responseText;
	    		response = JSON.parse(response);
	    		if(response.status == "success") {
	    			window.location=response.url;
	    			return;
	    		} else {
	    			$("#nextbtn").prop("disabled", false); <%-- No I18N --%>
	    			$(".fielderror").text(response.message);
	    			$(".fielderror").slideDown(200);
	    		}
	    	} else if(this.status != 200){
	    		$("#nextbtn").prop("disabled", false); <%-- No I18N --%>
	    		$(".fielderror").text("<%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
	    		$(".fielderror").slideDown(200);
	    	}
	    }
	});

	function isEmpty(str) {
	    return str ? false : true;
	}
	
	function getcsrfParams() {
		var csrfParamName = "<%=SecurityUtil.getCSRFParamName(request)%>"; //NO OUTPUTENCODING
		var csrfCookieName = "<%=SecurityUtil.getCSRFCookieName(request)%>"; //NO OUTPUTENCODING
		var csrfQueryParam = csrfParamName + "=" + getCookieValue(csrfCookieName);
		return csrfQueryParam;
	}

	function getCookieValue(cookieName) {
	    var nameEQ = cookieName + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0;i < ca.length;i++) {
	        var c = ca[i].trim();
	        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	    }
	    return null;
	}
</script>
</html>
