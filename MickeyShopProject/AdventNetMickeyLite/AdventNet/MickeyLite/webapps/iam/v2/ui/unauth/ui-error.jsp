<%-- $Id$ --%>
<%@page import="com.zoho.accounts.internal.util.ClientPortalUtil"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.adventnet.iam.Service"%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.adventnet.iam.Org"%>
<%@page import="com.adventnet.iam.IAMStatusCode.StatusCode"%>
<%@page import="com.adventnet.iam.IAMException.IAMErrorCode"%>
<%@page import="com.zoho.iam.rest.metadata.ICRESTMetaData"%>
<%@page import="com.adventnet.iam.security.SecurityRequestWrapper"%>
<%@page import="com.adventnet.iam.security.ActionRule"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%@page import="com.adventnet.iam.security.IAMSecurityException"%>
<%@page import="com.zoho.iam.rest.ICRESTManager"%>
<%@page import="com.zoho.iam.rest.representation.ICRESTRepresentation"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@ page isErrorPage="true"%>
<%
	response.setContentType("text/html;charset=UTF-8"); //No I18N
	String errorTitle = I18NUtil.getMessage("IAM.ERRORJSP.ERROR.OCCURED.TITLE");//No I18N
	String errorDescryption = null;
	Set<String> serviceSet =new HashSet<String>();
	StatusCode code = (StatusCode) request.getAttribute("statuscode") != null ? (StatusCode) request.getAttribute("statuscode") : StatusCode.GENERAL_ERROR;//No I18N
	switch (code) {
	case SAML_UNSUPPORTED_AUTHENTICATION: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.AUTHENTICATION.FAILED.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.SP.ERROR.UNSUPPORTED.AUTH.RESPONSE.DESC");//No I18N
		break;
	}
	case INVALID_SAML_RESPONSE: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.SP.ERROR.INVALID.RESPONSE.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.SP.ERROR.INVALID.RESPONSE.DESC");//No I18N
		break;
	}
	case INVALID_SAML_STATUS_CODE: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.SP.ERROR.INVALID.STATUSCODE.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.SP.ERROR.INVALID.STATUSCODE.DESC");//No I18N
		break;
	}
	case SAML_RESPONDER_LOGIN_FAILED: {
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.SP.RESPONDER.LOGIN.FAILED.DESC");//No I18N
		break;
	}
	case SAML_REQUESTER_LOGIN_FAILED: {
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.SP.REQUESTER.LOGIN.FAILED.DESC");//No I18N
		break;
	}
	case SAML_NOT_CONFIGURED: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.NOT.CONFIGURED.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.NOT.CONFIGURED.DESC");//No I18N
		break;
	}
	case SAML_NOT_ENABLED: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.DISABLED.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.DISABLED.DESC");//No I18N
		break;
	}
	case SAML_SIGNATURE_FAILED: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.SP.ERROR.SIGNATURE.FAILED.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.SP.ERROR.SIGNATURE.FAILED.DESC");//No I18N
		break;
	}
	case SAML_CONDITIONS_FAILED: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.AUTHENTICATION.FAILED.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.AUTHENTICATION.FAILED.DESC");//No I18N
		break;
	}
	case INVALID_SAML_DESTINATION_ATTRIBUTE: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.INCORRECT.DESTINATION.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.INCORRECT.DESTINATION.DESC");//No I18N
		break;
	}
	case INVALID_SAML_SUBJECT_CONFIRMATION: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.INCORRECT.SUBJECT.CONFIRMATION.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.INCORRECT.SUBJECT.CONFIRMATION.DESC");//No I18N
		break;
	}
	case INVALID_SAML_EMAILID: {
		String email = String.valueOf(request.getAttribute("email"));
		errorTitle = Util.getI18NMsg(request, "IAM.ERROR.INVALID.EMAIL.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.INVALID.EMAIL.DESC", email);//No I18N
		break;
	}
	case SAML_AUTHDOMAIN_MISMATCH: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.AUTHENTICATION.FAILED.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.MISMATCH.AUTHDOMAIN.DESC");//No I18N
		break;
	}
	case SAML_EXCLUDED_USER: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.EXCLUDED.USER.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.EXCLUDED.USER.DESC");//No I18N
		break;
	}
	case SAML_NO_SUCH_USER: {
		Org org = (Org) request.getAttribute("org");
		String adminEmail = org != null ? Util.USERAPI.getUserFromZUID(String.valueOf(org.getOrgContact())).getContactEmail() : "";
		String email = String.valueOf(request.getAttribute("email"));
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.USER.NOT.EXIST.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.DISABLED.USER.PROVISIONING.DESC", email, adminEmail);//No I18N
		break;
	}
	case SAML_USER_PROVISIONING_FAILED: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.FAILED.USER.PROVISIONING.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.FAILED.USER.PROVISIONING.DESC");//No I18N
		serviceSet= (Set<String>)request.getAttribute("failed_services");
		break;
	}
	case SAML_USER_LIMIT_EXCEEDED: {
		Org org = (Org) request.getAttribute("org");
		String adminEmail = org != null ? Util.USERAPI.getUserFromZUID(String.valueOf(org.getOrgContact())).getContactEmail() : "";
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.EXCEEDED.USER.LIMIT.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.EXCEEDED.USER.LIMIT.DESC", adminEmail);//No I18N
		break;
	}
	case SAML_ORG_DOMAIN_MISMATCH: {
		Org org = (Org) request.getAttribute("org");
		String adminEmail = org != null ? Util.USERAPI.getUserFromZUID(String.valueOf(org.getOrgContact())).getContactEmail() : "";
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.UNVERIFIED.ORG.DOMAIN.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.UNVERIFIED.ORG.DOMAIN.DESC", adminEmail);//No I18N
		break;
	}
	case SAML_ORG_DOMAIN_NOT_VERIFIED: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.UNVERIFIED.ORG.DOMAIN.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.UNVERIFIED.ORG.DOMAIN.DESC");//No I18N
		break;
	}
	case SAML_PARTNER_ORG_MISMATCH: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.INVALID.AUTHENTICATION.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.INVALID.AUTHENTICATION.DESC");//No I18N
		break;
	}
	case INVALID_SAML_USER: {
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.INVALID.USER.DESC");//No I18N
		break;
	}
	case SAML_GENERAL_ERROR: {
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.ERROR.GENERAL.DESC");//No I18N
		break;
	}
	case SAML_NO_SUCH_ORG: {
		errorTitle = Util.getI18NMsg(request, "IAM.ORG.ERROR.NOT.EXIST.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.ORG.ERROR.NOT.EXIST.DESC");//No I18N
		break;
	}
	case INVALID_SAML_LOGOUT_REQUEST: {
		errorTitle = Util.getI18NMsg(request, "IAM.SAML.ERROR.SIGNOUT.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SAML.IDP.ERROR.SIGNOUT.DESC");//No I18N
		break;
	}
	case USER_NOT_ACTIVE: {
		errorDescryption = Util.getI18NMsg(request, "IAM.SIGNIN.ERROR.USER.NOT.ACTIVE",Util.getSupportEmailId());//No I18N
		break;
	}
	case USER_MARKED_AS_SPAM: {
		errorTitle = Util.getI18NMsg(request, "IAM.ERRORJSP.ERROR.OCCURED.TITLE");//No I18N
		errorDescryption = Util.getI18NMsg(request, "IAM.SIGNIN.ERROR.USER.SPAM",AccountsConfiguration.ANTI_SPAM_SUPPORT_EMAILID.toStringValue());//No I18N
		break;
	}
	case USER_NOT_ACTIVE_IN_SERVICE: {
		Service service = Util.getServiceObject(request.getParameter("servicename"));
		String serviceName = service != null ? service.getDisplayName() : "" ;
		errorDescryption = Util.getI18NMsg(request, "IAM.SIGNIN.ERROR.USER.NOT.ACTIVE.IN.SERVICE", serviceName, Util.getSupportEmailId());//No I18N
		break;
	}
	case DAILY_SIGNIN_LIMIT_REACHED: {
		errorDescryption = Util.getI18NMsg(request, "IAM.SIGNIN.ERROR.USER.DAILY.SIGNIN.LIMIT.EXCEEDED",AccountsConfiguration.getConfiguration("iam.login.limit.learnwhy.link", "https://help.zoho.com/portal/en/kb/accounts/troubleshooting/sign-in/articles/troubleshoot-sign-in-related-issues#What_is_a_daily_sign-in_limit"));//No I18N
		break;
	}
	case UNAUTHORIZED_ORG_NETWORK_ACCESS: {
		errorDescryption = Util.getI18NMsg(request, "IAM.SIGNIN.ERROR.ORG.NETWORK.BLOCKED");//No I18N
		break;
	}
	case RESTRICT_SIGNIN_ENABLED: {
		errorDescryption = Util.getI18NMsg(request, "IAM.SIGNIN.ERROR.RESTRICT.SIGNIN.ENABLED");//No I18N
		break;
	}
	case GENERAL_ERROR: {
		errorDescryption = Util.getI18NMsg(request, "IAM.ERROR.GENERAL.REQUEST.PROCESSING");//No I18N
		break;
	}
	case INVALID_AUTHORIZE_REQUEST: {
		errorTitle = I18NUtil.getMessage("IAM.AUTHORIZE.PAGE.SUSPICIOUS.REQUEST.TITLE");
		errorDescryption = I18NUtil.getMessage("IAM.AUTHORIZE.PAGE.SUSPICIOUS.REQUEST.DESCRIPTION");
		break;
	}
	case LINKED_ACCOUNT_THROTTLE_EXCEEDED: {
		errorTitle = I18NUtil.getMessage("IAM.LINKED.ACCOUNTS.THROTLLE.EXCEEDED.TITLE");
		String provider = (String)request.getAttribute("provider");
		provider = provider.charAt(0) + provider.substring(1).toLowerCase();
		errorDescryption = I18NUtil.getMessage("IAM.LINKED.ACCOUNTS.THROTLLE.EXCEEDED.DESCRIPTION", provider);
		break;
	}
	case OAUTH_ACCESS_LIMIT_EXCEEDED: {
		errorTitle = I18NUtil.getMessage("IAM.OAUTH.ACCESS.DENIED");
		errorDescryption = I18NUtil.getMessage("IAM.OAUTH.ACCESS.DENIED.UI.DESCRIPTION");
		break;
	}
	case URL_RULE_NOT_CONFIGURED : 
		errorTitle = I18NUtil.getMessage("IAM.ERROR.JSP.URL_RULE_NOT_CONFIGURED.TITLE");
		errorDescryption = I18NUtil.getMessage("IAM.ERROR.JSP.URL_RULE_NOT_CONFIGURED.DESC");
		break;	
	case INVALID_SORG_INVITATION: {
		errorDescryption = I18NUtil.getMessage("IAM.SORGINVITATION.INVALID.ENDPOINT.URL");//No I18N
		break;
	}
	case UNTRUSTED_DOMAIN:{
		errorTitle = I18NUtil.getMessage("IAM.PORTAL.UNTRUSTED.DOMAIN");
		errorDescryption = I18NUtil.getMessage("IAM.PORTAL.UNTRUSTED.DOMAIN.DESC");
		break;	
	}
	case UNAPPROVED_USERS_LIMIT_EXCEEDED:{
		String adminEmail = String.valueOf(request.getAttribute("admin_email"));
		errorTitle = I18NUtil.getMessage("IAM.SIGNIN.ERROR.UNAPPROVED.USERS.LIMIT.EXCEEDED.TITLE");
		errorDescryption = I18NUtil.getMessage("IAM.SIGNIN.ERROR.UNAPPROVED.USERS.LIMIT.EXCEEDED", Util.isValid(adminEmail)?adminEmail:"admin");
		break;
	}
	case USER_NOT_APPROVED: {
		String adminEmail = String.valueOf(request.getAttribute("admin_email"));
		errorTitle = I18NUtil.getMessage("IAM.SIGNIN.ERROR.USER.NOT.APPROVED.TITLE");
		errorDescryption = I18NUtil.getMessage("IAM.SIGNIN.ERROR.USER.NOT.APPROVED", Util.isValid(adminEmail)?adminEmail:"admin");
		break;
	}
	default: {
		errorDescryption = code.getMessage();
		break;
	}
	}
