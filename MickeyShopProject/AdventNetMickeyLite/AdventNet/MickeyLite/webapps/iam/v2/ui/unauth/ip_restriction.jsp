<%-- $Id$ --%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.adventnet.iam.IAMStatusCode.StatusCode"%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.zoho.accounts.AccountsConstants"%>
<%@ page isErrorPage="true"%>
<%
	response.setContentType("text/html;charset=UTF-8"); //No I18N
	String heading = null;
	String description = null;
	String refresh = null;
	String resetIPUrl =null;
	StatusCode code = (StatusCode) request.getAttribute("statuscode");//No I18N
	if (code == StatusCode.USER_NOT_ALLOWED_IP) {
		heading = Util.getI18NMsg(request, "IAM.ERRORJSP.IP.NOT.ALLOWED.TITLE");
		description = Util.getI18NMsg(request, "IAM.ERRORJSP.IP.NOT.ALLOWED.ERROR.DESC",IAMUtil.getRemoteUserIPAddress(request));
		refresh = Util.getI18NMsg(request, "IAM.ERRORJSP.IP.NOT.ALLOWED.ERROR.REFRESH");
		
		if("true".equals(AccountsConfiguration.getConfiguration("enable.reset.ip.recovery", "true")))
		{
			String requestURI = request.getRequestURI().toString();
			String serverUrl = null;
			if (requestURI.equals("/")) {
				serverUrl = request.getRequestURL().toString();
				serverUrl = serverUrl.substring(0, serverUrl.length() - 1); // removing last char
			} else {
				serverUrl = request.getRequestURL().toString().replace(requestURI, "");// No I18N
			}
			serverUrl = serverUrl.concat(request.getContextPath());
			resetIPUrl = new StringBuilder(serverUrl).append(Util.AccountsUIURLs.RESET_IP.getURI()).toString();
		}
		
	} else if (code == StatusCode.LOCATION_NOT_ALLOWED) {
		heading = Util.getI18NMsg(request, "IAM.ERRORJSP.LOCATION.NOT.ALLOWED.TITLE");
		description = Util.getI18NMsg(request, "IAM.ERRORJSP.LOCATION.NOT.ALLOWED.ERROR.DESC");
		refresh = Util.getI18NMsg(request, "IAM.ERRORJSP.LOCATION.NOT.ALLOWED.ERROR.REFRESH");
	}
