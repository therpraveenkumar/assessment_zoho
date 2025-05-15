
<%--$Id$--%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.zoho.accounts.internal.util.AppConfiguration"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.SignupMode"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.OAuth2ProviderConstants"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.zoho.accounts.handler.GeoDCHandler"%>
<%@page import="com.zoho.accounts.AgentResourceProto.ZAID.ZUID.Email"%>
<%@page import="com.zoho.accounts.internal.OpenIDUtil"%>
<%@page import="com.zoho.accounts.internal.fs.FSConsumerUtil"%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.zoho.accounts.dcl.DCLUtil"%>
<%@page import="com.zoho.accounts.SystemResourceProto.DCLocation"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="com.zoho.accounts.phone.SMSUtil"%>
<%@page import="com.zoho.accounts.SystemResourceProto.ISDCode"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@ include file="../static/includes.jspf" %>
<html>
	<head>
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<script src="<%=StaticContentLoader.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")%>" type="text/javascript"></script><%-- NO OUTPUTENCODING --%>
		<script src="<%=StaticContentLoader.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")%>" type="text/javascript"></script><%-- NO OUTPUTENCODING --%>
		<script src="<%=StaticContentLoader.getStaticFilePath("/v2/components/js/common_unauth.js")%>" type="text/javascript"></script><%-- NO OUTPUTENCODING --%>
		<script src="<%=StaticContentLoader.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")%>" type="text/javascript"></script><%-- NO OUTPUTENCODING --%>
		<script src="<%=StaticContentLoader.getStaticFilePath("/v2/components/js/splitField.js")%>" type="text/javascript"></script><%-- NO OUTPUTENCODING --%>
		<link href="<%=StaticContentLoader.getStaticFilePath("/v2/components/css/zohoPuvi.css")%>" rel="stylesheet"type="text/css">
		
		<style >		
		@font-face {
		  font-family: 'Federated';
		  src:  url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")%>');
		  src:  url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")%>') format('embedded-opentype'),
		    	url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")%>') format('truetype'),
		    	url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")%>') format('woff'),
		    	url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")%>') format('svg');
		 		font-weight: normal;
		 		font-style: normal;
		 		font-display: block;
		}
		
		[class^="icon-"], [class*=" icon-"] {
		  /* use !important to prevent issues with browser extensions that change fonts */
		  font-family: 'Federated' !important;
		  speak: never;
		  font-style: normal;
		  font-weight: normal;
		  font-variant: normal;
		  text-transform: none;
		  line-height: 1;
		
		  /* Better Font Rendering =========== */
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;
		}

		.icon-link:before {
		  content: "\e90f";
		}
		.icon-Contacts:before {
		  content: "\e903";
		}
		.icon-Everyone:before {
		  content: "\e907";
		}
		.icon-Myself:before {
		  content: "\e904";
		}
		.icon-Zohousers:before {
		  content: "\e906";
		}
		.icon-info:before {
		  content: "\e90e";
		}
		.icon-new-zoho .path1:before {
   		  content: "\e95a";
    	  color: rgb(0, 0, 0);
		}
		.icon-new-zoho .path2:before {
   		  content: "\e95b";
   		  margin-left: -2.3466796875em;
    	  color: rgb(4, 152, 73);
		}
		.icon-new-zoho .path3:before {
 	      content: "\e95c";
   		  margin-left: -2.3466796875em;
    	  color: rgb(246, 177, 27);
		}
		.icon-new-zoho .path4:before {
		  content: "\e95d";
   		  margin-left: -2.3466796875em;
    	  color: rgb(226, 39, 40);
		}
		.icon-new-zoho .path5:before {
    	  content: "\e95e";
    	  margin-left: -2.3466796875em;
    	  color: rgb(34, 110, 179);
		}
		.icon-new-zoho .path6:before {
 		  content: "\e95f";
   		  margin-left: -2.3466796875em;
    	  color: rgb(34, 110, 179);
		}
		.icon-twitter:before {
  		  content: "\e959";
    	  color: #199df1;
		}
		.icon-adp:before {
    		content: "\e933";
 		    color: #ef221d;
		}
		.icon-apple:before {
 		   content: "\e934";
		}
		.icon-baidu:before {
    	   content: "\e935";
    	   color: #2319dc;
		}
		.icon-douban:before {
 		   content: "\e936";
  		   color: #29983a;
     	}
     	.icon-facebook:before {
 		   content: "\e937";
    	   color: #1177f2;
		}
		.icon-feishu .path1:before {
    		content: "\e938";
   			color: rgb(0, 214, 185);
		}
		.icon-feishu .path2:before {
    		content: "\e939";
  			margin-left: -1em;
    		color: rgb(51, 112, 255);
		}
		.icon-feishu .path3:before {
    		content: "\e93a";
    		margin-left: -1em;
    		color: rgb(19, 60, 154);
		}
		.icon-github:before {
    		content: "\e93b";
		}
		.icon-google .path1:before {
    		content: "\e93c";
    		color: rgb(66, 133, 244);
		}
		.icon-google .path2:before {
  		  content: "\e93d";
 		  margin-left: -1em;
    	  color: rgb(52, 168, 83);
		}
		.icon-google .path3:before {
    	  content: "\e93e";
          margin-left: -1em;
          color: rgb(251, 188, 5);
        }
        .icon-google .path4:before {
    	  content: "\e93f";
    	  margin-left: -1em;
          color: rgb(234, 67, 53);
 		}
 		.icon-intuit:before {
  		  content: "\e940";
 		  color: #1d6cff;
		}
		.icon-linkedin:before {
  		  content: "\e941";
  		  color: #0a66c2;
		}
		.icon-azure .path1:before {
    	  content: "\e942";
    	  color: rgb(107, 190, 0);
		}
		.icon-azure .path2:before {
   		  content: "\e943";
   		  margin-left: -1em;
  		  color: rgb(255, 62, 0);
		}
		.icon-azure .path3:before {
   		  content: "\e944";
 		  margin-left: -1em;
    	  color: rgb(0, 165, 246);
		}
		.icon-azure .path4:before {
    	  content: "\e945";
          margin-left: -1em;
          color: rgb(255, 183, 0);
		}
		.icon-qq .path1:before {
    	  content: "\e946";
    	  color: rgb(250, 171, 7);
		}
		.icon-qq .path2:before {
    	  content: "\e947";
          margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
		.icon-qq .path3:before {
    	  content: "\e948";
   		  margin-left: -1em;
    	  color: rgb(255, 255, 255);
		}
		.icon-qq .path4:before {
          content: "\e949";
          margin-left: -1em;
    	  color: rgb(250, 171, 7);
		}
		.icon-qq .path5:before {
    	  content: "\e94a";
    	  margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
		.icon-qq .path6:before {
 		  content: "\e94b";
    	  margin-left: -1em;
    	  color: rgb(255, 255, 255);
		}
		.icon-qq .path7:before {
    	  content: "\e94c";
   		  margin-left: -1em;
    	  color: rgb(235, 25, 35);
		}
		.icon-qq .path8:before {
    	  content: "\e94d";
    	  margin-left: -1em;
    	  color: rgb(235, 25, 35);
		}
		.icon-slack .path1:before {
  		  content: "\e94e";
    	  color: rgb(224, 30, 90);
		}
		.icon-slack .path2:before {
    	  content: "\e94f";
    	  margin-left: -1em;
    	  color: rgb(54, 197, 240);
		}
		.icon-slack .path3:before {
    	  content: "\e950";
    	  margin-left: -1em;
    	  color: rgb(46, 182, 125);
		}
		.icon-slack .path4:before {
  		  content: "\e951";
   		  margin-left: -1em;
  		  color: rgb(236, 178, 46);
		}
		.icon-wechat:before {
   		  content: "\e952";
		}
		.icon-yahoo:before {
    	  content: "\e958";
   		  color: #7e1fff;
		}
		.icon-weibo .path1:before {
   		  content: "\e953";
    	  color: rgb(255, 255, 255);
		}
		.icon-weibo .path2:before {
 	      content: "\e954";
          margin-left: -1em;
          color: rgb(230, 22, 45);
 		}
 		.icon-weibo .path3:before {
 		  content: "\e955";
    	  margin-left: -1em;
          color: rgb(255, 153, 51);
		}
		.icon-weibo .path4:before {
   		  content: "\e956";
    	  margin-left: -1em;
    	  color: rgb(255, 153, 51);
		}
		.icon-weibo .path5:before {
   		  content: "\e957";
 	      margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
				
		body
		{
			margin:0px;
			padding:0px;
		}
		b{
			font-weight:600;
		}
		.bg_one {
		    display: block;
		    position: fixed;
		    top: 0;
		    left: 0;
		    height: 100%;
		    width: 100%;
		    background: #F6F6F6;
		    background-size: auto 100%;
		    z-index: -1;
		}
		.main {
		    display: block;
		    width: 600px;
		    background-color: #fff;
		    box-shadow: 0px 2px 30px #ccc6;
		    margin: auto;
		    position: relative;
		    z-index: 1;
		    margin-top: 5%;
		    margin-bottom: 5%;
		    overflow: hidden;
		    border-radius: 40px;
		}
		.link_account_option
		{
		    position: relative;
			border: 2px solid #ECECEC;
			margin-top: 40px;
			padding: 20px;
			border-radius: 10px;
		}
		.inner-container {
		    padding: 40px 35px;
		    text-align: left;
		    margin-top: -40px;
		    background: white;
		    border-radius: 40px;
		    border: 2px solid #ECECEC;
		    box-sizing: border-box;
		}
		#footer {
		    width: 100%;
		    height: 20px;
		    font-family: 'ZohoPuvi', Georgia;
		    font-size: 14px;
		    color: #727272;
		    position: absolute;
		    margin: 20px 0px;
		    text-align: center;
		}
		#footer a{
			color:#727272;
		}
		.IDP_logo {
		    width: 70px;
		    height: 70px;
		    background: #FFFFFF;
		    border:2px solid #F5F5F5;
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
		    border-radius:50%;
		    background-color:white;
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
		
		.IDP_logo[class*=" icon-"]{
			display:inline-table;
		    font-size:30px;
		    padding-top:18px;
		}
		.IDP_logo.icon-new-zoho{
			font-size:24px;
			padding-top:20px;
		}
		.IDP_logo.icon-intuit{
			font-size:18px;
			padding-top: 24px;
    		padding-left: 8px;
		}
		.IDP_logo.icon-adp{
			font-size:18px;
			padding-top: 24px;
		}
		.IDP_logo.icon-wechat{
			-webkit-text-fill-color: transparent;
  			 background: linear-gradient(to right,#07df6e, #0bcc67);
    		-webkit-background-clip: text;
		}
		
		.user_name_text
		{
    		font-weight: 500;
		    font-size: 20px;
		    margin-bottom: 10px;
		}
		.desc_text
		{
			font-size:14px;
			line-height:24px;
		}
		.user_detail_form{
			padding-top: 30px;
		    display: flex;
		    justify-content: space-between;
		    flex-wrap: wrap;
		}
		.detail_box{
		    padding: 8px 10px;
		    border-radius: 4px;
		    border: 1px solid #C7C7C7;
		    width: 250px;
		    box-sizing: border-box;
		    margin-bottom: 30px;
		}
		.user_header{
		    font-size: 10px;
		    line-height: 14px;
		    margin-bottom: 4px;
		    font-weight: 500;
		    color: #00000080;
		}
		.user_detail
		{
			font-size:14px;
			line-height:20px;
		}
		.user_detail_input {
		    line-height: 20px;
		    border: none;
			-webkit-appearance: none;
		    appearance: none;
		    outline: none;
		    font-size: 14px;
		    height:20px;
		    padding: 0px;
		    width: 100%;
	        background: #fff;
            font-family: 'ZohoPuvi', Georgia;
		}
		.agree_checkbox
		{
		    cursor: pointer;
		    border: none;
		    outline: none;
		    width: 0px;
		    height: 0px;
		    position: relative;
		    margin: 2px 0px;
		    border-radius: 3px;
		    opacity:0;
		}
		.agree_checkbox+label:before
		{
		    content: "";
		    width: 16px;
		    display: inline-block;
		    height: 16px;
		    border: 2px solid #E9E9E9;
		    border-radius: 3px;
		    box-sizing: border-box;
		    background: #fff;
		    position: absolute;
			left: 0px;
			top: 2px;
		}
		.agree_checkbox+label:after
		{
		    content: "";
		    width: 5px;
		    display: inline-block;
		    height: 10px;
		    border: 2px solid #fff;
		    border-left: transparent;
		    border-top: transparent;
		    border-radius: 1px;
		    box-sizing: border-box;
		    position: absolute;
		    left: 5px;
		    top: 4px;
		    transform: rotate(45deg);
		}
		.agree_checkbox+label
		{
		    font-size: 14px;
		    letter-spacing: -0.3px;
		    line-height: 20px;
		    cursor: pointer;
		}
		.agree_checkbox+label a
		{
			text-decoration: none;
		    color: #1389E3;
		}
		.agree_checkbox:checked+label:before
		{
			background:#1389E3;
			border-color:#1389E3;
		}
		.check_container
		{
			position: relative;
		    display: grid;
		    grid-template-columns: 22px auto;
		}
		.tos-container
		{
			margin-bottom:20px;
		}
		.selected_div,.detail_box:focus-within
		{
			border: 1px solid #1389E3;
		}
		.selected_div .user_header,.detail_box:focus-within .user_header
		{
			color: #1389E3;
		}
		.err_box,.err_box:focus-within{
			border: 1px solid #EE3535;
		}
		.err_box .user_header,.err_box:focus-within .user_header
		{
			color: #EE3535;
		}
		.form_btn
		{
			padding: 0px 30px;
		    font-size: 13px;
		    color: #FFFFFF;
		    font-weight: 600;
		    background: #1389E3;
		    border: none;
		    outline: none;
		    border-radius: 5px;
		    margin-top: 30px;
		    cursor:pointer;
		    text-transform:uppercase;
		    box-sizing: border-box;
	        transition: all 0.3s ease-in-out;
		    height: 40px;
		}
		.gray_btn
		{
			color:#969696;
			background:#FFFFFF;
			border:2px solid #E7E7E7;
			margin-left:20px;
		}
		.form_btn:hover,.form_btn:focus
		{
			background:#0777CC;
		}
		.gray_btn:hover,.gray_btn:focus
		{
			border-color:#C7C7C7;
		    color: #777777;
		    background:#fff;
		}
		.or_container
		{
		    border: 2px solid #ECECEC;
		    border-radius: 10px;
		    padding: 20px;
		    position: relative;
		    margin-top: 30px;
		}
		.or_header
		{
			font-size: 14px;
		    color: #111111;
		    letter-spacing: -0.2px;
		    line-height: 24px;
		    font-weight: 500;
		}
		.or_description
		{
			font-size: 12px;
		    color: rgba(17,17,17,0.70);
		    letter-spacing: -0.2px;
		    line-height: 20px;
		    margin-top: 5px;
		}
		.or_tag
		{
			margin: auto;
		    padding: 0px 10px;
		    display: inline-block;
		    position: absolute;
		    background: #FFF;
		    top: -11px;
		    left: 0px;
		    right: 0px;
		    width: fit-content;
		    width: -moz-fit-content;
		    width: -webkit-fit-content;
		}
		.or_button {
		    background: #ECF7FF;
		    border: 1px solid #D9EFFF;
		    padding: 0px 20px;
		    cursor: pointer;
		    margin: auto;
		    line-height: 32px;
		    display: inline-block;
		    position: relative;
		    border-radius: 4px;
		    font-size: 12px;
		    font-weight: 500;
		    color: #0091FF;
		    box-sizing: border-box;
		    height: 34px;
		    margin-right: 0px;
		    margin-left: 30px;
		    white-space: nowrap;
		    text-transform: uppercase;
		}
		.hook {
		    width: 30px;
		    height: 30px;
		    border: 2px solid #ECECEC;
		    border-radius: 50%;
		    text-align: center;
		    line-height: 26px;
		    box-sizing: border-box;
		    position: absolute;
		    left: 0px;
		    right: 0px;
		    margin: auto;
		    top: 0px;
		    bottom: 0px;
		    background: #fff;
		    font-size: 12px;
		    color: #979797;
		}
		.separating_line {
		    width: 2px;
		    height: 100%;
		    display: block;
		    background: #ECECEC;
		    position: absolute;
		    top: 0px;
		    bottom: 0px;
		    left: 0px;
		    right: 0px;
		    margin: auto;
		}
		.zoho_acc
		{
			flex:1;
		}
		.IDP_account
		{
			flex:1;
			text-align:right;
		}
		.acc_header
		{
			font-size:14px;
			line-height:18px;
			color:#969696;
			font-weight: 500;
		}
		.acc_email {
			font-size: 14px;
		    margin-top: 5px;
		    line-height: 16px;
		    word-break: break-word;
		    max-width: calc(100% - 15px)
		}
		.zoho_acc .acc_email
		{
		    margin-right: 15px;
		}
		.IDP_account .acc_email
		{
		    margin-left: 15px;
		}
		.change_option
		{
			color: #0091FF;
			font-size: 14px;
			margin-top:5px;
			font-weight: 500;
			cursor:pointer;
			display: inline-block;
		}
		.info_btn
		{
			position: relative;
		    color: #969696;
		    margin-left: 5px;
		    top: 1px;
		}
		.info_btn:hover
		{
			color:#000000b3;
		}
		.info_btn:after
		{
			    
			    margin-left: 5px;
			    color: #969696;
			    cursor: pointer;		
		}
		.info_btn:before
		{
			cursor:pointer;
		}
		.info_detail{
		    position: absolute;
		    width: 200px;
		    text-align: left;
		    background: #fff;
		    padding: 10px;
		    box-shadow: 0px 0px 16px #DFDFDF;
		    border: 1px solid #E5E5E5;
		    font-size: 12px;
		    border-radius: 8px;
		    right: -14px;
		    top: 24px;
		    line-height:16px;
		    color:#000000cc;
	        font-family: 'ZohoPuvi', Georgia;
			display:none;
		}
		.info_btn:after
		{
		    content: "";
		    display: none;
		    position: absolute;
		    background: #fff;
		    width: 10px;
		    height: 10px;
		    top: 19px;
		    border: 1px solid #E5E5E5;
		    border-right: transparent;
		    border-bottom: transparent;
		    right: 2px;
		    transform: rotate(45deg);
		}
		.info_btn:hover .info_detail,.info_btn:hover:after
		{
			display:block;
		}
		.DC_note,.change_DC
		{
			font-size: 14px;
			color: rgba(0,0,0,0.80);
			letter-spacing: -0.2px;
			line-height: 20px;
		}	
		.DC_note
		{
			margin-bottom:5px;
		}
		.DC_note span,.info_detail span
		{
		    text-transform: capitalize;	
		}
		.profile-img{
		    width: 100px;
		    height: 100px;
		    margin-bottom: 20px;
		    border-radius: 50%;
		    overflow: hidden;
		    position:relative;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    z-index: 3;
		}
		.profile-img .pro_pic_blur
		{
			filter: blur(5px);
		    position: absolute;
		    height: 100%;
		    width: 100%;
		    background-size: 100% 100%;
		}
		.profile-img img
		{
		    height: 100%;
		    width: 100%;
		    margin: auto;
		    position: relative;
		    z-index: 1;
		    display: block;
		}
		.permission_icon {
		    margin-right: 5px;
		    font-size: 14px;
		    position: relative;
		    top: 1px;
		}
	
		.selection
		{
		    border-radius: 2px;
		    font-size:14px;
		}
		.select2-selection
		{
			display: block;
    		outline: none;
		    cursor: pointer;
		    line-height:20px;
		}
		.select2-dropdown {
		    display: inline-block;
		    border: 1px solid #E4E4E4;
		    box-shadow: 0 2px 4px 0 rgb(0 0 0 / 13%);
		    box-sizing: border-box;
		    border-radius: 6px;
		    background: #fff;
		    margin-top: 9px;
    		margin-left: -11px;
		    width: 250px !important;
		    overflow:hidden;
		}
		.select2-search__field {
		    height: 32px;
		    border: none;
		    outline: none;
		    border-radius: 3px;
		    width: 100%;
		    font-size: 13px;
		    padding: 10.5px 8px;
		    border: 1px solid #DFDFDF;
		}
		.select2-selection__arrow
		{
			float:right;	
		}
		.select2-results__option {
		    list-style-type: none;
		    height: auto;
		    box-sizing: border-box;
		    line-height: 16px;
		    font-family: 'ZohoPuvi', Georgia;
		    font-size: 13px;
		    overflow: hidden;
		    padding: 12px 18px;
		    word-break: break-word;
	        border-radius: 0px 0px 6px 6px;
		}
		.select2-results__options {
		    padding-left: 0px;
		    max-height: 200px;
		    overflow-y: auto;
		    overflow-x: hidden;
		    margin-top: 0px;
		    margin-bottom: 0px;
		    background: white;
	        list-style-type: none;
		    box-sizing: border-box;
		    font-size: 14px;
		    white-space: nowrap;
		}
		.select2-search {
		    display: block;
		    padding: 10px;
		    position: relative;
		}
		.select2-results__option--highlighted {
		    background: #00000008;
		    color: #000000;
		    cursor: pointer;
		}
		.select2-selection__arrow b{
			height: 0px;
		    width: 0px;
		    position: relative;
		    top: -5px;
		    border-radius: 1px;
		    display: inline-block;
		    margin-top: 6px;
		    border-left: 4px solid transparent;
		    border-right: 4px solid transparent;
		    border-top: 4px solid #666;
		}
		.select2-search--hide {
		    display: none;
		}
		.select2-container {
		    z-index: 2;
		    display: inline-block;
		    height:20px;
		}
		.select2-container--phonenumber_div .select2-selection__arrow b
		{
			top: 1px;
		    left: 5px;
		}
		.select2-container--phonenumber_div .select2-selection
		{
			margin-right:8px;
		}
		.select2-results__option .cc
		{
			float:right;
		}
		.select2-results__option .cn {
		    max-width: 135px;
		    white-space: pre-wrap;
		    display: inline-block;
		    margin-left: 10px;
		}
		.pic {
			width: 20px;
			height: 14px;
			background-size: 280px 252px;
			background-image: url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/Flags.png")%>");
			background-position: -180px -238px;
			float: left;
			margin-top: 1px;
		}
		.select2-container--photo_permission_theme
		{
			position:absolute;
			border-radius:12px;
			background:#fff;
			z-index: 3;
		}
		
		.user_detail_input .customOtp {
		    border: none;
		    outline: none;
		    background: transparent;
		    height: 100%;
		    font-size: 14px;
		    text-align: left;
		    width: 20px;
		    padding: 0px;
		}
		.customOtp::placeholder {
		  color:#0000001a;
		}
		
		.customOtp:-ms-input-placeholder {
		  color: #0000001a;
		}
		
		.customOtp::-ms-input-placeholder {
		  color: #0000001a;
		}
		.resend_text
		{
			font-size: 12px;
			cursor:pointer;
		    color: #0091FF;
		    font-weight: 500;
	        display: inline-block;
		}
		.resend_otp_blocked
		{
		    color: #00000099;
	        cursor: default;
		}
		#photo_permission+.select2-container--photo_permission_theme
		{	
		    width: 38px !important;
		    height: 24px;
		    top: 0px;
		    right: 0px;
		    z-index: 4;
		    box-shadow: 1px -1px 2px 0px #00000021;
		}
		#photo_permission+.select2-container--open
		{
			border-radius:12px 12px 0px 0px;
		}
		.select2-container--photo_permission_theme .select2-dropdown
		{
			width:auto !important;
		    margin-top: -1px;
	        margin-left: 0px;
	        overflow: hidden;
		    border-radius: 0px 0px 6px 6px;
		}
		.select2-container--photo_permission_theme .select2-selection--single
		{
			height:auto;
			outline:none;
		}
		.select2-container--photo_permission_theme .select2-selection__rendered
		{
		    padding: 4px 0px 4px 7px;
		    line-height: unset;
		    max-width: unset;
		    height: 24px;
		    box-sizing: border-box;
		    color: #666;
		    display: inline-block;
		}
		.select2-container--photo_permission_theme .select2-results__option
		{
		    list-style-type: none;
			padding: 10px 15px;
		    font-weight: 500;
		    font-size: 13px;
		    height:auto;
		    color:#444;
		}
		.select2-container--photo_permission_theme .select2-results__option--highlighted {
		    background: #00000008;
		    color: #000000;
		    cursor: pointer;
		}
		.select2-container--photo_permission_theme .select2-selection__arrow b{
		    height: 0px;
		    width: 0px;
		    position: relative;
		    top: 4px;
		    left: -6px;
		    border-radius: 1px;
		    display: inline-block;
		    margin-top: 6px;
		    border-left: 3px solid transparent;
		    border-right: 3px solid transparent;
		    border-top: 3px solid #666;
		}
		.select2-hidden-accessible {
		    visibility: hidden;
		    border: 0 !important;
		    clip: rect(0, 0, 0, 0) !important;
		    height: 0px !important;
		    margin: -1px !important;
		    overflow: hidden !important;
		    padding: 0 !important;
		    position: absolute !important;
		    display: none;
		}
		.flag_AF{background-position:0px 0px;}
		.flag_AL{background-position:-20px 0px;}
		.flag_DZ{background-position:-40px 0px;}
		.flag_AS{background-position:-60px 0px;}
		.flag_AD{background-position:-80px 0px;}
		.flag_AO{background-position:-100px 0px;}
		.flag_AI{background-position:-120px 0px;}
		.flag_AG{background-position:-140px 0px;}
		.flag_AR{background-position:-160px 0px;}
		.flag_AM{background-position:-180px 0px;}
		.flag_AW{background-position:-200px 0px;}
		.flag_AC{background-position:-220px 0px;}
		.flag_AU{background-position:-240px 0px;}
		.flag_AX{background-position:-260px 0px;}
		.flag_AT{background-position:0px -14px;}
		.flag_AZ{background-position:-20px -14px;}
		.flag_BS{background-position:-40px -14px;}
		.flag_BH{background-position:-60px -14px;}
		.flag_BD{background-position:-80px -14px;}
		.flag_BB{background-position:-100px -14px;}
		.flag_BY{background-position:-120px -14px;}
		.flag_BE{background-position:-140px -14px;}
		.flag_BZ{background-position:-160px -14px;}
		.flag_BJ{background-position:-180px -14px;}
		.flag_BM{background-position:-200px -14px;}
		.flag_BT{background-position:-220px -14px;}
		.flag_BO{background-position:-240px -14px;}
		.flag_BA{background-position:-260px -14px;}
		.flag_BW{background-position:0px -28px;}
		.flag_BR{background-position:-20px -28px;}
		.flag_VG{background-position:-40px -28px;}
		.flag_BN{background-position:-60px -28px;}
		.flag_BG{background-position:-80px -28px;}
		.flag_BF{background-position:-100px -28px;}
		.flag_BI{background-position:-120px -28px;}
		.flag_KH{background-position:-140px -28px;}
		.flag_CM{background-position:-160px -28px;}
		.flag_CA{background-position:-180px -28px;}
		.flag_CV{background-position:-200px -28px;}
		.flag_KY{background-position:-220px -28px;}
		.flag_CF{background-position:-240px -28px;}
		.flag_TD{background-position:-260px -28px;}
		.flag_CL{background-position:0px -42px;}
		.flag_CN{background-position:-20px -42px;}
		.flag_CO{background-position:-40px -42px;}
		.flag_KM{background-position:-60px -42px;}
		.flag_CG{background-position:-80px -42px;}
		.flag_CK{background-position:-100px -42px;}
		.flag_CR{background-position:-120px -42px;}
		.flag_CI{background-position:-140px -42px;}
		.flag_HR{background-position:-160px -42px;}
		.flag_CU{background-position:-180px -42px;}
		.flag_CW{background-position:-100px -224px;}
		.flag_CY{background-position:-200px -42px;}
		.flag_CZ{background-position:-220px -42px;}
		.flag_CD{background-position:-240px -42px;}
		.flag_DK{background-position:-260px -42px;}
		.flag_DG{background-position:0px -56px;}
		.flag_DJ{background-position:-20px -56px;}
		.flag_DM{background-position:-40px -56px;}
		.flag_DO{background-position:-60px -56px;}
		.flag_TL{background-position:-80px -56px;}
		.flag_EC{background-position:-100px -56px;}
		.flag_EG{background-position:-120px -56px;}
		.flag_SV{background-position:-140px -56px;}
		.flag_GQ{background-position:-160px -56px;}
		.flag_ER{background-position:-180px -56px;}
		.flag_EE{background-position:-200px -56px;}
		.flag_ET{background-position:-220px -56px;}
		.flag_FK{background-position:-240px -56px;}
		.flag_FO{background-position:-260px -56px;}
		.flag_FJ{background-position:0px -70px;}
		.flag_FI{background-position:-20px -70px;}
		.flag_FR{background-position:-40px -70px;}
		.flag_GF{background-position:-60px -70px;}
		.flag_PF{background-position:-80px -70px;}
		.flag_GA{background-position:-100px -70px;}
		.flag_GM{background-position:-120px -70px;}
		.flag_GE{background-position:-140px -70px;}
		.flag_DE{background-position:-160px -70px;}
		.flag_GH{background-position:-180px -70px;}
		.flag_GI{background-position:-200px -70px;}
		.flag_GR{background-position:-220px -70px;}
		.flag_GL{background-position:-240px -70px;}
		.flag_GD{background-position:-260px -70px;}
		.flag_GP{background-position:0px -84px;}
		.flag_GU{background-position:-20px -84px;}
		.flag_GT{background-position:-40px -84px;}
		.flag_GN{background-position:-60px -84px;}
		.flag_GW{background-position:-80px -84px;}
		.flag_GY{background-position:-100px -84px;}
		.flag_HT{background-position:-120px -84px;}
		.flag_HN{background-position:-140px -84px;}
		.flag_HK{background-position:-160px -84px;}
		.flag_HU{background-position:-180px -84px;}
		.flag_IS{background-position:-200px -84px;}
		.flag_IN{background-position:-220px -84px;}
		.flag_ID{background-position:-240px -84px;}
		.flag_IR{background-position:-260px -84px;}
		.flag_IQ{background-position:0px -98px;}
		.flag_IE{background-position:-20px -98px;}
		.flag_IL{background-position:-40px -98px;}
		.flag_IT{background-position:-60px -98px;}
		.flag_JM{background-position:-80px -98px;}
		.flag_JP{background-position:-100px -98px;}
		.flag_JO{background-position:-120px -98px;}
		.flag_KZ{background-position:-140px -98px;}
		.flag_KE{background-position:-160px -98px;}
		.flag_KI{background-position:-180px -98px;}
		.flag_KW{background-position:-200px -98px;}
		.flag_KG{background-position:-220px -98px;}
		.flag_LA{background-position:-240px -98px;}
		.flag_LV{background-position:-260px -98px;}
		.flag_LB{background-position:0px -112px;}
		.flag_LS{background-position:-20px -112px;}
		.flag_LR{background-position:-40px -112px;}
		.flag_LY{background-position:-60px -112px;}
		.flag_LI{background-position:-80px -112px;}
		.flag_LT{background-position:-100px -112px;}
		.flag_LU{background-position:-120px -112px;}
		.flag_MO{background-position:-140px -112px;}
		.flag_MK{background-position:-160px -112px;}
		.flag_MG{background-position:-180px -112px;}
		.flag_MW{background-position:-200px -112px;}
		.flag_MY{background-position:-220px -112px;}
		.flag_MV{background-position:-240px -112px;}
		.flag_ML{background-position:-260px -112px;}
		.flag_MT{background-position:0px -126px;}
		.flag_MH{background-position:-20px -126px;}
		.flag_MQ{background-position:-40px -126px;}
		.flag_MR{background-position:-60px -126px;}
		.flag_MU{background-position:-80px -126px;}
		.flag_MX{background-position:-100px -126px;}
		.flag_FM{background-position:-120px -126px;}
		.flag_MD{background-position:-140px -126px;}
		.flag_MC{background-position:-160px -126px;}
		.flag_MN{background-position:-180px -126px;}
		.flag_ME{background-position:-200px -126px;}
		.flag_MS{background-position:-220px -126px;}
		.flag_MA{background-position:-240px -126px;}
		.flag_MZ{background-position:-260px -126px;}
		.flag_MM{background-position:0px -140px;}
		.flag_NA{background-position:-20px -140px;}
		.flag_NR{background-position:-40px -140px;}
		.flag_NP{background-position:-60px -140px;}
		.flag_NL{background-position:-80px -140px;}
		.flag_AN{background-position:-100px -140px;}
		.flag_NC{background-position:-120px -140px;}
		.flag_NZ{background-position:-140px -140px;}
		.flag_NI{background-position:-160px -140px;}
		.flag_NE{background-position:-180px -140px;}
		.flag_NG{background-position:-200px -140px;}
		.flag_NU{background-position:-220px -140px;}
		.flag_KP{background-position:-240px -140px;}
		.flag_MP{background-position:-260px -140px;}
		.flag_NO{background-position:0px -154px;}
		.flag_OM{background-position:-20px -154px;}
		.flag_PK{background-position:-40px -154px;}
		.flag_PW{background-position:-60px -154px;}
		.flag_PS{background-position:-80px -154px;}
		.flag_PA{background-position:-100px -154px;}
		.flag_PG{background-position:-120px -154px;}
		.flag_PY{background-position:-140px -154px;}
		.flag_PE{background-position:-160px -154px;}
		.flag_PH{background-position:-180px -154px;}
		.flag_PL{background-position:-200px -154px;}
		.flag_PT{background-position:-220px -154px;}
		.flag_PR{background-position:-240px -154px;}
		.flag_QA{background-position:-260px -154px;}
		.flag_RE{background-position:0px -168px;}
		.flag_RO{background-position:-20px -168px;}
		.flag_RU{background-position:-40px -168px;}
		.flag_RW{background-position:-60px -168px;}
		.flag_SH{background-position:-80px -168px;}
		.flag_KN{background-position:-100px -168px;}
		.flag_LC{background-position:-120px -168px;}
		.flag_PM{background-position:-140px -168px;}
		.flag_VC{background-position:-160px -168px;}
		.flag_WS{background-position:-180px -168px;}
		.flag_SM{background-position:-200px -168px;}
		.flag_ST{background-position:-220px -168px;}
		.flag_SA{background-position:-240px -168px;}
		.flag_SN{background-position:-260px -168px;}
		.flag_RS{background-position:0px -182px;}
		.flag_SC{background-position:-20px -182px;}
		.flag_SL{background-position:-40px -182px;}
		.flag_SG{background-position:-60px -182px;}
		.flag_SK{background-position:-80px -182px;}
		.flag_SI{background-position:-100px -182px;}
		.flag_SB{background-position:-120px -182px;}
		.flag_SO{background-position:-140px -182px;}
		.flag_ZA{background-position:-160px -182px;}
		.flag_KR{background-position:-180px -182px;}
		.flag_SS{background-position:-120px -224px;;}
		.flag_ES{background-position:-200px -182px;}
		.flag_LK{background-position:-220px -182px;}
		.flag_SD{background-position:-240px -182px;}
		.flag_SR{background-position:-260px -182px;}
		.flag_SZ{background-position:0px -196px;}
		.flag_SE{background-position:-20px -196px;}
		.flag_CH{background-position:-40px -196px;}
		.flag_SY{background-position:-60px -196px;}
		.flag_TW{background-position:-80px -196px;}
		.flag_TJ{background-position:-100px -196px;}
		.flag_TZ{background-position:-120px -196px;}
		.flag_TH{background-position:-140px -196px;}
		.flag_TG{background-position:-160px -196px;}
		.flag_TK{background-position:-180px -196px;}
		.flag_TO{background-position:-200px -196px;}
		.flag_TT{background-position:-220px -196px;}
		.flag_TN{background-position:-240px -196px;}
		.flag_TR{background-position:-260px -196px;}
		.flag_TM{background-position:0px -210px;}
		.flag_TC{background-position:-20px -210px;}
		.flag_TV{background-position:-40px -210px;}
		.flag_UG{background-position:-60px -210px;}
		.flag_UA{background-position:-80px -210px;}
		.flag_AE{background-position:-100px -210px;}
		.flag_GB{background-position:-120px -210px;}
		.flag_US,.flag_UM{background-position:-140px -210px;}
		.flag_UY{background-position:-160px -210px;}
		.flag_VI{background-position:-180px -210px;}
		.flag_UZ{background-position:-200px -210px;}
		.flag_VU{background-position:-220px -210px;}
		.flag_VA{background-position:-240px -210px;}
		.flag_VE{background-position:-260px -210px;}
		.flag_VN{background-position:0px -224px;}
		.flag_WF{background-position:-20px -224px;}
		.flag_YE{background-position:-40px -224px;}
		.flag_ZM{background-position:-60px -224px;}
		.flag_ZW{background-position:-80px -224px;}
		.flag_AQ{background-position:-160px -224px;}
		.flag_BV,.flag_SJ{background-position:-180px -224px;}
		.flag_IO{background-position:-200px -224px;}
		.flag_CX{background-position:-220px -224px;}
		.flag_CC{background-position:-240px -224px;}
		.flag_TF{background-position:-260px -224px;}
		.flag_GG{background-position:0px -238px;}
		.flag_HM{background-position:-20px -238px;}
		.flag_JE{background-position:-40px -238px;}
		.flag_YT{background-position:-60px -238px;}
		.flag_NF{background-position:-80px -238px;}
		.flag_PN{background-position:-100px -238px;}
		.flag_GS{background-position:-120px -238px;}
		.flag_EH{background-position:-140px -238px;}
		.flag_IM{background-position:-160px -238px;}
		.photo_permission_option
		{
			position: relative;
		    display: inline-block;
		}
		.flex_link_container
		{
			display:flex;
			flex-wrap:nowrap;
		}
		.container_blur
		{
			display: block;
			position: absolute;
			left: 0px;
			right: 0px;
			bottom: 0px;
			top: 0px;
			height: 100%;
			width: 100%;
			background: #fff;
			z-index: 5;
			opacity: 0.9;
		}
		@-webkit-keyframes spin
		{
			0% {-webkit-transform: rotate(0deg);}
			100% {-webkit-transform:rotate(360deg);}
		}
		@keyframes spin
		{
			0% {transform: rotate(0deg);}
			100% {transform:rotate(360deg);}
		}
		.loading_round
		{
			border: 3px solid transparent;
		    border-radius: 50%;
		    border-top: 3px solid #1389E3;
		    border-right: 3px solid #1389E3;
		    border-bottom: 3px solid #1389E3;
		    width: 26px;
		    height: 26px;
		    -webkit-animation: spin 1s linear infinite;
		    animation: spin 1s linear infinite;
		    z-index: 4;
		    position: absolute;
		    top: 0px;
		    left: 0px;
		    bottom: 0px;
		    right: 0px;
		    margin: auto;
		    box-sizing: border-box;
		}
		.user_name_desc_text
		{
			font-size:14px;
			margin-top:10px;
			line-height:24px;
		}
		.country_details
		{
		    width: 100%;
		    display: flex;
		    justify-content: space-between;
		    flex-wrap: wrap;
		}
		.country_300_width
		{
			width:300px !important;
		}
		.tos_error
		{
		    color: #EE3535;
			font-size: 14px;
			margin-top: 10px;
			display: none;
		}
		
		.btn_loading:after {
		    content: "";
		    border: 2px solid white;
		    border-top: 2px solid transparent;
		    border-radius: 50%;
		    width: 12px;
		    display: inline-block;
		    height: 12px;
		    background: transparent;
		    position: relative;
		    left: 5px;
		    top: 1px;
		    box-sizing: border-box;
		    animation: spin 1s linear infinite;
		}
		
		.error_msg
		{
			cursor: pointer;
		    display: none;
		    position: fixed;
		    font-size: 14px;
		    max-width: 400px;
		    box-sizing: border-box;
		    z-index: 100;
		    background-color: #fff;
		    border-radius: 25px;
		    margin: auto;
		    margin-top: 10px;
		    box-shadow: 0px 0px 10px 0px #ccc;
		    right: 0px;
		    left: 0px;
		    top: -100px;
		    transition: all .2s ease-in-out;
		    width: fit-content;
    		width: -moz-fit-content;
		    width: -webkit-fit-content;
		}
		.err_icon_aligner {
		    display: table-cell;
		    width: 56px;
		    vertical-align: middle;
		}
		.error_msg_cross {
		    display: inline-block;
		    float: right;
		    height: 36px;
		    width: 36px;
		    margin: 7px 10px;
		    background-color: #ff5555;
		    border-radius: 50%;
		    box-sizing: border-box;
		    padding: 11px;
		    position: relative;
		}
		.crossline1 {
		    display: inline-block;
		    position: relative;
		    height: 14px;
		    width: 2px;
		    background-color: #fff;
		    margin: auto;
		    transform: rotate(-45deg);
		    left: 6px;
		}
		.crossline2 {
		    display: inline-block;
		    position: relative;
		    height: 14px;
		    width: 2px;
		    background-color: #fff;
		    margin: auto;
		    transform: rotate(45deg);
		    left: 4px;
		}
		.error_msg_text {
		    font-size: 13px;
		    line-height: 18px;
		    display: table-cell;
		    float: left;
		    padding: 16px 20px 16px 0px;
		    width: 100%;
		    box-sizing: border-box;
		}
		.sucess_msg .error_msg_cross {
			background-color: #20ba51;
		}
		.sucess_msg .tick {
			display: inline-block;
			position: relative;
			height: 5px;
			width: 11px;
			background-color: transparent;
			border-left: 2px solid #fff;
			border-bottom: 2px solid #fff;
			margin: auto;
			transform: rotate(-45deg);
			top:2px;
		}
		.mobile_country_select .select2-container
		{
			position:absolute;
		}
		#user_mobile
		{
			text-indent:50px;
			transition: all 0.3s ease-in-out;
		}
		.mobile_country_select .select2-container
		{
			position:absolute;
		    background: #fff;
		}
		.mobile_country_select
		{
			position:relative;	
		}
		.otp_sent:before
		{
		    content: "";
		    width: 10px;
		    box-sizing: border-box;
		    margin-right: 5px;
		    border: 2px solid #0091FF;
		    height: 5px;
		    border-top: 2px solid transparent;
		    border-right: 2px solid transparent;
		    transform: rotate(-50deg);
		    position: relative;
		    top: -3px;
		    display: inline-block;
		}
		.otp_senting:before {
		    width: 10px;
		    height: 10px;
		    top: 0px;
		    border-radius: 10px;
		    border-top: 2px solid #0091FF;
		    -webkit-animation: spin 1s linear infinite;
		    animation: spin 1s linear infinite;
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
			    background: url(<%=StaticContentLoader.getStaticFilePath("/v2/components/images/Federated2x.png")%>) no-repeat #FFF 30px 0px;
			    background-size: 100%;
			}
			.zoho_icon .idp_inner_logo
			{
	
			    background: url(<%=StaticContentLoader.getStaticFilePath("/v2/components/images/zoho.png")%>) no-repeat #FFF 0px 5px;
		        background-size: 100%;
			}
    
   		}
   		@media only screen and (max-width : 435px)
		{
			.main
			{
			    width: 100%;
		        height: 100%;
			    margin-top: 0px;
			    margin-bottom: 0px;
    			border-radius: 0px;
			}
			.inner-container
			{
			    height: calc(100% - 130px);
			    overflow: auto;
			    border-radius: 30px 30px 0px 0px;
			    padding: 30px;
			}
			.detail_box,.form_btn
			{
				width:100% !important;
			}
			.gray_btn
			{
				margin-left:0px;
			}
			.IDP_account,.zoho_acc
			{
			    width: 100%;
			    flex:unset;
			}
			.separating_line
			{
				width: 100%;
			    height: 2px;
			}
			.IDP_account
			{
				margin-top:50px;
			    text-align: left;
			}
			.associate_account_detail,.flex_link_container
			{
				flex-wrap:wrap;
			}
			.or_button
			{
				margin-top: 20px;
			    margin-left: 0px;
			}
			.country_details .user_header:after{
			    content: "";
			    display: inline-block;
			    width: 0px;
			    height: 0px;
			    border-right: 3px solid transparent;
			    border-left: 3px solid transparent;
			    border-top: 3.5px solid #666;
			    float: right;
			    position: relative;
			    top: 18px;
			}
			.zoho_acc .acc_email,.IDP_account .acc_email
			{
			    margin-right: 0px;
			    margin-left: 0px;
			}
			.select2-container--phonenumber_div
			{
				width:100%;
			}
			.select2-container--phonenumber_div .select2-dropdown
			{
				width: calc(100% - 64px) !important;
			}
			.info_detail
			{
			    left: 0px;
			    transform: translate(-60%, 0px);
				right:0px;
			}
		}
		</style>
		<title><%=Util.getI18NMsg(request,"IAM.ZOHO.ACCOUNTS")%></title>
		<script>
			var state_data = {};
		<%
			String servicename = (String) request.getAttribute("servicename");
			String emailId = (String) request.getAttribute(FSConsumerUtil.OAUTH_EMAIL_ID);
			String signupDefaultMode = AppConfiguration.getConfiguration(servicename, "federated.signup.mode", null); // No I18n
			signupDefaultMode = Util.isValid(signupDefaultMode) ? signupDefaultMode : AccountsConfiguration.FEDERATED_SIGNUP_ENABLED_MODE.toStringValue(); 
			SignupMode signupMode = SignupMode.getEnum(signupDefaultMode);
			if (signupMode == null || !signupMode.isFederatedMode) { // Taking default mode, If any invalid mode was configured
				signupMode = SignupMode.SIGNUP_WITHOUT_PASSWORD_USING_EMAIL;
			}
			if (!IAMUtil.isValidEmailId(emailId) && signupMode.isEmailRequired && !signupMode.isOTPRequired) {
				// Bugbounty issue https://bugbounty.zoho.com/bb/#/bug/101000005457293
				// Adding OpenId to an unverified email account leads to account takeover. So verifying email via OTP
				signupMode = SignupMode.SIGNUP_WITH_EMAIL_OTP;
			}
			Boolean isEmailRequired = signupMode.isEmailRequired; 
			Boolean isMobileRequired = signupMode.isMobileRequired; 
			Boolean isOTPRequired = signupMode.isOTPRequired; 
			Boolean isRecoveryRequired = signupMode.isRecoveryRequired; 
			Boolean isAssociate = request.getAttribute("isAssociateAction") == null ? false : true;
			String termsOfServiceUrl = null;
			String privacyPolicyUrl = null;
			String redirectURL = null;
			String userEmail = null;
			String federatedID = null;
			String name = (String) request.getAttribute(FSConsumerUtil.OAUTH_NAME);
			String IDP_name = (String) request.getAttribute(FSConsumerUtil.OAUTH_PROVIDER);
		    String contextpath = request.getContextPath();
			Boolean hasAccount = false;
			Boolean isMobile = Util.isMobileUserAgent(request);
			Boolean isNameFieldOptional = IDP_name.equals(OAuth2ProviderConstants.APPLE.name());
			String default_country=Util.getCountryCodeFromRequestUsingIP(request);
			List<ISDCode> isdCodes = SMSUtil.getAllowedISDCodes();
			if(isdCodes == null || isdCodes.isEmpty()) {
				isdCodes = new ArrayList<ISDCode>();
				ISDCode defaultISD = ISDCode.newBuilder().setCountryCode("US").setCountryName("United States").setNewsletterSubscriptionMode(0).build(); //No I18N
				isdCodes.add(defaultISD);
			}
			if(name == null) {
				name = "";
			}
			if(!isAssociate){
			    termsOfServiceUrl = Util.getTermsOfServiceURL(request, servicename);
			    privacyPolicyUrl = Util.getPrivacyURL(request, servicename);
				HashMap<String, List<String>> countryStates = Util.getCountryVsStateList();
		
				if (countryStates != null && !countryStates.isEmpty()) {
					Iterator<String> stateCountries = countryStates.keySet().iterator();
					while (stateCountries.hasNext()) {
						String stateCountry = stateCountries.next();
						StringBuffer stateOptions = new StringBuffer();
						for (String state : countryStates.get(stateCountry)) {
							stateOptions.append("<option value=\"").append(state).append("\">").append(state).append("</option>");
						}
						%>
						state_data["<%=stateCountry%>"]='<%=stateOptions.toString()%>';
						<%
					}
				}
				redirectURL = FSConsumerUtil.constructSignInURLFromReq(request, null);
				hasAccount = request.getAttribute("userExist") != null && (Boolean) request.getAttribute("userExist");
			}
			else{
				userEmail = (String) request.getAttribute("userEmailID");
				federatedID = (String) request.getAttribute("userFederatedID");
			}
			%>
		</script>
	</head>

	<body>
		<div class="error_msg " id="new_notification" onclick="Hide_Main_Notification()">
			<div style="display:table;width: 100%;">
				<div class="err_icon_aligner">
					<div class="error_msg_cross">
					</div>
				</div>
				<div class="error_msg_text"> 
					<span id="succ_or_err"></span>
					<span id="succ_or_err_msg">&nbsp;</span>
				</div>
			</div>
		</div>
		<div class="bg_one" id="bg_one"></div>
		<div align="center" id="main_container" class="main container">
			<div class="container_blur">
				<div class="loading_round"></div>
			</div>
			<div class="inner-header">
				<div class="header_bg">
					<div class="bg_rectangle"></div>
					<div class="center_semi_circle"></div>
					<div class="small_circle"></div>
					<div class="right_circle"></div>
				</div>
				<div class="IDP_log_container">
					<div class="IDP_logo zoho_icon icon-new-zoho">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
							<span class="path4"></span>
							<span class="path5"></span>
							<span class="path6"></span>
					</div>
					<div class="other_IDPs">
						<div class="IDP_logo icon-<%=IDP_name.toLowerCase()%>">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
							<span class="path4"></span>
							<span class="path5"></span>
							<span class="path6"></span>
							<span class="path7"></span>
							<span class="path8"></span>
						</div>
					</div>
				</div>
			</div>
			<div class="inner-container">
				<%if(isAssociate){%>
				<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.ACCOUNTS.TITLE")%></div>
				<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.ACCOUNTS.DESCRIPTION",IDP_name.toLowerCase())%></div>
				<div class="or_container">
					<div class="show_linking_accounts">
						<span class="separating_line"></span>
						<div class="hook icon-link"></div>
						<div class="associate_account_detail" style="display:flex">
							<div class="zoho_acc">
								<div class="acc_header"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ASSOCIATE.ACCOUNT.TITLE")%></div>
								<div class="acc_email"><%=userEmail != null ? IAMEncoder.encodeHTML(userEmail) : ""%></div>	<%--No I18N--%>
							</div>
							<div class="IDP_account">
								<div class="acc_header"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ASSOCIATE.IDP.ACCOUNT.TITLE",IDP_name.toLowerCase())%></div>
								<%
								String fedID = federatedID != null ? IAMEncoder.encodeHTML(federatedID) : "";
								if(IAMUtil.isValidEmailId(federatedID)){
								%>
									<div class="acc_email"><%=fedID%></div>	<%--No I18N--%>
								<%}else{ %>
									<div style="position:relative" class="acc_email">ID - <%=fedID%><span class="info_btn icon-info"><span class="info_detail"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.IDP.ID.INFO",IDP_name.toLowerCase())%></span></span></div>	<%--No I18N--%>
								<%} %>
								
							</div>
						</div>
					</div>
				</div>
				<div class="button_container">
					<button id="associateFormAddBtn" class="form_btn" onclick="associateUser()"><%=Util.getI18NMsg(request,"IAM.CONTINUE")%></button>
					<button class="form_btn gray_btn" onclick="cancelAssociateOption()"><%=Util.getI18NMsg(request,"IAM.CANCEL")%></button>
				</div>
				<%}
				else if(hasAccount){%>
						<div>
							<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.GROUP.INVITATION.ACCOUNT.EXISTS.IN.ANOTHER.DC.HEADER")%></div>
							<div class="user_name_desc_text"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.OPTION.DESC",IAMEncoder.encodeHTML(emailId),IDP_name.toLowerCase())%></div>
						</div>
						<div class="button_container">
							<button class="form_btn" onclick="iamMoveToSignin('<%=redirectURL%>','<%=emailId%>')"><%=Util.getI18NMsg(request,"IAM.CONTINUE")%></button>
							<button class="form_btn gray_btn" onclick="cancelFederateFlow()"><%=Util.getI18NMsg(request,"IAM.CANCEL")%></button>
						</div>
				<%}
				else{ %>
				<div class="federated_signup_form">
				<form onsubmit="javascript:return false;" novalidate>
				<div class="photo_permission_option">
					<div class="profile-img" id="profile-pic">
	   					<div class="pro_pic_blur"></div>
	   					<img src="<%=StaticContentLoader.getStaticFilePath("/v2/components/images/user_2.png")%>" width="100%" height="100%" title="" alt="" onerror="handleProPicError()"/> <%-- NO OUTPUTENCODING --%>
	   				</div>
	   				<select id="photo_permission" style="display: none">
   						<option value="1" id="Zohousers"><%=I18NUtil.getMessage("IAM.PHOTO.PERMISSION.ZOHO_USERS")%></option>
   						<option value="4" id="Contacts"><%=I18NUtil.getMessage("IAM.PHOTO.PERMISSION.CHAT_CONTACTS")%></option>
   						<option value="3" id="Everyone"><%=I18NUtil.getMessage("IAM.PHOTO.PERMISSION.EVERYONE")%></option>
   						<option value="0" id="Myself" selected><%=I18NUtil.getMessage("IAM.PHOTO.PERMISSION.ONLY_MYSELF")%></option>
   					</select>
   				</div> 

				<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.CREATE.WELCOME",IAMEncoder.encodeHTML(name))%></div>
				<%if(!IAMUtil.isValidEmailId(emailId)){%>
				<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.PAGE.DESC")%></div>	
				<%}else{ %>
				<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.PAGE.EMAIL.DESC",IAMEncoder.encodeHTML(emailId))%></div>
				<%} %>
				<div class="user_detail_form">
				<%if(!isNameFieldOptional){%>
					<div class="detail_box">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.GENERAL.FIRSTNAME")%></div>
						<input type="text" id="user_first_name" maxlength="100" class="user_detail_input" placeholder="<%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.PLACEHOLDER.FIRSTNAME")%>" value="<%=IAMEncoder.encodeHTML((String)(request.getAttribute(FSConsumerUtil.OAUTH_FIRST_NAME) != null ? request.getAttribute(FSConsumerUtil.OAUTH_FIRST_NAME) : ""))%>"/>
					</div>
					<div class="detail_box">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.GENERAL.LASTNAME")%></div>
						<input type="text" id="user_last_name" maxlength="100" class="user_detail_input" placeholder="<%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.PLACEHOLDER.LASTNAME")%>" value="<%=IAMEncoder.encodeHTML((String)(request.getAttribute(FSConsumerUtil.OAUTH_LAST_NAME) != null ? request.getAttribute(FSConsumerUtil.OAUTH_LAST_NAME) : ""))%>" />
					</div>
				<%}
				if(!IAMUtil.isValidEmailId(emailId) && isEmailRequired && !isMobileRequired){%>
					<div class="detail_box" style="">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.EMAIL.ADDRESS")%></div>
						<input type="text" id="user_email_id" class="user_detail_input" placeholder="<%=Util.getI18NMsg(request, "IAM.USER.ENTER.EMAIL.PLACEHOLDER")%>"/>
					</div>
				<%} 
				if((isMobileRequired && !isEmailRequired) || isRecoveryRequired || (isMobileRequired && isEmailRequired && !IAMUtil.isValidEmailId(emailId))){ %>
					<div class="detail_box mobile_country_select">
					<%if(isEmailRequired && !isRecoveryRequired && !IAMUtil.isValidEmailId(emailId)){%>
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.EMAIL.ADDRESS.OR.MOBILE")%></div>						
					<%}else{%>
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.MOBILE.NUMBER")%></div>	
					<%}%>
						<select id="user_mobile_country" onchange="" class="user_detail_input">
						<% 
						for(ISDCode isdCode : isdCodes) {
							if(isdCode == null) {
								continue;
							}
						%>
							<option data-num="<%="+"+isdCode.getDialingCode() %>" value="<%=isdCode.getCountryCode()%>" <%if(isdCode.getCountryCode().equals(default_country)) {%> selected <%} %>><%=isdCode.getCountryName()+" (+" +isdCode.getDialingCode()+ ")"%></option><%-- NO OUTPUTENCODING --%>
						<%} %>
						</select>
						<input type="text" id="user_mobile" maxlength="15" <%if(isEmailRequired && !isRecoveryRequired && !IAMUtil.isValidEmailId(emailId)){%>oninput="checkEmailOrPhone(this)"<%}else{%>oninput="this.value = this.value.replace(/[^\d]+/g,'')"<%}%> class="user_detail_input" value=""/>
					</div>			
				<%}%>
					<div class="country_details">
					<div class="detail_box country_select_container" style="width:300px">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.COUNTRY")%></div>
						<select id="user_country" onchange="setStateData()" class="user_detail_input">
						<%												
							for(ISDCode isdCode : isdCodes) {
								if(isdCode == null) {
									continue;
								}
						%>
							<option value="<%=isdCode.getCountryCode()%>" newsletter_mode="<%=isdCode.getNewsletterSubscriptionMode()%>" <%if(isdCode.getCountryCode().equals(default_country)) {%> selected <%} %>newsletter_mode="<%=isdCode.getNewsletterSubscriptionMode()%>"><%=isdCode.getCountryName()%></option><%-- NO OUTPUTENCODING --%>
						<%
							}
						%>
						</select>
					</div>
					<div class="detail_box" style="display:none" id="state_container">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.GDPR.DPA.ADDRESS.STATE")%></div>
						<select id="state_list" class="user_detail_input">
							<option value="" disabled selected><%=Util.getI18NMsg(request, "IAM.US.STATE.SELECT")%></option>
						</select>
					</div>
					</div>
				</div>
				<%
				boolean hideDC = Boolean.TRUE == request.getAttribute("hideDC");
				DCLocation remoteDeployment = DCLUtil.getRemoteDeployment(request);
				boolean showRemote = remoteDeployment!=null && AccountsConfiguration.getConfigurationTyped("fs.multidc.location.choice", false); // No I18N
				if(!hideDC && showRemote) {
					String currentCountry = remoteDeployment.getDescription().toUpperCase();
					String UserIPCountry = new Locale("",default_country.toUpperCase()).getDisplayCountry().toLowerCase();
				%>
    			<div style="margin-bottom:30px;">
					<div class="DC_note"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.DATA.CENTER.IP.DESC",UserIPCountry)%></div>
					<div class="change_dc"><%=Util.getI18NMsg(request, "IAM.MULTIDC.SIGNUP.DATACENTER.CONTENT", currentCountry)%> <span style="color:#0091FF;cursor:pointer" class="change_dc_btn" onclick="showDcOption(this)"><%=Util.getI18NMsg(request, "IAM.PHOTO.CHANGE")%></span></div>
				</div>
				<div class="dcOptionDiv detail_box" style="display:none;">
					<div class="user_header"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.DATA.CENTER.TITLE")%></div>
					<select id="dc_option" onchange="changeDCText(this)" class="signup-country">
						<option value="<%=remoteDeployment.getLocation().toLowerCase()%>"><%=currentCountry%></option>
						<option value="<%=DCLUtil.getLocation().toLowerCase()%>"><%=DCLUtil.getPresentLocation().getDescription().toUpperCase()%></option>
					</select>
				</div>
    			<%
    			}
				%>
				<div class="tos-container check_container">
						<input tabindex="1" class="agree_checkbox" type="checkbox" id="tog_agree" name="agree" value="true"/>
						<label for="tog_agree"><%=Util.getI18NMsg(request, "IAM.SIGNUP.AGREE.TERMS.OF.SERVICE", termsOfServiceUrl, privacyPolicyUrl)%></label>
				</div>
				<div class="newsletter-container check_container">
						<input tabindex="1" class="agree_checkbox" type="checkbox" id="newsletter" name="newsletter" value="true"/>
						<label for="newsletter"><%=Util.getI18NMsg(request, "IAM.TPL.ZOHO.NEWSLETTER.SUBSCRIBE1")%></label>
				</div>
				<div class="tos_error"><%=Util.getI18NMsg(request, "IAM.ACCOUNT.SIGNUP.POLICY.ERROR.TEXT") %></div>
				<button id="createFormAddBtn" class="form_btn" onclick="createUser()"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.ACCOUNT.BUTTON") %></button>
				</form>
				<div class="link_account_option">
					<div class="or_tag"><%=Util.getI18NMsg(request, "IAM.OR") %></div>	<%--No I18N--%>
					<div class="flex_link_container">
						<div>
							<div class="or_header"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.LINK.ACCOUNT.OPTION.TITLE") %></div>	<%--No I18N--%>
							<div class="or_description"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.LINK.ACCOUNT.OPTION.ABOUT", IDP_name.toLowerCase()) %></div>
						</div>
						<div class="or_button" onclick="redirectLink('<%=redirectURL%>')"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.ACCOUNTS.TITLE") %></div>
					</div>
				</div>
				</div>
				<%}%>
				<form class="otp_container" id="otp_container" style="display:none;" onsubmit="return false;">
					<div class="for_email">
						<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.VERIFY.OTP.HEADER.EMAIL")%></div>
						<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.VERIFY.OTP.DESCRIPTION.EMAIL")%></div>
					</div>
					<div class="for_mobile">
						<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.VERIFY.OTP.HEADER.MOBILE")%></div>
						<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.VERIFY.OTP.DESCRIPTION.MOBILE")%></div>
					</div>
					<div class="detail_box" style="margin-top:30px;margin-bottom:10px;">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.TFA.ENTER.OTP.CODE")%></div>	
						<div type="text" id="verification_otp" class="user_detail_input"></div>
					</div>
					<div class="resend_text" id="otp_resend" onclick="resendVerificationOTP()">
					<%=Util.getI18NMsg(request, "IAM.TFA.RESEND.OTP")%>
					</div>
					<div class="resend_text otp_sent" id="otp_sent" style="display:none">
					<%=Util.getI18NMsg(request, "IAM.GENERAL.OTP.SENDING")%>
					</div>
					<div class="button_container">
						<button class="form_btn" id="otp_verify_btn" onclick="verifyOTP()"><%=Util.getI18NMsg(request,"IAM.BUTTON.VERIFY")%></button>
						<button class="form_btn gray_btn" onclick="cancelFederateFlow()"><%=Util.getI18NMsg(request,"IAM.CANCEL")%></button>
					</div>
				</form>
			</div>
		</div>
		<footer id="footer"><%@ include file="../unauth/footer.jspf" %></footer>  <%--No I18N--%>
	</body>
	<script>
	
		var contextpath = "<%=contextpath%>";
	    var csrfParam = "<%=SecurityUtil.getCSRFParamName(request)%>";
	    var csrfCookieName= "<%=SecurityUtil.getCSRFCookieName(request)%>";
	    var isMobile = <%=isMobile%>;
	    var isOTPRequired = <%=isOTPRequired%>;
	    var isEmailRequired = <%=isEmailRequired%>;
	    var isMobileRequired = <%=isMobileRequired%>;
	    var isRecoveryRequired = <%=isRecoveryRequired%>;
	    var setTime;
		window.onload= function(){
		$( "input" ).on({
			  change : function(){removeErr()},
			  keypress: function(){removeErr()}
		});
		if($(".dcOptionDiv select").length>0){
			if(!isMobile){
				$(".dcOptionDiv select").select2({
					width: "100%", 						//No i18N
					minimumResultsForSearch: Infinity
				});
			}
		}

	    <% if(!hasAccount && !isAssociate){
		Object pic_with_logo = request.getAttribute(FSConsumerUtil.OAUTH_PIC_URL);
		String pic_logo_String = IAMUtil.isValid(pic_with_logo) ? pic_with_logo.toString() : "";
		%>
			$("#profile-pic img").attr("src","<%=IAMEncoder.encodeJavaScript(pic_logo_String)%>"); <%-- No I18N --%>
			<%if(!pic_logo_String.isEmpty()){%>	
			$("#profile-pic img").on('load',function(){
				$("#profile-pic .pro_pic_blur").css("background-image","url(<%=pic_logo_String%>)");	//No I18N
				$("#profile-pic img").css({"height":"auto","width":"auto"});	//No I18N
				if($("#profile-pic img").height() > $("#profile-pic img").width()){
					$("#profile-pic img").css({"height":"auto","width":"100%"});	//No I18N
				}
				else{
					$("#profile-pic img").css({"height":"100%","width":"auto"});	//No I18N				
				}
				$("#photo_permission").select2({
					theme : "photo_permission_theme",	//No I18N
					minimumResultsForSearch: Infinity,
					dropdownParent : $("#photo_permission").parents(".photo_permission_option"),		// No I18N
					templateResult: function(option){
				    	if (!option.id) { return option.text;}
				    	var ob = '<span class="permission_icon icon-'+$(option.element).attr("id")+'"></span><span>'+option.text+'</span>';	//No I18N
				    	return ob;
				    },
				    templateSelection: function (option) {
	   		            return '<span class="permission_icon icon-'+$(option.element).attr("id")+'"></span>';
				    },
				    escapeMarkup: function (m) {
					       return m;
					}
				});
				$(".container_blur").hide();
				$(".photo_permission_option").show();
		    });
			<%}else{%>
				$(".container_blur,.photo_permission_option").hide();
				$(document.scrollingElement).animate({
			        scrollTop: ($("body")[0].scrollHeight-$("body")[0].clientHeight)/2
			    }, 0);
			<%}%>
			setStateData();
			if(!isMobile){
				$("#user_country").select2({
					width:"100%", 						//No I18N
					theme : "country_div",				//No I18N
					templateResult: function(option){
						var ob = '<div class="pic flag_'+$(option.element).attr("value")+'" ></div><span class="cn">'+option.text+"</span>" ;
						return ob;
					},
				    escapeMarkup: function (m) {
					       return m;
					}
				}).on("select2:open", function(e) {
					$(e.target).parents(".detail_box").addClass("selected_div");	//No I18N
					if(!isMobile){
						if(state_data[document.querySelector('#user_country').value.toLowerCase()]){
							$(".country_select_container").css("width","250px");			 // No I18N
							$(".select2-container--country_div .select2-dropdown").removeClass("country_300_width");	 // No I18N
						}
						else{
							$(".country_select_container").css("width","300px");			 // No I18N
							$(".select2-container--country_div .select2-dropdown").addClass("country_300_width");	 // No I18N
						}
					}
					$(".select2-search__field").attr("placeholder", "<%=Util.getI18NMsg(request, "IAM.SEARCHING")%>");//No I18N
				});
			    $('#user_country').on("select2:close", function (e) { 
					$(e.target).parents(".detail_box").removeClass("selected_div");	//No I18N
				});
			}
			$("#user_mobile_country").select2({
				width:"auto", 						//No I18N
				theme : "phonenumber_div",				//No I18N
				templateResult: function(option){
					var spltext;
					if (!option.id) { return option.text; }
					spltext=option.text.split("(");
					var num_code = $(option.element).attr("data-num");	//No I18N
					var string_code = $(option.element).attr("value");	//No I18N

					var ob = '<div class="pic flag_'+string_code+'" ></div><span class="cn">'+spltext[0]+"</span><span class='cc'>"+num_code+"</span>" ;
					return ob;
				},
				templateSelection: function (option) {
					//selectFlag($(option.element));
					$("#user_mobile").css("text-indent",($(".select2-container--phonenumber_div").width()+3)+"px");	//No i18N
					return $(option.element).attr("data-num");	//No i18N
				},
				language: {
			        noResults: function(){
			            return "<%=Util.getI18NMsg(request,"IAM.NO.RESULT.FOUND")%>";
			        }
			    },
			    escapeMarkup: function (m) {
			    	return m;
				}}).on("select2:open", function(e) {
				   $(e.target).parents(".detail_box").addClass("selected_div");	//No I18N
			       $(".select2-search__field").attr("placeholder", '<%=Util.getI18NMsg(request,"IAM.SEARCHING")%>');	//No I18N
			  	});
			    $('#user_mobile_country').on("select2:close", function (e) { 
					$(e.target).parents(".detail_box").removeClass("selected_div");	//No I18N
				});
			//selectFlag($(document.addphonenum.countrycode).find("option:selected"));	
			$(".select2-selection__rendered").attr("title", "");	//No I18N
		    $("#user_mobile_country").on("select2:close", function (e) { 
				$(e.target).siblings("input").focus();
			});
			<%if(isEmailRequired && isMobileRequired && !IAMUtil.isValidEmailId(emailId)){%>
			$(".select2-container--phonenumber_div").hide();
			$("#user_mobile").css("text-indent","0px");	//No I18N
			<%}%>
			$(document.scrollingElement).animate({
		        scrollTop: ($("body")[0].scrollHeight-$("body")[0].clientHeight)/2
		    }, 0);
		<% }else{%>
			$(".container_blur").hide();
		<%}%>
		};
		
		<% if(!hasAccount && !isAssociate){%>
		function setStateData(){
			var data = state_data[document.querySelector('#user_country').value.toLowerCase()];		 // No I18N
			if(data){
				document.querySelector('#state_list').innerHTML='<option value="" disabled="" selected=""><%=Util.getI18NMsg(request, "IAM.US.STATE.SELECT")%></option>'+data;	 // No I18N
				if(!isMobile){
					$("#state_list").select2({
						width:"100%" //No I18N
					}).on("select2:open", function(e) {
						$(".select2-search__field").attr("placeholder", "<%=Util.getI18NMsg(request, "IAM.SEARCHING")%>");//No I18N
						$(e.target).parents(".detail_box").addClass("selected_div");	//No I18N
					});
				    $('#state_list').on("select2:close", function (e) { 
						$(e.target).parents(".detail_box").removeClass("selected_div");	//No I18N
					});
					$(".country_select_container").css("width","250px");			 // No I18N
					$(".select2-container--country_div .select2-dropdown").removeClass("country_300_width");	 // No I18N
				}
				$("#state_container").show();
			}
			else{
				if(!isMobile){
					$(".country_select_container").css("width","300px");			 // No I18N
					$(".select2-container--country_div .select2-dropdown").addClass("country_300_width");	 // No I18N
				}
				$("#state_container").hide();
			}
			handleNewsletterField($("#user_country")[0]);
			setFooterPosition();
		}
		
		function showDcOption(ele){
			$(".change_dc").parent().hide();
			$(".dcOptionDiv").slideDown(300,function(){
				setFooterPosition();
			});
		}
		
		function handleNewsletterField(selectElement) {
			if(selectElement) {
				var SHOW_FIELD_WITH_CHECKED = "<%=AccountsInternalConst.NewsLetterSubscriptionMode.SHOW_FIELD_WITH_CHECKED.getType()%>";			<%-- NO OUTPUTENCODING --%>
				var SHOW_FIELD_WITHOUT_CHECKED = "<%=AccountsInternalConst.NewsLetterSubscriptionMode.SHOW_FIELD_WITHOUT_CHECKED.getType()%>";	<%-- NO OUTPUTENCODING --%>
				var DOUBLE_OPT_IN = "<%=AccountsInternalConst.NewsLetterSubscriptionMode.DOUBLE_OPT_IN.getType()%>";								<%-- NO OUTPUTENCODING --%>
				var optionEle = selectElement.options[selectElement.selectedIndex];
				var countryCode = optionEle.value;
				var newsletter_mode = optionEle.getAttribute("newsletter_mode");
				var newsletterEle = $('#newsletter');
				if(newsletter_mode == SHOW_FIELD_WITH_CHECKED) {
			        $('#newsletter').prop('checked', true);			 //No I18N
			        $('.newsletter-container').css('display',''); //No I18N
				} else if(newsletter_mode == SHOW_FIELD_WITHOUT_CHECKED || newsletter_mode == DOUBLE_OPT_IN) {
			        $('#newsletter').prop('checked', false);		 //No I18N
			        $('.newsletter-container').css('display',''); //No I18N
				} else {
			        $('#newsletter').prop('checked', true);			 //No I18N
			        $('.newsletter-container').css('display','none'); //No I18N
				}
			}
		}	
		
		function handleProPicError(){
			$(".photo_permission_option,.photo_permission,.container_blur,.select2-container--photo_permission_theme").hide();
			$(document.scrollingElement).animate({
		        scrollTop: ($("body")[0].scrollHeight-$("body")[0].clientHeight)/2
		    }, 0);
		}
		
		function changeDCText(ele){
			$(".dcOptionDiv,.DC_note").hide();
			if($("#dc_option option:first").val() == $("#dc_option").val()){
				$(".DC_note").show()
			}
			$(".change_dc").parent().show();
			$(".choosed_DC").text($(ele).find("option:selected").html());
		}
		<%}%>
		function addLoadingInButton(ele){
			$(ele).attr("disabled", "disabled").addClass("btn_loading");	//No I18N
		}
		
		function removeBtnLoading(ele){
			$(ele).removeAttr("disabled").removeClass("btn_loading");		//No I18N
		}
		function showErrorMessage(msg) 
		{
			if(msg!=""	&& msg!=undefined)
			{
				$(".error_msg").show();
				$(".error_msg").removeClass("sucess_msg");
				$(".error_msg").removeClass("warning_msg");
				$("#succ_or_err").html("");
				$("#succ_or_err_msg").html(msg);
				$(".error_msg_cross").html("");
				$(".error_msg_cross").append("<span class='crossline1'></span><span class='crossline2'></span>");
			
				var height =($(".error_msg_text")[0].clientHeight/2)-18;		
				
				$(".error_msg").css("top","60px");		// No I18N

				if(setTime!=""){
					clearTimeout(setTime);
				}
				
				setTime = setTimeout(function() {
					$(".error_msg").css("top","-100px");		// No I18N
				}, 5000);		

			}

		}		
		
		function Hide_Main_Notification()
		{
			$(".error_msg").css("top","-100px");		// No I18N
		}
		
		function IsJsonString(str) {
			try {
				$.parseJSON(str);
			} catch (e) {
				return false;
			}
			return true;
		}
		function handleConnectionError(){
			showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
			removeBtnLoading("button");									//No i18N
			return false;
		}
		function isNameString(str)
		{
			var objRegExp = new XRegExp("^[\\p{L}\\p{M}\\p{N}\\-\\_\\ \\.\\+\\!\\[\\]\\']+$","i")	//No i18N
			return objRegExp.test(str.trim());
		}
		
		function iamMoveToSignin(loginurl,loginid,country_code){
			var oldForm = document.getElementById("signinredirection");
			if(oldForm) {
				document.documentElement.removeChild(oldForm);
			}
			var form = document.createElement("form");
			form.setAttribute("id", "signinredirection");
			form.setAttribute("method", "POST");
		    form.setAttribute("action", loginurl);
		    form.setAttribute("target", "_parent");
			
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "LOGIN_ID");
			hiddenField.setAttribute("value", loginid); 
			form.appendChild(hiddenField);
		    
		    if(country_code){
		        hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "CC");
				hiddenField.setAttribute("value", country_code); 
				form.appendChild(hiddenField);
		    }
			
		   	document.documentElement.appendChild(form);
		  	form.submit();
			return false;
		}
		
		<% if(!hasAccount && !isAssociate){%>
		var user_email = '<%=emailId%>';
		var resend_timer=undefined;
		var view_permission = 3;
		var Z_Authorization = "";
		
		function sendRequestWithCallbackAndHeader(action, params, async, callback,method) {
			if (typeof contextpath !== 'undefined') {
				action = contextpath + action;
			}
		    var objHTTP = xhr();
		    objHTTP.open(method?method:'POST', action, async);
		    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
		    objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+euc(getCookie(csrfCookieName)));
		    if(Z_Authorization != ""){
		    	objHTTP.setRequestHeader('Z-Authorization',Z_Authorization);
		    }
		    if(async){
			objHTTP.onreadystatechange=function() {
			    if(objHTTP.readyState==4) {
			    	if (objHTTP.status === 0 ) {
						handleConnectionError();
						return false;
					}
					if(callback) {
					    callback(objHTTP.responseText);
					}
			    }
			};
		    }
		    objHTTP.send(params);
		    if(!async) {
			if(callback) {
		            callback(objHTTP.responseText);
		        }
		    }
		} 
		
		function createUser(){
			<%if(!isNameFieldOptional){%>
			var first_name = $("#user_first_name");
			var last_name = $("#user_last_name");
			var name_length = first_name.val().trim().length;
			if(last_name.val().trim() != ""){
				name_length = (first_name.val().trim() + " " + last_name.val().trim()).length;
			}
			if(name_length > 100){
				showErrorMessage('<%=Util.getI18NMsg(request,"IAM.ERROR.FULLNAME.MAXLEN",100)%>');
				return false;
			}
			if(isEmpty(first_name.val().trim()) || !isNameString(first_name.val().trim())){
				first_name.parents(".detail_box").addClass("err_box");		//No i18N
				first_name.siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.NEW.SIGNUP.FIRSTNAME.VALID")%>'); //No I18N
				return false;
			}
			if(!isEmpty(last_name.val().trim()) && !isNameString(last_name.val().trim())){
				last_name.parents(".detail_box").addClass("err_box");		//No i18N
				last_name.siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.NEW.SIGNUP.LASTNAME.VALID")%>'); //No I18N
				return false;
			}
			if((/^[0-9 ]+$/).test((first_name.val()+last_name.val()).trim())){
				first_name.parents(".detail_box").addClass("err_box");		//No i18N
				first_name.siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.NEW.SIGNUP.FIRSTNAME.VALID")%>');	//No i18N
				return false;
			}
			<%}%>
			if($("#user_email_id").length>0){
				user_email = $("#user_email_id").val().trim();
				if(!isEmailId(user_email)){
					$("#user_email_id").parents(".detail_box").addClass("err_box");		//No i18N
					$("#user_email_id").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.AC.CONFIRM.EMAIL.VALID")%>'); //No I18N
					return false;
				}
			}
			<%if((isMobileRequired && !isEmailRequired) || isRecoveryRequired || (isMobileRequired && isEmailRequired && !IAMUtil.isValidEmailId(emailId))){%>
			<%if(isEmailRequired && isMobileRequired && !IAMUtil.isValidEmailId(emailId)){%>
				if(!(/^(?:[0-9] ?){3,1000}[0-9]$/.test($("#user_mobile").val())) && !isEmailId($("#user_mobile").val())){
					$("#user_mobile").parents(".detail_box").addClass("err_box");		//No i18N
					$("#user_mobile").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ERROR.EMAIL.OR.MOBILE")%>'); 	//No I18N
					return false;
				}
			<%}else{%>
				if(!(/^(?:[0-9] ?){3,1000}[0-9]$/.test($("#user_mobile").val()))){
					$("#user_mobile").parents(".detail_box").addClass("err_box");		//No i18N
					$("#user_mobile").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER")%>'); 	//No I18N
					return false;
				}
			<%}%>
			<%}%>
			if(!$("#tog_agree").is(":checked")){
				$(".tos_error").show();
				return false;
			}
			if($(".photo_permission_option").is(":visible")){
				view_permission = $("#photo_permission").val();
			}
			var param = {
					"federatedsignup" : {									//No i18N
						<%if(isEmailRequired && !isMobileRequired){%>
						"email" : user_email,								//No i18N
						<%}%>
						"viewpermission" : parseInt(view_permission),					//No i18N
						<%if(isEmailRequired && isRecoveryRequired){%>
						"country_code"	 : $("#user_mobile_country").val(),	//No i18N
						"rmobile"		 : $("#user_mobile").val(),			//No i18N
						<%}else if(isEmailRequired && isMobileRequired){%>
							<%if(IAMUtil.isValidEmailId(emailId)){%>
							"emailormobile"		 : user_email,					//No i18N
							<%}else{%>
							"country_code"	 : $("#user_mobile_country").val(),	//No i18N
							"emailormobile"		 : $("#user_mobile").val(),		//No i18N
							<%}
						}else if(isMobileRequired){%>
						"country_code"	 : $("#user_mobile_country").val(),	//No i18N
						"mobile"		 : $("#user_mobile").val(),			//No i18N
						<%
						}
						if(!isNameFieldOptional){%>
						"firstname": $("#user_first_name").val(),			//No i18N
						"lastname": $("#user_last_name").val(),				//No i18N
						<%}%>
						"country": $("#user_country").val(),				//No i18N
						"newsletter": $("#newsletter").is(":checked"),		//No i18N
						"tos" : $("#tog_agree").is(":checked")             //No i18N
					}
				}
			if(Object.keys(state_data).indexOf(param.federatedsignup.country.toLowerCase()) != -1 && $("#state_list").val() != null){
				param.federatedsignup.country_state = $("#state_list").val();
			}
			if($(".dcOptionDiv").length>0){
				param.federatedsignup.dclocation = $("#dc_option").val();
			}
			addLoadingInButton("#createFormAddBtn");					
			sendRequestWithCallback("/webclient/v1/fsregister/signup", JSON.stringify(param),true, function(resp){		// No I18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						if(isOTPRequired){
							$(".federated_signup_form").hide();
							$("#otp_container").show();
							var showMobContent = isMobileRequired || isRecoveryRequired;
							var otpSource = showMobContent ? $("#user_mobile").val() : user_email;
							if(isMobileRequired && isEmailRequired && isEmailId($("#user_mobile").val())){
								showMobContent = false;
								otpSource = $("#user_mobile").val();
							}
							if(jsonStr.federatedsignup.token){
								Z_Authorization = jsonStr.federatedsignup.token;
							}
							if(showMobContent){
								$(".for_email").hide();
								$(".for_mobile").show();
								$(".for_mobile .desc_text").text(formatMessage($(".for_mobile .desc_text").text(),otpSource));
							}
							else{
								$(".for_email").show();
								$(".for_mobile").hide();
								$(".for_email .desc_text").text(formatMessage($(".for_email .desc_text").text(),otpSource));
							}
							splitField.createElement('verification_otp',{
								"splitCount":7,					// No I18N
								"charCountPerSplit" : 1,		// No I18N
								"isNumeric" : true,				// No I18N
								"otpAutocomplete": true,		// No I18N
								"customClass" : "customOtp",	// No I18N
								"inputPlaceholder":'&#9679;'	// No I18N
							});
							$('#verification_otp .customOtp').attr('onkeypress','removeErr()');	// No I18N
							resend_countdown();
							$('#verification_otp').click();
							setFooterPosition();
						}
						else{
							redirectLink(jsonStr.federatedsignup.redirect_uri);
						}
					}
					else{
						removeBtnLoading("#createFormAddBtn");							//No i18N
						showErrorMessage(getErrorMessage(jsonStr));
					}
				}else{
					removeBtnLoading("#createFormAddBtn");							//No i18N
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
		}
		
		function checkEmailOrPhone(ele){
			var isMobileNumber = /^(?:[0-9] ?){2,1000}[0-9]$/.test(ele.value);
			if(isMobileNumber){
				$(".select2-container--phonenumber_div").show();
				$("#user_mobile").css("text-indent",($(".select2-container--phonenumber_div").width()+3)+"px");					//No i18N
				$("#user_mobile").attr("maxlength","15");	//No I18N
			}
			else{
				$(".select2-container--phonenumber_div").hide();
				$("#user_mobile").css("text-indent","0px");	//No I18N
				$("#user_mobile").attr("maxlength","100");	//No I18N
			}
		}
		
		function verifyOTP(){
			var otp = $("#verification_otp_full_value").val();
			if(isEmpty(otp)||otp.length<7){
				$("#verification_otp").parents(".detail_box").addClass("err_box");	//No I18N
				$("#verification_otp").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.ERROR.ENTER.VALID.OTP")%>'); //No I18N
				return false;
			}
			var param = {
					"federatedsignupotp" : {									//No i18N
						<%if(isEmailRequired && !isMobileRequired){%>
						"email" : user_email,								//No i18N
						<%}%>
						"viewpermission" : parseInt(view_permission),					//No i18N
						<%if(isEmailRequired && isRecoveryRequired){%>
						"country_code"	 : $("#user_mobile_country").val(),	//No i18N
						"rmobile"		 : $("#user_mobile").val(),			//No i18N
						<%}else if(isEmailRequired && isMobileRequired){%>
							<%if(IAMUtil.isValidEmailId(emailId)){%>
							"emailormobile"		 : user_email,					//No i18N
							<%}else{%>
							"country_code"	 : $("#user_mobile_country").val(),	//No i18N
							"emailormobile"		 : $("#user_mobile").val(),		//No i18N
							<%}
						}else if(isMobileRequired){%>
						"country_code"	 : $("#user_mobile_country").val(),	//No i18N
						"mobile"		 : $("#user_mobile").val(),			//No i18N
						<%
						}
						if(!isNameFieldOptional){%>
						"firstname"			: $("#user_first_name").val(),		//No i18N
						"lastname"			: $("#user_last_name").val(),		//No i18N
						<%}%>
						"vercode" 			: otp,								//No i18N
						"country"			: $("#user_country").val(),			//No i18N
						"newsletter"		: $("#newsletter").is(":checked"),	//No i18N
						"tos" : $("#tog_agree").is(":checked")             //No i18N
					}
				}
			if(Object.keys(state_data).indexOf(param.federatedsignupotp.country.toLowerCase()) != -1 && $("#state_list").val() != null){
				param.federatedsignupotp.country_state = $("#state_list").val();
			}
			if($(".dcOptionDiv").length>0){
				param.federatedsignupotp.dclocation = $("#dc_option").val();
			}
			addLoadingInButton("#otp_verify_btn");
			sendRequestWithCallbackAndHeader("/webclient/v1/fsregister/otp", JSON.stringify(param),true, function(resp){		// No I18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						redirectLink(jsonStr.federatedsignupotp.redirect_uri);
					}
					else{
						removeBtnLoading("#otp_verify_btn");							//No i18N
						showErrorMessage(getErrorMessage(jsonStr));
						$('#verification_otp').click();
					}
				}else{
					removeBtnLoading("#otp_verify_btn");							//No i18N
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
		}
		
		function resendVerificationOTP(){
			var param = {
					"federatedsignupotp" : {}			//No i18N
			}
			if($(".dcOptionDiv").length>0){
				param.federatedsignupotp.dclocation = $("#dc_option").val();
			}
			$("#otp_resend").hide();
			$("#otp_sent").show().addClass("otp_senting");
			$("#otp_sent").html("<%=Util.getI18NMsg(request, "IAM.GENERAL.OTP.SENDING")%>");
			
			sendRequestWithCallbackAndHeader("/webclient/v1/fsregister/otp", JSON.stringify(param),true, function(resp){		// No I18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						resend_countdown();
						setTimeout(function(){
							$("#otp_sent").removeClass("otp_senting");
							$("#otp_sent").html("<%=Util.getI18NMsg(request, "IAM.GENERAL.OTP.SUCCESS")%>");
						},1000);
						setTimeout(function(){
							$("#otp_resend").show();
							$("#otp_sent").hide().removeClass("otp_senting");
						},2000);
					}
					else{
						showErrorMessage(getErrorMessage(jsonStr));
						setTimeout(function(){
							$("#otp_resend").show();
							$("#otp_sent").hide().removeClass("otp_senting");
						},2000);
					}
				}else{
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
					setTimeout(function(){
						$("#otp_resend").show();
						$("#otp_sent").hide().removeClass("otp_senting");
					},2000);
				}
			},"PUT");									//No i18N
		}
		
		function resend_countdown()
		{
			$("#otp_resend").html("<%=Util.getI18NMsg(request, "IAM.RESEND.OTP.COUNTDOWN")%>");
			$("#otp_resend").addClass("resend_otp_blocked");
			$("#otp_resend").attr("onclick","");		//No i18N
			var time_left=59;
			clearInterval(resend_timer);
			resend_timer=undefined;
			resend_timer = setInterval(function()
			{
				$("#otp_resend span").text(time_left);
				time_left-=1;
				if(time_left<=0)
				{
					clearInterval(resend_timer);
					$("#otp_resend").removeClass("resend_otp_blocked");
					$("#otp_resend").html("<%=Util.getI18NMsg(request, "IAM.TFA.RESEND.OTP")%>");
					$("#otp_resend").attr("onclick","resendVerificationOTP()");		//No i18N
				}
			}, 1000);
		}
		<%}%>
		
		function cancelFederateFlow(){
			var param = {
					"federatedsignup" : {}					//No i18N
				}
			sendRequestWithCallback("/webclient/v1/fsregister/signup", JSON.stringify(param),true, function(resp){		// No I18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						redirectLink(jsonStr.federatedsignup.redirect_uri);
					}
					else{
						showErrorMessage(getErrorMessage(jsonStr));
					}
				}else{
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			},"PUT");																	//No i18N
		}
		
		function removeErr(){
			$(".tos_error").hide();
			$(".detail_box").removeClass("err_box");
			if($("#user_email_id")){
				$("#user_email_id").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.EMAIL.ADDRESS")%>'); //No I18N
			}
			if($("#verification_otp")){
				$("#verification_otp").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.TFA.ENTER.OTP.CODE")%>'); //No I18N
			}
			if($("#user_mobile")){
				<%if(isEmailRequired && !isRecoveryRequired && !IAMUtil.isValidEmailId(emailId)){%>
					$("#user_mobile").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.EMAIL.ADDRESS.OR.MOBILE")%>'); //No I18N
				<%}else{%>
					$("#user_mobile").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.MOBILE.NUMBER")%>'); //No I18N
				<%}%>
			}
			<%if(!isNameFieldOptional){%>
			$("#user_first_name").siblings(".user_header").html('<%=Util.getI18NMsg(request,"IAM.GENERAL.FIRSTNAME")%>'); //No I18N
			$("#user_last_name").siblings(".user_header").html('<%=Util.getI18NMsg(request,"IAM.GENERAL.LASTNAME")%>'); //No I18N
			<%}%>
		}
		<%if(isAssociate){%>
		function associateUser(){
			addLoadingInButton("#associateFormAddBtn");		// No I18N
			var param = {
					"associatefederatedaccount" : {						//No i18N
						"preference" : "associate"						//No i18N
					}
				}
			sendRequestWithCallback("/webclient/v1/fsregister/associate", JSON.stringify(param),true, function(resp){		//No i18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						redirectLink(jsonStr.associatefederatedaccount.redirect_uri);
					}
					else{
						showErrorMessage(getErrorMessage(jsonStr));
						removeBtnLoading("#associateFormAddBtn");	// No I18N
					}
				}else{
					removeBtnLoading("#associateFormAddBtn");	// No I18N
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
		}
		function cancelAssociateOption(){
			var param = {
					"associatefederatedaccount" : {						//No i18N
						"preference" : "deny"							//No i18N
					}
				}
			sendRequestWithCallback("/webclient/v1/fsregister/associate", JSON.stringify(param),true, function(resp){	//No i18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						redirectLink(jsonStr.associatefederatedaccount.redirect_uri);
					}
					else{
						showErrorMessage(getErrorMessage(jsonStr));
					}
				}else{
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
		}
		
		<%}%>
		
	</script>
</html>