%>


<%
	if(!serviceSet.isEmpty()	&&	code==StatusCode.SAML_USER_PROVISIONING_FAILED) 	
	{
%>

	<html>
		<head>
			<title><%= Util.getI18NMsg(request,"IAM.ACCOUNT.CREATION.BLOCKED")%></title>
			<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
			<meta charset="UTF-8" />
			<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
			<link href="<%=StaticContentLoader.getStaticFilePath("/v2/components/css/zohoPuvi.css")%>" rel="stylesheet"type="text/css">
			<style type="text/css">
			

				
				body 
				{
				  height: auto;
				  width: 100%;
				  background-color: rgb(252 252 252);
				  margin: 0px;
				}

				body .zohologo 
				{
				    display: block;
				    height: 30px;
				    width: 81px;
				    margin: auto;
				    margin-bottom: 20px;
				    margin-top: 100px;
				    background: url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/zoho.png")%>") no-repeat transparent;
				    background-size: 100% auto;
				    background-position: center;
				}

				body .info_block
				{
				    z-index: 4;
				    border-radius: 20px;
				    position: fixed;
				    left: 0px;
				    right: 0px;
				    top: 23%;
				    margin: auto;
				    height: auto;
				    width: 800px;
				    background: #fff;
				    outline: none;
				    transition: transform 0.2s ease-in-out;
				    transform: translateY(-50px);
				    padding: 30px;
				    padding-top: 20px;
				    overflow: hidden;
				    border-radius: 30px;
				}

				.reject_icon 
				{
				    width: 40px;
				    height: 40px;
				    border-radius: 50%;
				    overflow: hidden;
				    font-size: 44px;
				    margin: auto;
				    position: relative;
				    color: #939393;
				    margin-top: 12px;
				    font-weight: 600;
				    background: #16C188;
				    background: #dd5757;
				}


				.reject_icon:before 
				{
				    display: block;
				    content: "";
				    height: 18px;
				    width: 3px;
				    background-color: #fff;
				    margin: auto;
				    border-radius: 1px;
				    transform: rotate(-45deg);
				    position: absolute;
				    top: 11px;
				    right: 0px;
				    left: 0px;
				    z-index: 1;
				}

				.inner_circle 
				{
				    display: inline-block;
				    width: 40px;
				    height: 40px;
				    position: relative;
				    top: -3px;
				    left: -3px;
				    background: #F66363;
				    border-radius: 50%;
				}


				.reject_icon:after 
				{
				    display: block;
				    content: "";
				    height: 18px;
				    width: 3px;
				    border-radius: 1px;
				    background-color: #fff;
				    position: absolute;
				    margin: auto;
				    top: 11px;
				    transform: rotate(45deg);
				    right: 0px;
				    left: 0px;
				}

				.grn_text 
				{
					font: normal normal 600 24px/19px Zoho Puvi;
    				text-align: center;
				    color: #000000;
				    font-weight: 500;
				    font-size: 18px;
				    margin-top: 18px;
				    font-weight: 600;
				}

				 .defin_text 
				 {
				 	font: normal normal normal 16px/24px Zoho Puvi;
				    text-align: center;
				    margin-top: 10px;
				    font-size: 15px;
				    line-height: 20px;
				}


				.Service_space
				{
					margin-top: 30px

				}
				.service_box
				{
					width: 550px;
				    height: 55px;
				    background: #FFFFFF 0% 0% no-repeat padding-box;
				    border: 1px solid #FFB7B7;
				    border-radius: 6px;
				    opacity: 1;
				    padding: 28px 20px 16px 20px;
				    position: relative;
				    margin: auto;
				    margin-top: 30px;
				}

				.info_text
				{
					width: 550px;
				    height: 55px;
				    text-align: left;
				    letter-spacing: 0px;
				    color: #000000;
				    opacity: 0.8;
				    font-size: 14px;
				}

				.service_info
				{
					display: inline-flex;
				    justify-content: space-around;
				    box-sizing: border-box;
				    max-width: 100%;
				    flex-wrap: nowrap;
				    width: 134px;
				    height: 36px;
				    background: transparent linear-gradient(90deg, #FFEDED 0%, #FFFFFF 100%) 0% 0% no-repeat padding-box;
				    border: 1px solid #FFB7B7;
				    border-radius: 46px;
				    opacity: 1;
				    position: absolute;
				    top: -18px;
				}

				.service_name
				{
					font: normal normal medium 14px/24px Zoho Puvi;
				    letter-spacing: 0px;
				    color: #000000;
				    opacity: 1;
				    line-height: 2;
				    display: inline-block;
				}

				.footer_warn
				{
					text-align: center;
				    margin-top: 20px;
				    font: normal normal normal 14px/20px Zoho Puvi;
				    letter-spacing: 0px;
				    color: #000000;
				    opacity: 0.7;
				}

				.service_icon
				{
					display: inline-block;
    				font-size: 16px;
					border-radius: 50%;
				    height: 5px;
				    width: 5px;
				    box-sizing: border-box;
				    line-height: 20px;
				    background: #FF8181 0% 0% no-repeat padding-box;
				    opacity: 1;
				    margin-top: 14px;
				    margin-left: -3px;
				}
			
				.service_icon:after 
				{
    				content: "";
				    width: 24px;
				    height: 24px;
				    margin-top: -9px;
				    display: inline-block;
				    background: url(ProductLogo-24.png) no-repeat transparent 0px -1595px;
				    background-size: 100% auto;
				    margin-left: 9px;
				    transform: scale(0.83);
				}



				.icon_assist:after,.icon_zohoassist:after{background-position: 0px 0px;background-size: 24px auto;}
				.icon_zohobooks:after{background-position:0px -29px;background-size: 24px auto;}
				.icon_zohobugtracker:after,.icon_bugtracker:after{background-position:0px -58px;background-size: 24px auto;}
				.icon_campaigns:after,.icon_zohocampaigns:after{background-position:0px -87px;background-size: 24px auto;}
				.icon_zohoconnect:after,.icon_connect:after,.icon_zohopulse:after{background-position:0px -116px;background-size: 24px auto;}
				.icon_zohocontactmanager:after,.icon_contactmanager:after{background-position:0px -145px;background-size: 24px auto;}
				.icon_zohocreator:after,.icon_creator:after{background-position:0px -174px;background-size: 24px auto;}
				.icon_zohocrm:after,.icon_crm:after{background-position:0px -203px;background-size: 24px auto;}
				.icon_zohodocssync:after,.icon_docs:after{background-position:0px -232px;background-size: 24px auto;}
				.icon_zohoinvoice:after,.icon_invoice:after{background-position:0px -261px;background-size: 24px auto;}
				.icon_zohomail:after,.icon_mail:after,.icon_virtualoffice:after{background-position:0px -290px;background-size: 24px auto;}
				.icon_zohomeetingoutlookplugin:after,.icon_meeting:after,.icon_zohomeeting:after{background-position:0px -319px;background-size: 24px auto;}
				.icon_zohopeople:after,.icon_people:after{background-position:0px -348px;background-size: 24px auto;}
				.icon_zohoprojects:after,.icon_projects:after{background-position:0px -377px;background-size: 24px auto;}
				.icon_recruit:after{background-position:0px -406px;background-size: 24px auto;}
				.icon_zohoanalytics:after,.icon_analytics:after{background-position:0px -435px;background-size: 24px auto;}
				.icon_zohosalesiq:after,.icon_salesiq:after,.icon_livedesk:after{background-position:0px -464px;background-size: 24px auto;}
				.icon_zohosheet:after,.icon_sheet:after{background-position:0px -493px;background-size: 24px auto;}
				.icon_show:after,.icon_zohoshow:after{background-position:0px -522px;background-size: 24px auto;}
				.icon_site24x7:after{background-position:0px -551px;background-size: 24px auto;}
				.icon_sites:after,.icon_samplemerchandise:after{background-position:0px -580px;background-size: 24px auto;}
				.icon_zohosocial:after{background-position:0px -609px;background-size: 24px auto;}
				.icon_zohosubscriptions:after,.icon_subscriptionmanagement-zoho:after{background-position:0px -638px;background-size: 24px auto;}
				.icon_zohodesk:after,.icon_desk:after{background-position:0px -667px;background-size: 24px auto;}
				.icon_onlinesurvey:after,.icon_zohosurvey:after{background-position:0px -696px;background-size: 24px auto;}
				.icon_zohovault:after,.icon_vault:after{background-position:0px -725px;background-size: 24px auto;}
				.icon_writer:after,.icon_zohowriter:after{background-position:0px -754px;background-size: 24px auto;}
				.icon_zohoexpense:after{background-position:0px -783px;background-size: 24px auto;}
				.icon_zohoshowtime:after,.icon_showtime:after,.icon_viewershowtime:after,.icon_viewer:after{background-position:0px -812px;background-size: 24px auto;}
				.icon_zohocalendar:after,.icon_calendar:after{background-position:0px -841px;background-size: 24px auto;}
				.icon_zohoforms:after{background-position:0px -870px;background-size: 24px auto;}
				.icon_wiki:after,.icon_zohowiki:after{background-position:0px -899px;background-size: 24px auto;}
				.icon_zohomotivator:after{background-position:0px -928px;background-size: 24px auto;}
				.icon_zohochat:after,.icon_cliq:after{background-position:0px -957px;background-size: 24px auto;}
				.icon_zohofour:after{background-position:0px -986px;background-size: 24px auto;}
				.icon_zohoinventory:after,.icon_inventory:after{background-position:0px -1015px;background-size: 24px auto;}
				.icon_zohoappcreator:after,.icon_zohomcreator:after{background-position:0px -1044px;background-size: 24px auto;}
				.icon_salesinbox:after{background-position:0px -1073px;background-size: 24px auto;}
				.icon_zohomdm:after,.icon_mobiledevicemanagement:after,.icon_mdmondemand:after{background-position:0px -1102px;background-size: 24px auto;}
				.icon_zohocheckout:after{background-position:0px -1131px;background-size: 24px auto;}
				.icon_zohosign:after{background-position:0px -1160px;background-size: 24px auto;}
				.icon_zohosprints:after,.icon_sprints:after{background-position:0px -1189px;background-size: 24px auto;}
				.icon_zohonotebook:after,.icon_notebook:after{background-position:0px -1218px;background-size: 24px auto;}
				.icon_pagesense:after{background-position:0px -1247px;background-size: 24px auto;}
				.icon_zohoflow:after{background-position:0px -1276px;background-size: 24px auto;}
				.icon_zohobackstage:after{background-position:0px -1305px;background-size: 24px auto;}
				.icon_zohoteamdrive:after,.icon_teamdrive:after,.icon_workdrive:after,.icon_workdrivesync:after{background-position:0px -1334px;background-size: 24px auto;}
				.icon_zohocommerce:after,.icon_zohomerchandise:after{background-position:0px -1363px;background-size: 24px auto;}
				.icon_orchestly:after{background-position:0px -1392px;background-size: 24px auto;}
				.icon_zohoworkerly:after{background-position:0px -1421px;background-size: 24px auto;}
				.icon_zohoofficeintegrator:after,.icon_officeapi:after{background-position:0px -1450px;background-size: 24px auto;}
				.icon_zohomarketinghub:after{background-position:0px -1479px;background-size: 24px auto;}
				.icon_zohopayroll:after{background-position:0px -1508px;background-size: 24px auto;}
				.icon_zohoink:after{background-position:0px -1537px;background-size: 24px auto;}
				.icon_zohobookings:after{background-position:0px -1566px;background-size: 24px auto;}
				.icon_zohoone:after{background-position:0px -1624px;background-size: 24px auto;}
				.icon_bigin:after,.icon_zohobigin:after{background-position:0px -1653px;background-size: 24px auto;}
				.icon_crmplus:after{background-position:0px -1682px;background-size: 24px auto;}
				.icon_zohosd:after{background-position:0px -1711px;background-size: 24px auto;}
				.icon_zoholearn:after{background-position:0px -1740px;background-size: 24px auto;}
				.icon_zohofsm:after{background-position:0px -1769px;background-size: 24px auto;}
				.icon_zohodirectory:after{background-position:0px -1798px;background-size: 24px auto;}
				.icon_zohodeluge:after{background-position:0px -1827px;background-size: 24px auto;}
				.icon_remotely:after{background-position:0px -1856px;background-size: 24px auto;}
				.icon_zoholens:after{background-position:0px -1886px;background-size: 24px auto;}
				.icon_workplace:after{background-position:0px -1915px;background-size: 24px auto;}
				.icon_transmail:after{background-position:0px -1943px;background-size: 24px auto;}
				.icon_zohofinanceplus:after{background-position:0px -1972px;background-size: 24px auto;}
				.icon_it-management:after{background-position:0px -2001px;background-size: 24px auto;}
				.icon_mailapps:after{background-position:0px -2031px;background-size: 24px auto;}
				.icon_peopleplus:after{background-position:0px -2060px;background-size: 24px auto;}
				.icon_zohomarketplace:after{background-position:0px -2088px;background-size: 24px auto;}
				.icon_inventorystocktracker:after{background-position:0px -2118px;background-size: 24px auto;}
				.icon_oneauth:after,.icon_oneauth2\.0:after{background: url(../images/ProductLogo-24-2x.png) no-repeat transparent 0px -4469px/50px auto;border-radius: 50%;width: 50px;height: 50px;margin: 0px;}
				.icon_zohoshifts:after{background-position: 0px -2175px;background-size: 24px auto;}
				.icon_zohocatalyst:after{background-position: 0px -2203px;background-size: 24px auto;}
				.hide
				{
					display: none;
				}
				
				@media only screen and (max-width: 435px) 
				{
					body .info_block
					{
						width: 80%;
					}
					.info_text
					{
						width: auto;
    					height: auto;
					}
					.service_box
					{
   	 					width: auto;
    					height: auto;
					}
				}
			</style>
		</head>
		<body>
			
		<div class="info_block" id="info_block">
			<div class="reject_icon"><span class="inner_circle"></span></div>
			<div class="content_space">
				<div class="grn_text" id="result_content"><%= Util.getI18NMsg(request,"IAM.ADMIN.ACTION.REQUIRED")%></div>
				<div class="defin_text"><%= Util.getI18NMsg(request,"IAM.ADMIN.ACTION.REQUIRED.DESCRIPTION")%></div>
			</div>

			<div class="Service_space">
			<%
				for(String service:serviceSet)
				{
					Org org =(Org) request.getAttribute("org");
					String orgContact=Util.USERAPI.getUserFromZUID(String.valueOf(org.getOrgContact())).getContactEmail();
					String icon="icon_"+service.toLowerCase().replaceAll("\\s", ""); 	//No I18N
			%>
					<div class="service_box">
						<div class="service_info <%=icon%>" id="recovery_user_info" onclick="change_user()">
				            <span class="service_icon"></span>
				            <span class="service_name"><%=service%></span>
			           	</div>
			           	<div class="info_text">
			           		<%= Util.getI18NMsg(request,"IAM.SAML.SERVICE.LICENSE.NOTAVAIBLE.WARNING",orgContact)%>
			           	</div>
		
					</div>	
			<%
				}
			%>
			
			
			</div>

			<div class="footer_warn"><%= Util.getI18NMsg(request,"IAM.SAML.ADMIN.ACTION.FOOTTER")%></div>
		</div>


	   	<div class="zohologo"></div>
		</body>
	</html>
<% 
		
	}
	else
	{
%>
		<html>
		<head>
		<title><%= Util.getI18NMsg(request,"IAM.ZOHO.ACCOUNTS")%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link
			href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700"
			rel="stylesheet">
		</head>
		<style>
		body {
			width: 100%;
			font-family: 'Open Sans', sans-serif;
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
			height: 40px;
			max-width: 200px;
			width: auto;
			background: url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/newZoho_logo.svg")%>") no-repeat transparent;
			margin-bottom: 40px;
			background-position: center;
		}
		
		.error_img {
			display: block;
			height: 300px;
			margin-bottom: 40px;
			width: 100%;
		}
		
		.raodblock {
			background: url(<%=StaticContentLoader.getStaticFilePath("/v2/components/images/roadblock.png")%>) no-repeat transparent;
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
		
		.refresh_btn {
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
		}
	

		@media only screen and (-webkit-min-device-pixel-ratio: 2) , only screen and (
				min--moz-device-pixel-ratio: 2) , only screen and (
				-o-min-device-pixel-ratio: 2/1) , only screen and (
				min-device-pixel-ratio: 2) , only screen and ( min-resolution: 192dpi)
				, only screen and ( min-resolution: 2dppx) {
			.raodblock {
				background: url(<%=StaticContentLoader.getStaticFilePath("/v2/components/images/roadblock@2x.png")%>) no-repeat transparent;
				background-size: auto 100%;
				background-position: center;
			}
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
			<% if(ClientPortalUtil.isClientServer()){ %>
			<div class="container"> 
				<div class="error_img raodblock"></div>
				<div class="heading"><%=errorTitle%></div>
				<div class="discrption"><%=errorDescryption%></div>
			</div>
		</body>
			<%}else{%>
			<div class="container"> 
				<div class="zoho_logo"></div>
				<div class="error_img raodblock"></div>
				<div class="heading"><%=errorTitle%></div>
				<div class="discrption"><%=errorDescryption%></div>
				<div class="refresh_btn" onclick="location.href='/'"><%= Util.getI18NMsg(request,"IAM.GOTO.HOME")%></div>
			</div>
			<footer id="footer"> <%--No I18N--%>
				<%@ include file="../unauth/footer.jspf"%>
			</footer> <%--No I18N--%>
		</body>
		<script>
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
		</script>
			<% } %>
		</html>
<%
	}
%>