<html>
		<script type="text/javascript">
			function remoteGet() {
				<#if (remotelogouturls)?has_content>
					var remotelogouturlsarr = '${remotelogouturls}';
					if(remotelogouturlsarr !== null) {
						var remotelogouturls = JSON.parse(remotelogouturlsarr);
		                for (jsonIdx in remotelogouturls) {
		                    try {
		                        var img = new Image();
		                        var url = remotelogouturls[jsonIdx];
		                        img.src = url;
		                        <#if (serviceurl)?has_content>
		                        img.onerror = function() {
		                        if ((jsonIdx + 1) >= remotelogouturls.length) {
										window.location.href='${Encoder.encodeJavaScript(serviceurl)}';
									}
		                        }
			                    img.onload = function() {
									if ((jsonIdx + 1) >= remotelogouturls.length) {
										window.location.href='${Encoder.encodeJavaScript(serviceurl)}';
									}
								}
								</#if>
		                    } catch (e) { }
						}
					}
				</#if>
			}
			
			
			window.onload = function() {
				remoteGet();		
				<#if (ACTION)?has_content>
				document.getElementById("submitform").submit();
				</#if>
				<#if (idp)?has_content>
					document.getElementById("main_container").style.display = "block";
					document.getElementById("bg_one").style.display = "block";					
					document.getElementById("IDP_name").onclick=function(){
						window.open("${Encoder.encodeJavaScript(idpurl)}","_blank");						
					};
					var timeCount = 10;
					document.getElementById("countdown_value").innerHTML = timeCount;
					setInterval(function(){
						timeCount = timeCount-1;
						if(timeCount<1){
							serviceRedirect();
							return false;
						}
						document.getElementById("countdown_value").innerHTML = timeCount;
					}, 1000);
				</#if>
			}
		</script>
	<#if (idp)?has_content>
	<head>
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
		<style >
		body
		{
			margin:0px;
			padding:0px;
		}
		.bg_one {
		    display: block;
		    position: fixed;
		    top: 0px;
		    left: 0px;
		    height: 100%;
		    width: 100%;
		    background: #F6F6F6;
		    background-size: auto 100%;
		    z-index: -1;
		}
		.main {
		    display: block;
		    width: 620px;
		    background-color: #fff;
		    box-shadow: 0px 2px 30px #ccc6;
		    margin: auto;
		    position: relative;
		    z-index: 1;
		    margin-top: 8%;
		    overflow: hidden;
		    border-radius: 40px;
		}
		.inner-container {
		    padding: 40px 35px;
		    text-align: center;
		    margin-top: -40px;
		    background: white;
		    border-radius: 40px;
		    border: 2px solid #ECECEC;
		    box-sizing: border-box;
		}
		.IDP_logo {
		    width: 70px;
		    height: 70px;
		    background: #FFFFFF;
		    border:2px solid #F5F5F5;
		    display: inline-block;
	        box-sizing: border-box;
		    border-radius: 50%;
		}
		.inner-header {
		    padding: 30px;
		    background: linear-gradient(90deg,#1389E3,#0093E5);
		    padding-bottom: 70px;
		    position:relative;
		    z-index:-1;
		}
		.header_bg
		{
		    position: absolute;
		    z-index: -1;
		    width: 100%;
		    height: 100%;
		    left: 0px;
		    right: 0px;
		    top:0px;
		}
		.right_circle
		{
		    width: 194px;
		    height: 194px;
		    position: absolute;
		    background: #0000000d;
		    right: -59px;
		    bottom: 55px;
		    border-radius: 50%;
		}
		.center_semi_circle {
		    position: absolute;
		    width: 98px;
		    height: 98px;
		    right: 135px;
		    border-radius: 50%;
		    background: #0000000d;
		    top: 97px;
		}
		.small_circle {
		    position: absolute;
		    width: 48px;
		    height: 48px;
		    border-radius: 50%;
		    left: 123px;
		    background: #ffffff1a;
		    top: 67px;
		}
		.bg_rectangle {
			width: 250px;
		    height: 180px;
		    position: absolute;
		    background: #ffffff1a;
		    left: -118px;
		    top: -70px;
		    transform: rotate(-45deg);
		}
		.IDP_log_container
		{
		    display: inline-block;
		    overflow: auto;
		}
		.other_IDPs
		{
			display: inline-block;
		    float: left;
		    margin-left: -14px;
		}
		.zoho_icon
		{
			float:left;
		    position: relative;
		    z-index: 1;
		}
		.hide{
			display:none;
		}
		.user_name
		{
		    text-align: center;
		    font-weight: 500;
		    font-size: 20px;
		    margin-bottom: 10px;
		}
		.content_abt_IDP {
		    text-align: center;
		    font-size: 14px;
		    line-height: 24px;
		    margin-bottom: 20px;
	        letter-spacing: -.2;
		}
		.IDP_name
		{
	        font-weight: 500;
	        cursor:pointer;
	        color: #0091FF;
		    text-transform: capitalize;
		}
		.IDP_name_qq,.IDP_name_adp
		{
			text-transform: uppercase;
		}
		.logout_count {
		    text-align: center;
		    font-size: 13px;
		    letter-spacing: -0.19;
		    line-height: 24px;
		    margin-bottom:20px;
		}
		.redirect_btn {
		    background: #ECF7FF;
		    border: 1px solid #D9EFFF;
		    padding: 0px 15px;
		    cursor:pointer;
	        padding-right: 35px;
		    margin: auto;
		    line-height: 34px;
		    display: inline-block;
		    position: relative;
		    border-radius: 4px;
		    font-size: 14px;
		    font-weight: 500;
		    color: #0091FF;
		    box-sizing: border-box;
		    height: 36px;
		}
		.redirect_arrow {
		    display: inline-block;
		    transform: rotate(45deg);
		    font-size: 18px;
		    position: absolute;
		    right: 12px;
		    line-height: 34px;
		}
		.idp_inner_logo
		{
			width:30px;
			display:inline-block;
			height:30px;
			margin:18px;
		    background: url(${SCL.getStaticFilePath("/v2/components/images/Federated.png")}) no-repeat #FFF 30px 0px;
		    background-size: 100%;
		}
		.zoho_icon .idp_inner_logo
		{
		    width: 50px;
		    margin: 18px 8px;
		    background: url(${SCL.getStaticFilePath("/v2/components/images/zoho.png")}) no-repeat #FFF 0px 5px;
	        background-size: 100%;
		}
		.logo_google .idp_inner_logo{
			background-position: -0px -0px;
		}
		
		.logo_yahoo .idp_inner_logo{
		    background-position: 0px -176px;
		}
		
		.logo_facebook .idp_inner_logo{
			background-position: 0px -140px;
		}
		
		.logo_linkedin .idp_inner_logo{
			background-position: 0px -105px;
		}
		
		.logo_twitter .idp_inner_logo{
			background-position: 0px -245px;
		}
		
		.logo_weibo .idp_inner_logo{
			background-position: 0px -420px;
		}
		
		.logo_baidu .idp_inner_logo{
			background-position: 0px -350px;
		}
		
		.logo_qq .idp_inner_logo{
			background-position: 0px -315px;
		}
		
		.logo_douban .idp_inner_logo{
			background-position: 0px -384px;
		}
		
		.logo_azure .idp_inner_logo{
			background-position: 0px -70px;
		}
		
		.logo_intuit .idp_inner_logo{
			background-position: 0px -456px;
		}
		
		.logo_wechat .idp_inner_logo{
			background-position: 0px -280px;
		}
		
		.logo_slack .idp_inner_logo{
			background-position: 0px -210px;
		}
		
		.logo_apple .idp_inner_logo{
			background-position: 0px -35px;
		}
				
		.logo_adp .idp_inner_logo
		{
			background-position: 0px -490px
		}
		
		.logo_feishu .idp_inner_logo{
			background-position: 0px -524px;
		}
		#footer
		{
		    width: 100%;
		    height: 20px;
		    font-family: ZohoPuvi,sans-serif;
		    font-size: 14px;
		    color: #727272;
		   	position:absolute;
		    margin:20px 0px;
		    z-index: 1;
		}
		
		#footer div
		{
		    text-align:center;
		    font-size: 14px;
		}
		
		#footer div a
		{
		    text-decoration:none;
		    color: #727272;
		    font-size: 14px;
		}
		
		@media 
	    only screen and (-webkit-min-device-pixel-ratio: 2), 
	    only screen and ( min--moz-device-pixel-ratio: 2), 
	    only screen and ( -o-min-device-pixel-ratio: 2/1), 
	    only screen and ( min-device-pixel-ratio: 2), 
	    only screen and ( min-resolution: 192dpi), 
	    only screen and ( min-resolution: 2dppx) {
	    	.idp_inner_logo
			{
			    background: url(${SCL.getStaticFilePath("/v2/components/images/Federated2x.png")}) no-repeat #FFF 30px 0px;
			    background-size: 100%;
			}
			.zoho_icon .idp_inner_logo
			{
	
			    background: url(${SCL.getStaticFilePath("/v2/components/images/zoho.png")}) no-repeat #FFF 0px 5px;
		        background-size: 100%;
			}
    
   		}
   		@media only screen and (max-width : 435px)
		{
			.main
			{
			    width: 100%;
		        height: calc(100% - 60px);
			    margin-top: 0px;
    			border-radius: 0px;
    			box-shadow: unset;
			}
			.inner-container
			{
				height:100%;
			}
			.bg_one
			{
				background: white;
			}
			
		}
		</style>
		<script type="text/javascript">
			function serviceRedirect(){
					window.open("${Encoder.encodeJavaScript(serviceurl)}","_self");
			}
		</script>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
	</head>
	</#if>
	<body>
		<#if (idp)?has_content>
		<div class="bg_one hide" id="bg_one" style="display:none"></div>
		<div align="center" id="main_container" class="main hide container">
			<div class="inner-header">
				<div class="header_bg">
					<div class="bg_rectangle"></div>
					<div class="center_semi_circle"></div>
					<div class="small_circle"></div>
					<div class="right_circle"></div>
				</div>
				<div class="IDP_log_container">
					<div class="IDP_logo zoho_icon">
						<span class="idp_inner_logo"></span>
					</div>
					<div class="other_IDPs">
						<div class="IDP_logo logo_${idp?lower_case}">
							<span class="idp_inner_logo"></span>
						</div>
					</div>
				</div>
			</div>
			<div class="inner-container">
				<div class="user_name"><@i18n key="IAM.FEDERATE.LOGOUT.HI.USER" arg0="${Encoder.encodeHTML(username)}"/></div>		
				<div class="content_abt_IDP"><@i18n key="IAM.FEDERATE.LOGOUT.DESCRIPTION.WITH.IDP" arg0="${idp?lower_case}"/></div>
				<div class="logout_count"><@i18n key="IAM.FEDERATE.LOGOUT.DESCRIPTION.TIMER"/></div>
				<div class="redirect_btn" onclick="serviceRedirect()"><@i18n key="IAM.FEDERATE.LOGOUT.REDIRECT.NOW"/><span class="redirect_arrow">&#8599;</span></div>
			</div>
		</div>
	
		<#elseif (ACTION)?has_content>
			<form id="submitform" name="logoutpost" action="${Encoder.encodeHTMLAttribute(LOGOUT_URL)}" method="post" enctype="application/x-www-form-urlencoded" >
		        <textarea name="${Encoder.encodeHTMLAttribute(ACTION)}" id="req" style="display:none;">${Encoder.encodeHTML(SAML_MSG)}</textarea>
		        <#if (RELAY_STATE_URL)?has_content>
		        	<input name="RelayState" type="hidden" id="relay" value="${Encoder.encodeHTMLAttribute(RELAY_STATE_URL)}" />
		        </#if>
		    </form>
	    </#if>
		<#include "footer.tpl">
	</body>
	
</html>