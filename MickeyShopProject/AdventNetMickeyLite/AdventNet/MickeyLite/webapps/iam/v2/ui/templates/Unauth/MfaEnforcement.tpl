

<#if ( redirect_to_oneauth?has_content )>
	<#include "../oauth/redirectToPage.tpl">
<#else>
	<!DOCTYPE html>
	<html>
		<head>	
			<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
			
			<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}"></script>	
			<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/u2f-api.js")}"></script>
			<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
			<link href="${SCL.getStaticFilePath("/v2/components/css/accountUnauthStyle.css")}" rel="stylesheet"type="text/css">  
			<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
			<script src="${SCL.getStaticFilePath("/v2/components/js/common_unauth.js")}"></script>
			<!-- Commmon webauthn methods moved to webauthn.js and called in mfa.js and signin.js -->
		    <script src="${SCL.getStaticFilePath("/v2/components/js/webauthn.js")}" type="text/javascript" defer></script>
			<script type="text/javascript">
				I18N.load({
					"IAM.PHONE.INVALID.VERIFY_CODE" : '<@i18n key="IAM.PHONE.INVALID.VERIFY_CODE"/>',
					"IAM.ERROR.EMPTY.FIELD" : '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
					"IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME.ERROR" : '<@i18n key="IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME"/>',
					"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
					"IAM.SEARCHING" : '<@i18n key="IAM.SEARCHING" />',
					"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.REGISTRATION.TIMEOUT" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.REGISTRATION.TIMEOUT" />',
					"IAM.ERROR.ENTER.VALID.OTP" : '<@i18n key="IAM.ERROR.ENTER.VALID.OTP" />',
					"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND" />',
					"IAM.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.RESEND.OTP.COUNTDOWN" />',
					"IAM.MOBILE.RESEND" : '<@i18n key="IAM.MOBILE.RESEND" />',
					"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS" />',
					"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING" />',
					"IAM.TFA.BANNER.SUCCESS.BANNER.DESCRIPTION" : '<@i18n key="IAM.TFA.BANNER.SUCCESS.BANNER.DESCRIPTION" />',
					"IAM.TFA.BANNER.SUCCESS.BANNER.DESCRIPTION.YUBIKEY" : '<@i18n key="IAM.TFA.BANNER.SUCCESS.BANNER.DESCRIPTION.YUBIKEY" />',
					"IAM.TFA.BANNER.SUCCESS.CONFIGURE.MSG" : '<@i18n key="IAM.TFA.BANNER.SUCCESS.CONFIGURE.MSG" />',
					"IAM.WEBAUTHN.ERROR.BrowserNotSupported" : '<@i18n key="IAM.WEBAUTHN.ERROR.BrowserNotSupported" />',
					"IAM.WEBAUTHN.ERROR.InvalidResponse" : '<@i18n key="IAM.WEBAUTHN.ERROR.InvalidResponse" />',
					"IAM.WEBAUTHN.ERROR.NotAllowedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotAllowedError"/>',
					"IAM.WEBAUTHN.ERROR.InvalidStateError":'<@i18n key="IAM.WEBAUTHN.ERROR.InvalidStateError"/>',
					"IAM.WEBAUTHN.ERROR.NotSupportedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotSupportedError"/>',
					"IAM.WEBAUTHN.ERROR.ErrorOccurred":'<@i18n key="IAM.WEBAUTHN.ERROR.ErrorOccurred"/>',
					"IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED":'<@i18n key="IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED"/>',
				});
				 
				var err_try_again = '<@i18n key="IAM.ERROR.GENERAL" />';
				var sms_auth_text = '<@i18n key="IAM.TFA.SMS.HEAD" />';
				var contextpath = '${za.contextpath}';
				 <#if ((totp_config_size)?has_content)>
				var totp_size = ${totp_config_size};
				</#if>
				var accounts_support_contact_email_id = '${support_email}';
			</script>
			<script src="${SCL.getStaticFilePath("/v2/components/js/zresource.js")}" type="text/javascript"></script> 
			<script src="${SCL.getStaticFilePath("/v2/components/js/uri.js")}" type="text/javascript"></script>
			<script src="${SCL.getStaticFilePath("/v2/components/js/mfa-enforcement.js")}"></script>
	    	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")}" type="text/javascript"></script>
			
			
		</head>
		
		<body>
			
			<div id="error_space">
				<div class="top_div">
					<span class="cross_mark"> <span class="crossline1"></span> <span
						class="crossline2"></span>
					</span> <span class="top_msg"></span>
				</div>
			</div>
			
			<div class="blur"></div>
			
			
			<div class="mfa_enforce_bg"></div>
				
            <div class="container">
                <div class="header" id="header">
                    <img class="zoho_logo" src="${SCL.getStaticFilePath("/v2/components/images/zoho.png")}">  
                </div>
                
                <div id="result_popup" class="hide result_popup">
                    <div class="success_icon icon-tick"></div>
                    <div class="grn_text"></div>
                    <div class="defin_text success_text"><@i18n key="IAM.MFA.SUCCESS.ENABLED"/></div>
                    <div class="success_details"></div>
					<div class="msg_info">
						<span id="success_msg_txt"></span>, <span class="link_text" onclick="goToTFAPage()"><@i18n key="IAM.TFA.BANNER.SUCCSES.BANNER.GENERATE.BACKUP.BUTTON"/></span>.
					</div>
                    <button class="btn green_btn center_btn" onclick="open_new_link('${nxt_preann_url}')"><@i18n key="IAM.CONFIRMATION.CONTINUE"/></button>
                </div>	
                
                <div class="wrap">  
                    <div class="info">
                        <div class="head_text"><@i18n key="${oneAuthHeading}"/></div>
                
                            <#if ((allowed_mode_count == 1)	&&	((allow_oneauth_mode)?has_content))>
                            
                                                <div class="normal_text"><@i18n key="${oneAuthDesc}" arg0="${org_name}"/></div>
                                                <button name="confirm_btn" class="btn green_btn "  onclick="open_new_link('${oneAuthUrl}')"><@i18n key="IAM.TFA.BANNER.INSTALL.NOW"/></button>
                                                                    
                                        
                            <#else>
                                <#if (allowed_mode_count == 1)>
                                
                                                <div class="normal_text"><@i18n key="IAM.MFA.ENFORCE.DESC" arg0="${org_name}"/></div>
                                            
                                <#else>
                    
                                                <div class="normal_text"><@i18n key="IAM.MFA.ENFORCE.OPTIONS.DESC" arg0="${org_name}"/></div>
                                </#if>
                                                
                                <#if ((allow_oneauth_mode)?has_content)>
                                    
                                                <div class="selectedbox" onclick="select_mode(this)" id="oneauthmode_div">
                                                    <div class="radio_btn">
                                                        <input id="oneauthmode" type="radio" name="selectmode" class="realradiobtn" checked="checked">
                                                        <span class="radiobtn_style radio_on"></span>
                                                        <label class="radiobtn_text" for=""><@i18n key="${oneAuthTitle}"/></label>
                                                    </div>	
                                                    <div class="mode_description">
                                                        <div class="text"><@i18n key="${oneAuthSupportedList}"/> </div>
                                                        <div class="download_link">
                                                            <button  name="confirm_btn" class="btn green_btn "  onclick="open_new_link('${oneAuthUrl}')"><@i18n key="IAM.TFA.BANNER.INSTALL.NOW"/></button>
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                                
                                </#if>
                                
                                
                                <#if ((allow_sms_mode)?has_content)>	
                                
                                                <div class="selectedbox " onclick="select_mode(this)" id="smsmode_div">
                                                    
                                                    <div class="radio_btn">
                                                        <input id="gauthmode" type="radio" name="selectmode" class="realradiobtn">
                                                        <span class="radiobtn_style radio_on"></span>
                                                        <label class="radiobtn_text" for=""><@i18n key="IAM.MOBILE.NUMBER"/></label>
                                                    </div>	
                                                    
                                                    <div class="mode_description" id="sms_mode_desc">
                                                        <div class="text" id="enter_your_mob_msg"><@i18n key="IAM.TFA.BANNER.ENTER.MOBILE.DESC"/></div>
                                                    </div>
                                                    
                                                    <div id="ode_container" class="hide">
                                                    
                                                        <div class="verify_box_with_btn" id="get_mobile">
															<form onsubmit="return false;" novalidate autocomplete="off">
                                                            <select id="combobox">
                                                                <#list country_code as dialingcode>
                                                                    <option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>                          			
                                                                </#list>
                                                            </select> 
                                                            
                                                            <input id="mobilenumber" onkeypress="err_remove()" maxlength="15" oninput="this.value=this.value.replace(/[^+\d]+/g,'')" type="text" class="verify_textbox">
                                                            
                                                            <button class="verify_textend_btn" id="sendcodebtn" onclick="addmobile()"><@i18n key="IAM.TFA.BANNER.SEND.CODE"/></button>
                                                            </form>
                                                        </div>
                                                    
                                                    </div>
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    <div id="verify_mobile" class="mode_verify hide">
                                                        
                                                        <div id="content_verify_edit">
                                                            <span id="edit_mob_msg">
                                                                <@i18n key="IAM.TFA.BANNER.ENTER.CODE"/> 
                                                                <span id="mobile_edit" style="font-weight: bold;"></span> 
                                                                <span id="edit_mob_btn" onclick="editMobile()"><@i18n key="IAM.EDIT"/></span> 
                                                            </span> 
                                                        </div>
                                                        
                                                    </div>
                                                    
                                                    <div class="verify_box_with_btn hide" id="sms_textbox_btn" >
														<form onsubmit="return false;" novalidate autocomplete="off">
                                                        <input type="text" onkeypress="err_remove()" class="verify_textbox" id="verification_code" oninput="this.value = this.value.replace(/[^\d]+/g,'')">
                                                        <button class="verify_textend_btn" id="smsVerifyButton" onclick="verify_sms_code()"><@i18n key="IAM.VERIFY"/> </button>
                                                        <div id="resend_div" class="resend_btn"><@i18n key="IAM.MOBILE.RESEND"/> </div>
                                                        <div class="resend_text otp_sent" id="otp_sent" style="display:none"><@i18n key="IAM.GENERAL.OTP.SENDING"/></div>
                                                        </form>
                                                    </div>
                                                    
                                                </div>
                                
                                </#if>
                                
                                
                                <#if ((allow_totp_mode)?has_content)>
                                
                                                <div class="selectedbox " onclick="select_mode(this)" id="gauthmode_div">
                                                    <div class="radio_btn">
                                                        <input id="gauthmode" type="radio" name="selectmode" class="realradiobtn">
                                                        <span class="radiobtn_style radio_on"></span>
                                                        <label class="radiobtn_text" for=""><@i18n key="IAM.GOOGLE.AUTHENTICATOR"/></label>
                                                    </div>	
                                                    
                                                    <div class="mode_description">
                                                    
                                                        <div id="qr_display_div">
                                                            <span class="qrcode">
                                                                <img class="qrimg" id="gauthimg" alt="barcode image" />
                                                            </span>
                                                            <span class="textwithqr"><@i18n key="IAM.TFA.BANNER.GOOGLE.AUTHENTICATOR.DESCRIPTION"/> </span>
                                                            <div class="manualentrytext">
                                                                <span> <@i18n key="IAM.TFA.BANNER.PROBLEM.SCAN"/> </span> 
                                                                <span id="manual_entry" onclick="manualEntry()" class="resend_btn"> <@i18n key="IAM.TFA.BANNER.MANUAL.ENTRY"/></span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div id="manual_entry_div" class="hide">
                                                            <div id="manual_totp_code"></div>
                                                            <div>
                                                                <span><@i18n key="IAM.TFA.BANNER.TYPE.SECRET"/></scan><br/>
                                                                <span id="scan_entry" onclick="backToQrScan()" class="resend_btn"> <@i18n key="IAM.TFA.BANNER.BACK.TO.SCAN.QR"/></span>
                                                            </div>
                                                            
                                                        </div>
                                                        
                                                    </div>
                                                    
                                                    <div class="verify_box_with_btn hide" id="gauth_textbox_btn">
                                                    	<form onsubmit="return false;" novalidate autocomplete="off">
                                                        <input onkeypress="err_remove()" id="gauth_code" class="verify_textbox" oninput="this.value = this.value.replace(/[^\d]+/g,'')">
                                                        <button class="verify_textend_btn" id="auth_app_confirm" onclick="verify_auth_qr()"><@i18n key="IAM.VERIFY"/></button>	
                                                        </form>								
                                                    </div>
                                                        
                                                </div>
                                                
                                </#if>
                                
                                <#if ((allow_yubikey_mode)?has_content)>
                                
                                                <div class="selectedbox " onclick="select_mode(this)" id="yubikeymode_div">
                                                    <div class="radio_btn">
                                                        <input id="	" type="radio" name="selectmode" class="realradiobtn">
                                                        <span class="radiobtn_style radio_on"></span>
                                                        <label class="radiobtn_text" for=""><@i18n key="IAM.MFA.YUBIKEY"/></label>
                                                    </div>	
                                                    
                                                    <div class="mode_description" id="first_step">
                                                        <div class="text"><@i18n key="IAM.MFA.YUBIKEY.INSERT.HEAD"/> </div>
                                                        <div class="download_link">
                                                            <button  name="confirm_btn" class="btn green_btn "  onclick="show_yubikey_configure()"><@i18n key="IAM.NEXT"/></button>
                                                        </div>
                                                        
                                                    </div>
                                                    
                                                    <div class="mode_verify" id="second_step">
                                                        <div class="text"><@i18n key="IAM.TFA.YUBIKEY.TOUCH"/> </div>
                                                        <div class="download_link">
                                                            <button  name="confirm_btn" id="ubkey_wait_butt" class="btn green_btn" ><@i18n key="IAM.GDPR.DPA.WAITING" /></button>
                                                            <button  name="confirm_btn" id="ubkey_tryagain_butt" class="btn green_btn hide" onclick="yubikey_register()" ><@i18n key="IAM.YUBIKEY.TRY.AGAIN" /> </button>
                                                            <button  name="confirm_btn" onclick="show_yubikey_step1()" class="btn green_btn hide" ><@i18n key="IAM.BACK" /></button>
                                                        </div>
                                                        
                                                    </div>
                                                    
                                                    <div class="mode_verify" id="third_step">
                                                        <div class="text"><@i18n key="IAM.YUBIKEY.NAME.DESC"/> </div>
                                                    </div>
                                                    
                                                    <div class="verify_box_with_btn hide" id="yubikey_textbox_btn">
                                                    	<form onsubmit="return false;" novalidate autocomplete="off">
                                                        <input onkeypress="err_remove()" id="yubikey_name" class="verify_textbox">
                                                        <button class="verify_textend_btn" id="yubikey_name_confirm" onclick="configure_yubikey()"><@i18n key="IAM.CONFIGURE"/></button>
                                                        </form>									
                                                    </div>
                                
                                                </div>
                                
                                </#if>
                                
                            </#if>	
                    </div>
                </div>
            </div>
					 
            <#include "footer.tpl">
					 
	    	
	    	
		</body>	
		<script>
			window.onload=function() {
				try {
	    			URI.options.contextpath="${za.contextpath}/webclient/v1";//No I18N
					URI.options.csrfParam = "${za.csrf_paramName}";
					URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
				}catch(e){}
				$(".selectedbox:first").click();
			}
		</script>
	</html>
</#if>	
	