%>
<html>
	<head>
		<title><%= Util.getI18NMsg(request,"IAM.ZOHO.ACCOUNTS")%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<%=StaticContentLoader.getStaticFilePath("/v2/components/css/zohoPuvi.css")%>" rel="stylesheet"type="text/css">
	</head>
	<style>
	body {
		width: 100%;
		font-family: 'ZohoPuvi', Georgia;
		margin: 0px;
	}
	
	.container {
		display: block;
		width: 70%;
		margin: auto;
		margin-top: 120px;
	}
	
	.zoho_logo {
		display: block;
		margin: auto;
		height: 34px;
		max-width: 200px;
		width: 100px;
		background: url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/zoho.png")%>") no-repeat transparent;
		background-size: auto 100%;
		margin-bottom: 40px;
		background-position: center;
	}
	
	.error_img {
		display: block;
		height: 300px;
		margin-bottom: 40px;
		width: 100%;
	}
	
	.ip_block {
		background: url(<%=StaticContentLoader.getStaticFilePath("/v2/components/images/RestrictIP.svg")%>) no-repeat transparent;
		background-size: auto 100%;
		background-position: center;
	}
	
	.heading {
		display: block;
		text-align: center;
		font-size: 24px;
		margin-bottom: 10px;
		line-height: 34px;
		font-weight: 600;
	}
	
	.discrption {
		display: block;
		width: 500px;
		margin: auto;
		text-align: center;
		font-size: 16px;
		margin-bottom: 10px;
		line-height: 24px;
		color: #444;
	}
	
	.discrption p {
	    color: #E56000;
	}
	
	.refresh_btn
	{
	   	background-color: #1389E3;
	    color: #fff;
	    padding: 12px 30px;
	    border-radius: 5px;
	    font-size: 14px;
	    cursor: pointer;
		width: fit-content;
	    width: -moz-fit-content;
	    width: -webkit-fit-content;
	    font-weight: 600;
	    margin: auto;
	    margin-top: 30px;
	    border: none;
	    margin-right: 20px;
	}
	
	.whit_btn
	{
		background-color: #fff;
	    color: #1389E3;
	    padding: 12px 30px;
	    border-radius: 5px;
	    font-size: 14px;
	    cursor: pointer;
		width: fit-content;
	    width: -moz-fit-content;
	    width: -webkit-fit-content;
	    font-weight: 600;
	    margin: auto;
	    margin-top: 30px;
	    border: 1px solid #1389E3;
	}
	
	.logout-wrapper {
	    position: fixed;
	    top: 25px;
	    right: 50px;
	    cursor: pointer;
	    border: solid 1px #fff;
	    border-radius: 8px;
	    font-family: 'ZohoPuvi', Georgia;
	    font-size: 14px;
	    transition: .3s width, .3s height;
	    display: none;
	}
	
	.logout-wrapper.show {
		display: block;
	}
	
	.logout-wrapper:hover {
	    border-color: #e0e0e0;
	    background-color: #fbfcfc;
	}
	
	.logout-wrapper .name {
		position: absolute;
	    top: 0px;
	    right: 38px;
	    margin: 0;
	    line-height: 30px;
	    display: block;
	    white-space: nowrap;
	    transition: top .3s;
	}
	
	.logout-wrapper img {
	    width: 30px;
	    height: 30px;
	    position: absolute;
	    right: 0px;
	    top: 0px;
	    transition: all .3s ease-out;     
	    border-radius: 50%;     
	}
	
	.logout-wrapper.open .name {
	    font-size: 16px;
	    font-weight: 500;
	    top: 108px;
	    line-height: 1;
	}
	
	.logout-wrapper.open img {
	    width: 80px;
	    height: 80px;
	    top: 20px;
	    right: calc(50% - 64px);
	}
	
	.logout-wrapper.open {
	    border-color: #e0e0e0;
	    background-color: #fbfcfc;
	    box-shadow: 0px 0px 6px 8px #ececec85;   
	}
	
	p.muted {
	    font-size: 12px;
	    line-height: 16px;
	    color: #5b6367;
	    margin:0px;
	    padding-top: 10px
	}
	
	a.err-btn {
	    background-color: #EF5E57;
	    cursor: pointer;
	    width: fit-content;
	    width: -moz-fit-content;
	    width: -webkit-fit-content;
	    font-weight: 500;
	    color: #fff;
	    padding: 10px 30px;
	    border-radius: 5px;
	    font-size: 12px;
	    border: none;
	    margin: 20px auto;
	    font-family: 'ZohoPuvi', Georgia;
	    text-decoration: none;
	    display: block;
	}
	
	a.err-btn:focus, a.err-btn:focus-visible {
		outline: none;
	}
	
	.user-info {
	    position: absolute;
	    top: 0px;
	    right: 0px;
	    height: 30px;
	    margin: 8px 24px;
	    /* transition: all .3s; */
	}
	
	.more-info {
	    position: absolute;
	    visibility: hidden;
	    top: 0px;
	    right: 0;
	    text-align: center;
	    transition: top .3s;    
	    width: 100%;
	    display: table;
	}
	
	.logout-wrapper.open .more-info {
	    visibility: visible;
	    top: 132px;
	    right: 0px;
	    min-width:280px;
	}
	
	.logout-wrapper.open .user-info {
	    margin: 8px 24px 0px 0px;
	}
	
	@media only screen and (max-width: 435px) {
		.container {
			width: 90%;
			margin-top: 50px;
		}
		.discrption {
			width: 100%;
		}
		.error_img {
			display: block;
			max-width: 340px;
			background-size: 100% auto;
			margin: auto;
			margin-bottom: 40px;
		}
		.heading {
			display: block;
			text-align: center;
			font-size: 20px;
			margin-bottom: 10px;
			line-height: 30px;
			font-weight: 600;
		}
		.discrption {
			display: block;
			margin: auto;
			text-align: center;
			font-size: 14px;
			margin-bottom: 10px;
			line-height: 24px;
			color: #444;
		}
	}
	</style>
	
	<body>
		<div class="logout-wrapper">
			<div class="user-info">
				<p class="name"></p>
				<img src="<%=StaticContentLoader.getStaticFilePath("/v2/components/images/user_2.png") %>" />
			</div>
			<div class="more-info">
				<p id="user-email"class="muted"></p>
				<a href="<%= IAMEncoder.encodeHTMLAttribute(Util.getCurrentLogoutURL(request, AccountsConstants.ACCOUNTS_SERVICE_NAME,"")) %>" class="err-btn"><%= Util.getI18NMsg(request,"IAM.SIGN.OUT")%></a> 
			</div>
		</div>
		<div class="container"> 
			<div class="zoho_logo"></div>
			<div class="error_img ip_block"></div>
			<div class="heading"><%= heading %></div>
			<div class="discrption">
				<%= description %>
				<p><%= refresh %></p>
				<button class="refresh_btn" onclick="location.reload();"><%= Util.getI18NMsg(request,"IAM.REFRESH_NOW")%></button>
				<% if(resetIPUrl !=null){%>
				<button class="whit_btn" onclick="switchto('<%=resetIPUrl%>');"><%= Util.getI18NMsg(request,"IAM.IP.RESET.ADDRESS")%></button>
				<% }%>
			</div>
		</div>
		<footer id="footer"> <%--No I18N--%>
			<%@ include file="../unauth/footer.jspf"%>
		</footer> <%--No I18N--%>
	</body>
	<script>
	
	function switchto(url){
		if(url.indexOf("http") != 0) { //Done for startsWith(Not supported in IE) Check
			var serverName = window.location.origin;
			if (!window.location.origin) {
				serverName = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
			}
			if(url.indexOf("/") != 0) {
				url = "/" + url;
			}
			url = serverName + url;
		}
		window.top.location.href=url;
	}
		function setFooterPosition(){
			var container = document.getElementsByClassName("container")[0];
			var top_value = window.innerHeight-60;
			if(container && (container.offsetHeight+container.offsetTop+30)<top_value){
				document.getElementById("footer").style.top = top_value+"px"; // No I18N
			}
			else{
				document.getElementById("footer").style.top = container && (container.offsetHeight+container.offsetTop+30)+"px"; // No I18N
			}
		}
		window.addEventListener("resize",function(){
			setFooterPosition();
		});
		window.addEventListener("load",function(){
			setFooterPosition();
		});
		function xhr() {
		    var xmlhttp;
		    if (window.XMLHttpRequest) {
				xmlhttp=new XMLHttpRequest();
		    } else if(window.ActiveXObject) {
				try {
				    xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
				}
				catch(e) {
				    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
		    }
		    return xmlhttp;
		}
		var objHTTP = xhr();
	   	objHTTP.open('GET', '/u/unauth/info', true);
		objHTTP.onreadystatechange=function() {
	    	if(objHTTP.readyState==4 && objHTTP.status === 200 ) {
	    		var info = objHTTP.responseText && JSON.parse(objHTTP.responseText);
	    		if(info && info.EMAIL_ID && info.DISPLAY_NAME){
			    	var logWrap = document.querySelector('.logout-wrapper'); // No I18N
			    	var userWrap = document.querySelector('.logout-wrapper .user-info'); // No I18N
			    	var moreWrap = document.querySelector('.logout-wrapper .more-info'); // No I18N
			    	var nameDom = userWrap.querySelector('p'); // No I18N
			    	nameDom.innerHTML = info.DISPLAY_NAME;
			    	moreWrap.querySelector('#user-email').innerHTML = info.EMAIL_ID; // No I18N
			    	logWrap.classList.add("show"); // No I18N
			    	userWrap.setAttribute('style','width:'+(nameDom.offsetWidth + 38)+'px;height:'+nameDom.offsetHeight+'px'); 
			    	logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 48)+'px;height:'+(userWrap.offsetHeight+16)+'px');
			    	logWrap.addEventListener('click', function(event) {
			    		event.stopPropagation();
			    		if(!event.target.classList.contains('err-btn')) {
			    			logWrap.classList.toggle('open'); // No I18N
			    			if(logWrap.classList.contains('open')) {
			    				nameDom.style.right = 'calc(50% - '+((nameDom.offsetWidth/2) + 24 )+'px)';  // No I18N
			    				var fullWidth = ((nameDom.offsetWidth + 24) > moreWrap.offsetWidth) ? (nameDom.offsetWidth + 24) : moreWrap.offsetWidth;
			    				userWrap.setAttribute('style','width:'+fullWidth+'px;height:124px');
			    				logWrap.setAttribute('style','width:'+fullWidth+'px;height:'+(userWrap.offsetHeight + moreWrap.offsetHeight + 8)+'px');
			    			} else {
			    				nameDom.style.right = '38px'; // No I18N
			    				userWrap.setAttribute('style','width:'+(nameDom.offsetWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
			    				logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 48)+'px;height:'+(userWrap.offsetHeight+16)+'px');
			    			}
			    		}
			    	});
			    	document.addEventListener('click', function(event) {
			    		if(!event.target.classList.contains('err-btn') && logWrap.classList.contains('open')) {
			    			logWrap.classList.toggle('open'); // No I18N
			    			nameDom.style.right = '38px'; // No I18N
			    			userWrap.setAttribute('style','width:'+(nameDom.offsetWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
			    			logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 48)+'px;height:'+(userWrap.offsetHeight+16)+'px');
			    		}
			    	})
	    		}
	    	}
		};
	   	objHTTP.send();
	</script>
</html>
