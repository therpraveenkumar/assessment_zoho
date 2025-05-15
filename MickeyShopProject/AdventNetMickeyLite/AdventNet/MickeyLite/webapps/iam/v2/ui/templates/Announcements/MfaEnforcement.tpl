<#if ( redirect_to_oneauth?has_content )>
	<#include "../oauth/redirectToPage.tpl">
<#else>
	<!DOCTYPE html>
	<html>
		<head>	
			<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
			<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=5.0" />
	    	<style>
	    		* {
        			text-rendering: geometricPrecision;
      			}
      			body {
        			margin: 0;
        			box-sizing: border-box;
        			font-family: "ZohoPuvi";
      			}
				@font-face {
					font-family: "ZohoPuvi";
					src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.eot")}");
					src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.eot")}") format("embedded-opentype"),
						 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.woff")}") format("woff"),
						 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.ttf")}") format("truetype");
					font-style: normal;
					font-weight: 400;
					text-rendering: optimizeLegibility;
				}
				@font-face {
					font-family: "ZohoPuvi";
					src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.eot")}");
					src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.eot")}") format("embedded-opentype"),
						 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.woff")}") format("woff"),
						 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.ttf")}") format("truetype");
					font-style: normal;
					font-weight: 500;
					text-rendering: optimizeLegibility;
				}
				@font-face {
					font-family: "ZohoPuvi";
					src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.eot")}"); 
					src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.eot")}") format("embedded-opentype"),
						 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.woff")}") format("woff"),
						 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.ttf")}") format("truetype");
					font-style: normal;
					font-weight: 600;
					text-rendering: optimizeLegibility;
				}
				@font-face {
					font-family: "ZohoPuvi";
					src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.eot")}"); /* IE9 Compat Modes */
					src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.eot")}") format("embedded-opentype"),
						 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.woff")}") format("woff"),
						 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.ttf")}") format("truetype");
					font-style: normal;
					font-weight: 700;
					text-rendering: optimizeLegibility;
				}
				@font-face {
					font-family: 'Announcement';
					src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
					src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
						  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
						  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
						  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
					font-weight: normal;
					font-style: normal;
					font-display: block;
				}
				[class^="icon-"], [class*=" icon-"] {
					font-family: 'Announcement' !important;
					speak: never;
					font-style: normal;
					font-weight: normal;
					font-variant: normal;
					text-transform: none;
					line-height: 1;
					-webkit-font-smoothing: antialiased;
					-moz-osx-font-smoothing: grayscale;
				}
				@font-face {
					font-family: 'Devices';
					src:  url('../images/fonts/devices.eot');
					src:  url('../images/fonts/devices.eot') format('embedded-opentype'),
						  url('${SCL.getStaticFilePath("/v2/components/images/fonts/devices.ttf")}') format('truetype'),
						  url('${SCL.getStaticFilePath("/v2/components/images/fonts/devices.woff")}') format('woff'),
						  url('${SCL.getStaticFilePath("/v2/components/images/fonts/devices.svg")}') format('svg');
					font-weight: normal;
					font-style: normal;
					font-display: block;
				}
				[class^="icon2-"], [class*=" icon2-"] {
					font-family: 'Devices' !important;
					speak: never;
					font-style: normal;
					font-weight: normal;
					font-variant: normal;
					text-transform: none;
					line-height: 1;

					-webkit-font-smoothing: antialiased;
					-moz-osx-font-smoothing: grayscale;
				}
				@font-face {
					font-family: 'AccountsUI';
					src:  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.eot')}');
					src:  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.eot')}') format('embedded-opentype'),
						  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.ttf')}') format('truetype'),
						  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.woff')}') format('woff'),
						  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.woff2')}') format('woff2'),
						  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.svg')}') format('svg');
						  font-weight: normal;
						  font-style: normal;
						  font-display: block;
				}
				[class^="icon3-"], [class*=" icon3-"] {
  				font-family: 'AccountsUI' !important;
  				speak: never;
  				font-style: normal;
  				font-weight: normal;
  				font-variant: normal;
  				text-transform: none;
  				line-height: 1;

  				-webkit-font-smoothing: antialiased;
  				-moz-osx-font-smoothing: grayscale;
				}
				
				.radio-cont {
					display: none;
				}

			</style>

			<script>
				var nModes;
				<#if mfa_data??>
					var mfaData = ${mfa_data};
					var alreadyConfiguredModes = ${mfa_data.modes};
					var isMobile = ${is_mobile?c};
					var modesContainerMap = { otp: 'sms', devices: 'oneauth', yubikey: 'yubikey', totp: 'totp'}
				</#if>
				var mandatebackupconfig = ${mandate_backup_codes?c};
				var isBioEnforced =<#if oneauth_bio_type?has_content> true<#else> false</#if>
				var showMobileNoPlaceholder = ${mob_plc_holder?c};
				var csrfParam= "${za.csrf_paramName}";
				var csrfCookieName = "${za.csrf_cookieName}";
				var contextpath = <#if context_path??>"${context_path}"<#else> "" </#if>;
				<#if nxt_preann_url??>var next = '${Encoder.encodeJavaScript(nxt_preann_url)}'</#if>
			</script>
		</head>
		<body>

			<#include "../zoho_line_loader.tpl">
			<link rel="stylesheet" href="${SCL.getStaticFilePath("/v2/components/css/mfaenforcement.css")}" type="text/css"/>
			<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
			<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")}" defer type="text/javascript"></script>
			<script src="${SCL.getStaticFilePath("/v2/components/js/common_unauth.js")}" type="text/javascript"></script>
			<script src="${SCL.getStaticFilePath("/v2/components/js/splitField.js")}" defer type="text/javascript"></script>
			<script src="${SCL.getStaticFilePath("/v2/components/js/webauthn.js")}" defer type="text/javascript" defer></script>
		    <script src="${SCL.getStaticFilePath("/v2/components/js/phonePatternData.js")}" defer type="text/javascript"></script>
		    <script src="${SCL.getStaticFilePath("/v2/components/js/zresource.js")}" type="text/javascript"></script>
			<script src="${SCL.getStaticFilePath("/v2/components/js/uri.js")}" type="text/javascript"></script>
			<script src="${SCL.getStaticFilePath("/v2/components/js/mfa-enforcement.js")}" type="text/javascript"></script>
			
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Announcement_oneauth_scan.png")}" type="image/png" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Playstore_svg.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Appstore_svg.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Macstore_svg.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Winstore_svg.svg")}" type="image/svg+xml" crossorigin="anonymous">			
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}" type="font/ttf" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.woff")}" type="font/woff" crossorigin="anonymous">
			<script type="text/javascript">
				I18N.load({
					"IAM.PHONE.INVALID.VERIFY_CODE" : '<@i18n key="IAM.PHONE.INVALID.VERIFY_CODE"/>',
					"IAM.ERROR.EMPTY.FIELD" : '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
					"IAM.SEARCHING" : '<@i18n key="IAM.SEARCHING" />',
					"IAM.ERROR.ENTER.VALID.OTP" : '<@i18n key="IAM.ERROR.ENTER.VALID.OTP" />',
					"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND" />',
					"IAM.ENTER.CODE": '<@i18n key="IAM.ENTER.CODE" />',
					"IAM.VERIFIED": '<@i18n key="IAM.VERIFIED" />',
					"IAM.PLEASE.CONNECT.INTERNET": '<@i18n key="IAM.PLEASE.CONNECT.INTERNET" />',
					"IAM.ERROR.SESSION.EXPIRED": '<@i18n key="IAM.ERROR.SESSION.EXPIRED" />',
					"IAM.USER.CREATED.TIME.ADDED": '<@i18n key="IAM.USER.CREATED.TIME.ADDED" />',
					"IAM.VERIFY": '<@i18n key="IAM.VERIFY" />',
					"IAM.MFA.ANNOUN.SUCC.HEAD": '<@i18n key="IAM.MFA.ANNOUN.SUCC.HEAD" />',
					"IAM.MFA.SHOW.OTHER.MODE.2": '<@i18n key="IAM.MFA.SHOW.OTHER.MODE.2" />',
					"IAM.MFA.CONFIRM.DELETE.MODE": '<@i18n key="IAM.MFA.CONFIRM.DELETE.MODE" />',
					"IAM.TFA.BACKUP.ACCESS.CODES": '<@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" />',
					"IAM.GENERATEDTIME": '<@i18n key="IAM.GENERATEDTIME" />',
					"IAM.TFA.BACKUP.ACCESS.CODES": '<@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" />',
					"IAM.JUST.NOW": '<@i18n key="IAM.JUST.NOW" />',
					"IAM.CONFIGURE": '<@i18n key="IAM.CONFIGURE" />',
					"IAM.MFA.ANNOUN.USE.SAME.CONFIGURE": '<@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" />',
					"IAM.MFA.ANNOUN.USE.SAME.ENABLE": '<@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" />',
				});
				<#if allow_yubikey_mode??>
				I18N.load({
				"IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME.ERROR" : '<@i18n key="IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME.ERROR"/>',
					"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.REGISTRATION.TIMEOUT" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.REGISTRATION.TIMEOUT" />',
					"IAM.WEBAUTHN.ERROR.BrowserNotSupported" : '<@i18n key="IAM.WEBAUTHN.ERROR.BrowserNotSupported" />',
					"IAM.WEBAUTHN.ERROR.InvalidResponse" : '<@i18n key="IAM.WEBAUTHN.ERROR.InvalidResponse" />',
					"IAM.WEBAUTHN.ERROR.NotAllowedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotAllowedError"/>',
					"IAM.WEBAUTHN.ERROR.InvalidStateError":'<@i18n key="IAM.WEBAUTHN.ERROR.InvalidStateError"/>',
					"IAM.WEBAUTHN.ERROR.NotSupportedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotSupportedError"/>',
					"IAM.WEBAUTHN.ERROR.ErrorOccurred":'<@i18n key="IAM.WEBAUTHN.ERROR.ErrorOccurred"/>',
					"IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED":'<@i18n key="IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED"/>',
					"IAM.WEBAUTHN.ERROR.AbortError": '<@i18n key="IAM.WEBAUTHN.ERROR.AbortError" />',
					"IAM.MFA.YUBIKEY" : '<@i18n key="IAM.MFA.YUBIKEY" />',
					"IAM.TFA.PASSKEY.NAME.MAX.LENGTH.ERROR" : '<@i18n key="IAM.TFA.PASSKEY.NAME.MAX.LENGTH.ERROR" arg0="50"/>',
					"IAM.YUBIKEY.CONFIGURED.ONE": '<@i18n key="IAM.YUBIKEY.CONFIGURED.ONE" />',
					"IAM.YUBIKEY.CONFIGURED.MANY": '<@i18n key="IAM.YUBIKEY.CONFIGURED.MANY" />',
					"IAM.MFA.ANNOUN.YUBI.MANY.DESC": '<@i18n key="IAM.MFA.ANNOUN.YUBI.MANY.DESC" />',
					"IAM.MFA.ANNOUN.YUBI.ONE.DESC": '<@i18n key="IAM.MFA.ANNOUN.YUBI.ONE.DESC" />',
					"IAM.TFA.YUBIKEY.EXIST.MSG": '<@i18n key="IAM.TFA.YUBIKEY.EXIST.MSG" />',
				});
				</#if>
				<#if allow_sms_mode??>
				 I18N.load({
				 	"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
					"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN" />',
					"IAM.TFA.RESEND.OTP" : '<@i18n key="IAM.TFA.RESEND.OTP" />',
					"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS" />',
					"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING" />',
				 	"IAM.MFA.ANNOUN.SMS.SWAP.HEADING" : '<@i18n key="IAM.MFA.ANNOUN.SMS.SWAP.HEADING" />',
				 	"IAM.MOBILE.NUMBER" : '<@i18n key="IAM.MOBILE.NUMBER" />',
				 	"IAM.MFA.ANNOUN.SMS.PREF.LABEL":'<@i18n key="IAM.MFA.ANNOUN.SMS.PREF.LABEL" />',
				 	"IAM.MFA.ANNOUN.SMS.PREF.LABEL.DESC":'<@i18n key="IAM.MFA.ANNOUN.SMS.PREF.LABEL.DESC" />',
					"IAM.MFA.ANNOUN.SMS.SWAP.HEADING": '<@i18n key="IAM.MFA.ANNOUN.SMS.SWAP.HEADING" />',
					"IAM.NUMBER.CONFIGURED.ONE": '<@i18n key="IAM.NUMBER.CONFIGURED.ONE" />',
					"IAM.NUMBER.CONFIGURED.MANY": '<@i18n key="IAM.NUMBER.CONFIGURED.MANY" />',
					"IAM.MFA.ANNOUN.SMS.MANY.DESC": '<@i18n key="IAM.MFA.ANNOUN.SMS.MANY.DESC" />',
					"IAM.MFA.ANNOUN.SMS.ONE.DESC": '<@i18n key="IAM.MFA.ANNOUN.SMS.ONE.DESC" />',
				 });
				 var IPcountry = "${req_country}";
				 </#if>
				 <#if allow_oneauth_mode??>
				 I18N.load({
				 	"IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.HEAD" : '<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.HEAD" />',
				 	"IAM.DEVICE" : '<@i18n key="IAM.DEVICE" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL.DESC":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL.DESC" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL.DESC":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL.DESC" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.BIO.POP.HEAD":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.POP.HEAD" />',
				 	"IAM.ZOHO.ONEAUTH.APP": '<@i18n key="IAM.ZOHO.ONEAUTH.APP" />',
				 	"IAM.DEVICE.CONFIGURED.ONE": '<@i18n key="IAM.DEVICE.CONFIGURED.ONE" />',
					"IAM.DEVICE.CONFIGURED.MANY": '<@i18n key="IAM.DEVICE.CONFIGURED.MANY" />',
				 })
				 var fontDevicesToHtmlElement = {
					"samsung" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan samsunggrad"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>',
					"samsungtab" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan samsungtabgrad"></span><span class="path4"></span><span class="path5"></span>',
					"macbook" : '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4 gradientspan macbookgrad"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>',
					"iphone" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan iphonegrad"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span>',
					"ipad" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan ipadgrad"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>',
					"pixel" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan pixelgrad" style=""></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span><span class="path9"></span>',
					"oneplus" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan oneplusgrad" style=""></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span><span class="path9"></span>',
					"oppo" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan oppograd" style=""></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span>',
					"mobile_uk" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan mobile_ukgrad"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>'
				 }
				 </#if>
				 <#if allow_totp_mode??>
				 I18N.load({
				 "IAM.AUTHENTICATR.APP" : '<@i18n key="IAM.AUTHENTICATR.APP" />',
				 "IAM.CONFIGURED" : '<@i18n key="IAM.CONFIGURED" />',
				 "IAM.MFA.ANNOUN.TOTP.CONF": '<@i18n key="IAM.MFA.ANNOUN.TOTP.CONF" />',
				 "IAM.MFA.COPY.CLIPBOARD" : '<@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" />',
				 "IAM.APP.PASS.COPIED" : '<@i18n key="IAM.APP.PASS.COPIED" />',
				 "IAM.TAP.TO.COPY" : '<@i18n key="IAM.TAP.TO.COPY" />',
				 })
				 var totpConfigSize = ${totp_config_size};
				 </#if>
				var contextpath = '${za.contextpath}';
				var accounts_support_contact_email_id = '${support_email}';
				var mobileHeader = {"0": "", "1":"IAM.NUMBER.CONFIGURED.ONE", "2":"IAM.NUMBER.CONFIGURED.MANY"};
				var oneauthHeader = {"0": "", "1":"IAM.DEVICE.CONFIGURED.ONE", "2":"IAM.DEVICE.CONFIGURED.MANY"};
				var yubikeyHeader = {"0": "", "1":"IAM.YUBIKEY.CONFIGURED.ONE", "2":"IAM.YUBIKEY.CONFIGURED.MANY"};
				
			</script> 
			
			<div class="blur"></div> 
			<div id="error_space" class="error_space">
				<span class="error_icon">&#33;</span> <span class="top_msg"></span>
			</div>
			<div class="delete-popup" style="display: none" tabindex="1" onkeydown="escape(event)">
				<div class="popup-header">
        			<div class="popup-heading"><@i18n key="IAM.CONFIRM.POPUP.DELETE.MFA.MODE" /></div>
      			</div>
      			<div class="popup-body">
      			<div class="delete-desc"></div>
      			<button class="confirm-delete-btn common-btn"><span></span><@i18n key="IAM.CONFIRM" /></button>
      			<button class="delete-cancel-btn common-btn cancel-btn" onclick="cancelDelete()"><@i18n key="IAM.CANCEL" /></button>
      			</div>
			</div>
			<div class="msg-popups" style="display: none" tabindex="1" onkeydown="escape(event)">
      			<div class="popup-header">
        			<div class="popup-icon icon-success"></div>
        			<div class="popup-heading"></div>
        			<div class="pop-close-btn" onclick="closePopup()"></div>
      			</div>
      			<div class="popup-body"></div>
    		</div>
    		<div class="generate-backup" style="display: none">
    			<div class="backup-codes-desc old-codes" style="display:none"><@i18n key="IAM.MFA.ANNOUN.SUCC.BKC.OLD" /></div>
    			<div class="backup-codes-desc new-codes"><@i18n key="IAM.MFA.ANNOUN.SUCC.BKC.NEW" /></div>
 				<button class="g-backup common-btn" onclick="generateBackupCode(event);"><span></span><@i18n key="IAM.GENERATE.BACKUP.CODES" /></button>
      			<button class="g-cancel common-btn cancel-btn" onclick="contSignin()"><@i18n key="IAM.CANCEL" /></button>
    		</div>
    		<div class="no-backup-redirect" style="display: none">
    			<div class="backup-codes-desc"><@i18n key="IAM.MFA.ANNOUN.SUCC.NO.BKC.DESC" /></div>
      			<button class="common-btn" onclick="contSignin()"><@i18n key="IAM.CONFIRMATION.CONTINUE" /></button>
    		</div>
    		<div class="backup_code_container" style="display:none">
          		<div class="backup-desc">
					<@i18n key="IAM.BACKUP.CODES.GENERATED.DESC1" /> <@i18n key="IAM.BACKUP.CODES.GENERATED.DESC2" />
		  		</div>
				<div id="bkup_code_space" class="tfa_bkup_grid">
					<div id="bk_codes"></div>
					<div id="bkup_cope">
						<span class="backup_but" id="downcodes"><@i18n key="IAM.DOWNLOAD.APP" /> </span>
						<span class="backup_but tooltipbtn" id="printcodesbutton" onmouseout="remove_copy_tooltip();"><@i18n key="IAM.COPY" /> 
							<span class="tooltiptext copy_to_clpbrd"><@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" /></span>
							<span class="tooltiptext code_copied hide" style="display:none"><span class="tick-mark"></span><@i18n key="IAM.APP.PASS.COPIED" /> </span>
						</span> 
 					</div>
				</div>
        		<div class="down_copy_proceed"><@i18n key="IAM.BACKUP.VERIFY.CODES.PROCEED" /></div>
        		<ul class="mfa_points_list">
 					<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT1" /></li>
					<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT2" /> </li>
					<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT3" /> </li>
		  		</ul>
        		<button class="cont-signin common-btn" onclick="contSignin()" style="display:none"><@i18n key="IAM.CONFIRMATION.CONTINUE" /></button>
        	</div>
        	<#if allow_oneauth_mode??>
			<div class="oneauth-popup" style="display: none">
				<div class="oneauth-headerandoptions2">
				<div class="header-flex">
					<div class="oneauth-header">
						<div class="oneauth-header-icon icon-pebble icon-Zoho-oneAuth-logo"><span class="path1 onelogopop"></span><span class="path2 onelogopop"></span><span class="path3 onelogopop"></span><span class="path4 onelogopop"></span><span class="path5 onelogopop"></span><span class="path6 onelogopop"></span><span class="path7 onelogopop"></span></div>
						<div class="oneauth-header-texts">
							<div class="oneauth-name"><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR" /></div>
							<div class="oneauth-desc"><@i18n key="IAM.ONEAUTH.MFA.TAG" /></div>
						</div>
					</div>
					<div class="oneauth-download-options" style="height: unset;">
						<div  class="oneauth-d-options" style="position: relative;height: unset;">
						<div class="download playstore-icon" onclick="storeRedirect('https://zurl.to/mfa_enforce_oaplay')"></div>
						<div class="download appstore-icon" onclick="storeRedirect('https://zurl.to/mfa_enforce_oaips')"></div>
						<div class="download macstore-icon" onclick="storeRedirect('https://zurl.to/mfa_enforce_oamac')"></div>
						<div class="download winstore-icon" onclick="storeRedirect('https://zurl.to/mfa_enforce_msstore')"></div>
						</div>
					</div>
					</div>
					<div class="scanqr scanqr2">
							<div class="qr-image">
								<div class="top left"></div>
								<div class="top right"></div>
								<div class="bottom right"></div>
								<div class="bottom left"></div>
							</div>
							<div class="scan-desc2"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
					</div>
					<div class="pop-close-btn one-close-btn" onclick="closePopup()"></div>
				</div>
				<div class="oneauth-steps2">
					<div class="oneauth-step-header"><@i18n key="IAM.AFTER.INSTALLING.ONEAUTH" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP1" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP2" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP3" /></div>
					<div class="oneauth-footer"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.TEXT" /> <a href="https://zurl.to/mfa_banner_oaworks" target="_blank" class="onefoot-link"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.LINK" /></a></div>
				</div>
				<button class="common-btn" style="margin-left:30px; margin-top: 0px" onclick="contSignin()"><@i18n key="IAM.ENABLED.MFA" /></button>
			</div>
			<div class="oneauth-bio" style="display:none">
				<div class="bio-steps">
					<div class="oneauth-step"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.STEP1" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.STEP2" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.STEP3" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.STEP4" /></div>
					<div class="note_text"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.NOTE" /></div>
				</div>
				<button class="common-btn s-common-btn" style="margin-left:0px; margin-top: 20px" onclick="showReloginPop()"><@i18n key="IAM.NEXT" /></button>
			</div>
			<div class="oneauth-relogin" style="display:none">
				<div class="relogin-desc">
					<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.DESC" />
				</div>
				<button class="common-btn" onclick="redirectSignin()"><@i18n key="IAM.GO.TO.SIGNIN.PAGE" /></button><button class="common-btn  cancel-btn" onclick="closePopup()"><@i18n key="IAM.CANCEL" /></button>
			</div>
			<div class="app-update" style="display:none">
				<div class="update-app"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL" /> <span class="icon-info"></div>
			</div>
			</#if>
			<#if allow_sms_mode??>
			<div class="number-swap" style="display:none">
				<div class="swap-desc1"><@i18n key="IAM.MFA.ANNOUN.SMS.SWAP.DESC" /></div>
				<button class="confirm-swap common-btn" onclick="swapNumber(event)"><span></span><@i18n key="IAM.SIGNUP.CHANGE" /></button>
				<button class="common-btn cancel-btn" onclick="closePopup()"><@i18n key="IAM.CANCEL" /></button>
			</div>
			</#if>
			<div class="pref-info" style="display:none">
				<div class="pref-text">
					<span></span>
					<span class="pref-icon icon-cinformation"></span>
					<div class="pref-desc"></div>
				</div>
			</div>
			<div class="flex-container" >
				<div class="container" style="display:none">
					<div class="rebrand_partner_logo"></div>
					<div class="announcement_header">
					<div class="enabled-configure" style="display:none"><@i18n key="IAM.MFA.ENFORCE.ENABLED.TITLE"/></div> <div class="nomodes-enable" style="display:none"><@i18n key="IAM.MFA.ENFORCE.TITLE"/></div></div>
					<div class="enforce_mfa_desc many">
					<div class="enabled-configure" style="display:none">
					<@i18n key="IAM.MFA.ENFORCE.ENABLED.MANY.DESC" arg0="${org_name}"/></div>
					<div class="nomodes-enable" style="display:none">
					<@i18n key="IAM.MFA.ENFORCE.MANY.DESC" arg0="${org_name}"/>
					</div>
        			</div>
        			<div class="enforce_mfa_desc one" style="display: none">
					<div class="enabled-configure" style="display:none">
					<@i18n key="IAM.MFA.ENFORCE.ENABLED.ONE.DESC" arg0="${org_name}"/></div>
					<div class="nomodes-enable" style="display:none">
					<@i18n key="IAM.MFA.ENFORCE.ONE.DESC" arg0="${org_name}"/>
					</div>
        			</div>
				<div class="modes-container">
					<#if allow_oneauth_mode??>
          			<div class="oneauth-container mode-cont">
            			<div class="mode-header" onclick="selectandslide(event)" style="padding-right: 0;flex-direction: column ; gap: 20px;">
              				<div class="one-header">
              				<div class="mode-icon icon-pebble icon-Zoho-oneAuth-logo"><span class="path1 onepathlogo"></span><span class="path2 onepathlogo"></span><span class="path3 onepathlogo"></span><span class="path4 onepathlogo"></span><span class="path5 onepathlogo"></span><span class="path6 onepathlogo"></span><span class="path7 onepathlogo"></span></div>
							<div class="mode-header-texts"><span><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR" /><div class="icon3-newtab"></div></span><div class="oneauth-desc or-text"><@i18n key="IAM.ONEAUTH.MFA.TAG" /></div></div>
							<div class="down-arrow" style="display: none"></div>
							<div class="tag">
								<span><@i18n key="IAM.RECOMMENDED" /><span class="icon-Sparkle"></span></span><div class="tag-pins"></div>
								<div class="svg-curve">
								<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="10" height="32" viewBox="0 0 10 32">
									<defs>
										<linearGradient id="linear-gradient" y1="0.548" x2="1" y2="0.55" gradientUnits="objectBoundingBox">
											<stop offset="0" stop-color="#323ec9"/><stop offset="0.493" stop-color="#5360f8"/><stop offset="1" stop-color="#323ec9"/>
    									</linearGradient>
  									</defs>
									<path id="Path_3400" data-name="Path 3400" d="M0,0H5c4.983,0,5-2,5-2V25s0,5-5,5H0Z" transform="translate(0 2)" fill="url(#linear-gradient)"/>
								q</svg>
								</div>
							</div>
							</div>
							<div class="add-oneauth" style="display: none">
								<div class="down-badges">
									<div class="download playstore-icon play-small" onclick="storeRedirect('https://zurl.to/mfa_enforce_oaplay')"></div>
									<div class="download appstore-icon app-small" onclick="storeRedirect('https://zurl.to/mfa_enforce_oaips')"></div>
									<div class="download macstore-icon mac-small" onclick="storeRedirect('https://zurl.to/mfa_enforce_oamac')"></div>
									<div class="download winstore-icon win-small" onclick="storeRedirect('https://zurl.to/mfa_enforce_msstore')"></div>
								</div>
								<div class="add-qr">
									<div class="qr qr-image">
										<div class="top left"></div>
										<div class="top right"></div>
										<div class="bottom right"></div>
										<div class="bottom left"></div>
									</div>
									<div class="qr-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
								</div>
								<div class="general-desc" style="margin-top: 20px;pointer-events:none;"><@i18n key="IAM.MFA.ONEAUTH.INSTALL.ENABLE" /></div>
								<button class="common-btn s-common-btn oneauth-add-link" onclick="showOneauthPop()" style="margin-top: 16px;"><@i18n key="IAM.ENABLE.MFA.ONEAUTH" /></button>
                  			</div>
            			</div>
            			<div class="mode-body">
              				<div class="oneauth-body">
                				<div class="already-verified-app already-cont" style="display: none">
									<#if mfa_data.is_mfa_activated>
									<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
									<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
									<#else>
                					<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									</#if>
									<div class="verified-app-cont cloner" style="display: none" onclick="selectNumberDevice(event)">
                  						<div class="verified-checkbox"></div>
                    					<div class="device-image"></div>
                    					<div class="verified-app-details">
                      						<span class="verified-device name-detail"></span>
                      						<span class="added-period"></span>
                    					</div>
                    					<div class="delete-icon icon-delete" onclick="handleDelete(event, deleteOneAuth, 'oneauth')"></div>
                  					</div>
                  					<button class="add-new-oneauth-but add-new-btn link-btn" onclick="showOneauthPop()"><@i18n key="IAM.ADD.ANOTHER.DEVICE" /></button>
                				</div>
                				
								<div class="warning-msg many" style="display:none">
            						<div class="warning-icon icon-Warning-Icon"></div>
            						<div class="warning-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.WARN" /></div>
            					</div>
								<div class="warning-msg biometric-msg" style="display:none">
									<div class="warning-icon icon-Warning-Icon"></div>
									<div class="warning-desc">
									<div class="warning-heading"><b><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.HEAD" /></b></div> 
									<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.DESC" />
									</div>
									<button class="common-btn s-common-btn enable-bio" onclick="showBioPop()"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.ENABLE.BIOMETRICS" /></button>
								</div>
              				</div>
            			</div>
          			</div>
         			</#if>
         			<#if allow_totp_mode??>
          			<div class="totp-container mode-cont">
            			<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-totp"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.MFA.ANNOUN.TOTP.HEAD" /></span></div>
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
              				<div class="totp-body">
                				<div class="already-totp-conf" style="display: none">
                					<div class="hidden-checkbox"></div>
									<div class="already-totp-conf-desc general-desc add-desc before">
                    					<@i18n key="IAM.MFA.ANNOUN.TOTP.ALREADY.BEFORE" />
                  					</div>
									<div class="already-totp-conf-desc general-desc add-desc after" style="display: none">
										<@i18n key="IAM.MFA.ANNOUN.TOTP.CONF" />
									</div>
									<button class="common-btn s-common-btn verify-btn verify-totp-pro-but" onclick="verifyOldTotp(event)"><@i18n key="IAM.VERIFY" /></button>
                  					<button class="add-new-totp-but link-btn" onclick="addNewTotp(event)"><@i18n key="IAM.CHANGE.CONFIGURATION" /></button>
                  					<button class="delete-totp-conf link-btn" onclick="handleDelete(event,deleteConfTotp, 'totp')"><@i18n key="IAM.DELETE.CONFIGURATION" /></button>
                				</div>
                				<div class="add-new-totp add-new-cont">
                					<div class="add-new-totp-desc general-desc add-desc">
                    					<@i18n key="IAM.MFA.ANNOUN.TOTP.NEW" />
                  					</div>
                  					<button class="add-new-totp-but common-btn s-common-btn" onclick="addNewTotp(event)"><@i18n key="IAM.CONFIGURE" /></button>
                				</div>
                				<div class="new-totp" style="display: none">
                  					<div class="new-totp-codes">
                    					<div class="new-totp-desc general-desc margin-desc"><@i18n key="IAM.MFA.ANNOUN.TOTP.SCAN.NEXT" /></div>
                   						<div class="tfa_setup_work_space">
                      						<div class="key_qr_space">
                        						<div id="tfa_qr_space" class="tfa_qr_space">
                          							<img id="gauthimg" class="qr_tfa" alt="barcode image" />
                        						</div>
                        						<div class="or-text hide"><@i18n key="IAM.OR" /></div>
                       							<div class="qr_key_box" onclick="copyQrKey(this)" onmouseleave="resetTooltipText(this)">
                          							<div class="qr_key_head"><@i18n key="IAM.MANUAL.ENTRY" /></div>
                          							<div class="tooltip-container">
                          								<div class="tfa_info_text" id="skey">
                          								</div>
                          								<div class="tooltip-text"><@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" /></div>
                          							</div>
                          							<div class="qr_key_note"><@i18n key="IAM.TFA.TOTP.SPACE.TIP" /></div>
                        						</div>
                      						</div>
                      						<div class="note_text">
                        						<@i18n key="IAM.USE.AUTH.APP.SETUP.NOTE" />
                      						</div>
											<button class="common-btn s-common-btn leftZero" id="auth_app_confirm" tabindex="0" onclick="showTotpOtp();">
                        						<span><@i18n key="IAM.NEXT" /></span>
                      						</button>
											<button class="common-btn s-common-btn back-btn" onclick="totpAlreadyStepBack()" style="display:none"><span></span><@i18n key="IAM.BACK" /></button>
                    					</div>
                  					</div>
                  					<form name="verify_totp_form" onsubmit="return false" style="display: none">
                    				<div class="totp-verify-desc general-desc margin-desc">
                      					<@i18n key="IAM.VERIFY.TWO.FACTOR.DESC" />
                    				</div>
                    				<div class="totp_input_container">
                      					<label for="totp_input" class="emolabel"><@i18n key="IAM.TFA.ENTER.VERIFICATION.CODE" /></label>
                      					<div id="totp_split_input" class="totp_container"></div>
										<button class="common-btn s-common-btn leftZero verify-btn" onclick="verifyTotpCode(event)"><span></span><@i18n key="IAM.VERIFY" /></button>
										<button class="common-btn s-common-btn back-btn" onclick="totpStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                    				</div>
                  				</form>
                				</div>
              				</div>
            			</div>
          			</div>
         			</#if>	
          			<#if allow_yubikey_mode??>
          			<div class="yubikey-container mode-cont">
            			<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-Yubikey"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.MFA.YUBIKEY" /></span></div>
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
            				<div class="yubikey-body">
            					<div class="already-yubikey-conf already-cont" style="display:none">
            						<div class="hidden-checkbox verified-selected"></div>
									<#if mfa_data.is_mfa_activated>
									<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
									<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
									<#else>
									<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									</#if>
            						<div class="verified-yubikey-cont" style="display:none">
            							<div class="yubikey-image"></div>
            							<div class="verified-yubikey-details">
            								<span class="verified-yubikey name-detail"></span>
                      						<span class="added-period"></span>
            							</div>
            							<div class="delete-icon icon-delete" onclick="handleDelete(event, deleteYubikey, 'yubikey')"></div>
            						</div>
            						<button class="add-new-yubikey-but add-new-btn link-btn" onclick="addNewYubikey(event)"><@i18n key="IAM.ADD.ANOTHER.YUBIKEY" /></button>
            					</div>
            					<div class="add-new-yubikey add-new-cont">
                  					<div class="add-new-yubikey-desc general-desc add-desc">
                    					<@i18n key="IAM.MFA.ANNOUN.YUBI.NEW" />
                  					</div>
                  					<button class="add-new-yubikey-but common-btn s-common-btn" onclick="addNewYubikey(event)"><@i18n key="IAM.CONFIGURE" /></button>
                				</div>
                				<div class="new-yubikey" style="display: none">
                  					<div class="yubikey-one">
									<#if !is_mobile>
                    					<div class="yubikey-one-desc general-desc add-desc"><@i18n key="IAM.MFA.YUBIKEY.INSERT.HEAD" /></div>
                    					<div class="yubikey-insert-desc add-desc" ><@i18n key="IAM.MFA.YUBIKEY.INSERT.DESCRIPTION" /></div>
                    				<#else>
                    					<div class="for_mobile_setup">
											<div id="yubikey_pic" class="yubikey_options">
												<div class="yubikey_anim_container">
													<div class="pic_about_usb"></div>
													<div class="pic_about_nfc"></div>
												</div>
											</div>
											<div class="dot_status">
												<span class="dot dot_1"></span>
												<span class="dot dot_2"></span>
											</div>
											<div class="yubikey_head general-desc"><@i18n key="IAM.MFA.YUBIKEY.INSERT.HEAD.FOR.MOBILE" /></div>
											<div class="yubikey-insert-desc general-desc" ><@i18n key="IAM.MFA.YUBIKEY.INSERT.DESCRIPTION" /></div>
										</div>
                    				</#if>
										<button class="common-btn s-common-btn next-btn" onclick="scanYubikey()"><@i18n key="IAM.NEXT" /></button>
										<button class="common-btn s-common-btn back-btn" onclick="yubikeyStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                  					</div>
                  					<div class="yubikey-two" style="display: none">
                    					<div class="yubikey-two-desc general-desc margin-desc add-desc"><@i18n key="IAM.TFA.YUBIKEY.TOUCH" /></div>
										<button class="waiting-btn common-btn s-common-btn"><@i18n key="IAM.GDPR.DPA.WAITING" /> <span class="dot-flash-cont"><div class="dot-flashing"></div></span></button>
                  					</div>
                  					<div class="yubikey-three" style="display: none">
                  						<form name="yubikey_name_form" onsubmit="return false">
                    						<div class="yubikey-three-desc general-desc margin-desc add-desc"><@i18n key="IAM.MFA.YUBIKEY.HEAD.NAME" /></div>
                    						<div>
                    						<input type="text" placeholder="<@i18n key="IAM.MFA.ANNOUN.YUBI.PLACEHOLDER" />" id="yubikey_input" onkeydown="clearError('#yubikey_input', event)"/>
											</div>
											<button class="common-btn s-common-btn configure-btn" onclick="configureYubikey()"><span></span><@i18n key="IAM.CONFIGURE" /></button>
											<button class="common-btn s-common-btn back-btn" onclick="yubikeyOneStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                    					</form>
                  					</div>
                				</div>
                				<div class="warning-msg" style="display: none">
            						<div class="warning-icon icon-Warning-Icon"></div>
            						<div class="warning-desc"><@i18n key="IAM.MFA.ANNOUN.YUBI.WARN" /></div>
            					</div>
             				</div>
            			</div>
          			</div>
          			</#if>
          			<#if allow_sms_mode??>
					<div class="sms-container mode-cont">
						<div class="mode-header" onclick="selectandslide(event)">
							<div class="mode-icon icon-pebble icon-Mobile"></div>
							<div class="mode-header-texts"><span><@i18n key="IAM.MFA.ANNOUN.SMS.HEAD" /></span></div>
							<div class="down-arrow"></div>
						</div>
            			<div class="mode-body">
              				<div class="sms-body">
                				<div class="already-verified already-cont" style="display: none">
                					<#if mfa_data.is_mfa_activated>
                					<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.SMS.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.SMS.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
                					<#else>
                					<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.SMS.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.SMS.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
                					</#if>
                  					<div class="verified-numb-cont" style="display:none" onclick="selectNumberDevice(event)">
                    					<div class="verified-checkbox"></div>
                    					<div class="verified-numb-details">
                      						<span class="verified-number name-detail"></span>
                      						<span class="added-period"></span>
                    					</div>
                    					<div class="delete-icon icon-delete" onclick="handleDelete(event, deletePhNumber, 'sms')"></div>
                  					</div>
                  					<button class="add-new-number-but add-new-btn link-btn" onclick="addNewNumber(event)"><@i18n key="IAM.ADD.ANOTHER.NUMBER" /></button>
                				</div>
                				<div class="add-new-number add-new-cont">
                  					<div class="add-new-number-desc general-desc add-desc">
                    					<@i18n key="IAM.MFA.ANNOUN.SMS.NEW" />
                  					</div>
                  					<button class="add-new-number-but common-btn s-common-btn" onclick="addNewNumber(event)"><@i18n key="IAM.ADD.PHONE.NUMBER" /></button>
                				</div>
               					<div class="new-number" style="display: none">
                 					<form name="confirm_form" onsubmit="return false">
                    					<div class="new-number-desc general-desc margin-desc add-desc">
                      						<@i18n key="IAM.MFA.ANNOUN.SMS.INPUT.DESC" />
                    					</div>
                    					<div class="mobile_input_container field" id="select_phonenumber">
                      						<label for="mobile_input" class="emolabel"><@i18n key="IAM.MOBILE.NUMBER" /></label>
                      						<label for="countNameAddDiv" class="phone_code_label"></label>
                      						<select
                        						id="countNameAddDiv" data-validate="zform_field"
                        						autocomplete="country-name" name="countrycode"
                        						class="countNameAddDiv" style="width: 300px">
                        						<#list country_code as dialingcode>
                    							<option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>
                    							</#list>
                      						</select>
                      						<input class="textbox mobile_input" tabindex="0"
                       		 					data-validate="zform_field" autocomplete="phonenumber"
                        						onkeydown="clearError('#mobile_input', event)" name="mobile_no"
                        						id="mobile_input" maxlength="15" data-type="phonenumber" type="tel" oninput="allowSubmit(event)"
                      						/>
                      						<div class="already-added-but link-btn" onclick="selectRecoveryNumbers()" style="display:none">
                        						<@i18n key="IAM.MFA.ADD.VERIFIED.MOBILE.NUMBER" />
                      						</div>
                    					</div>
										<button class="common-btn s-common-btn send_otp_btn" type="submit" onclick="sendSms(event)"><@i18n key="IAM.SEND.VERIFY" /><span></span></button>
                    					<button class="common-btn s-common-btn back-btn" onclick="smsAlreadyStepBack()" style="display:none"><@i18n key="IAM.BACK" /></button>
                  					</form>
                  					<div class="already-verified-recovery" style="display:none">
                  						<div class="verified-recovery-desc general-desc margin-desc many add-desc" style="display:none">
                  						<@i18n key="IAM.MFA.ANNOUN.SMS.ALREADY.REC.MANY" />
                  						</div>
                  						<div class="verified-recovery-desc general-desc margin-desc one add-desc" style="display:none">
                  						<@i18n key="IAM.MFA.ANNOUN.SMS.ALREADY.REC.ONE" />
                  						</div>
                  						<div class="suggest-recovery-desc general-desc margin-desc add-desc" style="display:none">
                  						<@i18n key="IAM.MFA.ANNOUN.SMS.SUGGESTION" />
                  						</div>
                  						<div class="already-recovery-desc general-desc margin-desc add-desc" style="display:none">
                  						<@i18n key="IAM.MFA.ANNOUN.SMS.USER.ENTER.REC" />
                  						</div>
                  						<button class="add-new-number-but add-new-btn link-btn" onclick="addNewNumber(event)"><@i18n key="IAM.ADD.PHONE.NUMBER" /></button>
                  					</div>
                					<form name="verify_sms_form" onsubmit="return false" style="display: none">
                    					<div class="otp-sent-desc general-desc margin-desc add-desc">
                      						<@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE" />
                      						<span class="mobileval">
                        						<div class="valuemobile"></div>
                        						<span class="edit_option" onclick="editNumber()"><@i18n key="IAM.EDIT" /></span>
                      						</span>
                    					</div>
                    					<div class="otp_input_container">
                      						<label for="otp_input" class="emolabel"><@i18n key="IAM.TFA.ENTER.VERIFICATION.CODE" /></label>
                      						<div id="otp_split_input" class="otp_container"></div>
											<div class="resend_otp" onclick="resendSms(event)"><span></span><@i18n key="IAM.TFA.RESEND.CODE" /></div>
											<button class="common-btn s-common-btn leftZero verify-btn" onclick="verifySmsOtp(event)"><span></span><@i18n key="IAM.VERIFY" /></button>
                   						</div>
                  					</form>
                				</div>
              				</div>
            			</div>
          			</div>
					</#if>
					<button class="show-all-modes-but link-btn" style="display: none" onclick="showModes()"><@i18n key="IAM.MFA.SHOW.OTHER.MODE.GT.2" /></button>
				</div>
				<button class="common-btn enable-mfa" disabled="disabled" style="margin:30px 0px;display:none" onclick="enableMFA(event)"><span></span>
				<div class="enabled-configure" style="display:none">
				<@i18n key="IAM.CONFIGURE" />
				</div>
				<div class="nomodes-enable" style="display:none">
				<@i18n key="IAM.MFA.ENABLE.MFA" />
				</div>
				</button>
			</div>
      		<div class="illustration-container">
        		<div class="illustration"></div>
			</div>
		</div>

			 
        <link rel="stylesheet" href="${SCL.getStaticFilePath("/accounts/css/flagStyle.css")}" type="text/css"/>
		</body>	
		<script>
			window.onload=function() {
				setTimeout(function(){
					document.querySelector(".load-bg").classList.add("load-fade");
					setTimeout(function(){
						document.querySelector(".load-bg").style.display = "none";
					}, 300)
				}, 500);
				try {
	    			URI.options.contextpath="${za.contextpath}/webclient/v1";//No I18N
					URI.options.csrfParam = "${za.csrf_paramName}";
					URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
					nModes = $(".mode-cont").length;
					<#if allow_totp_mode??>
					splitField.createElement("totp_split_input", {
        		splitCount: totpConfigSize, 
        		charCountPerSplit: 1, 
        		isNumeric: true, 
        		otpAutocomplete: true, 
        		customClass: "customOtp", //No I18N
        		inputPlaceholder: "&#9679;", 
        		placeholder: I18N.get("IAM.ENTER.CODE")
      		});
      		$("#totp_split_input .splitedText").attr("onkeydown", "clearError('#totp_split_input', event)");
      		</#if>
      		function checkConfiguredAllowed(){
      			if(alreadyConfiguredModes.length > 0){
      			var retVal;
      				for(i =0; i< alreadyConfiguredModes.length; i++){
      					var contname = "." + modesContainerMap[alreadyConfiguredModes[i]] + "-container"
      					if(document.querySelector(contname)){
      						var t = false;
      					} else{
      						var t = true;
      					}
      					if(retVal == undefined){
      						retVal =t;
      					} else {
      					retVal = retVal && t
      					}
      				}
      				return retVal;
      			}
      		}
      		$(document).ready(function(){
      			if(mfaData.is_mfa_activated && alreadyConfiguredModes.length>0){
      				$(".enabled-configure").show();
      			} else {
      				$(".nomodes-enable").show();
      			}
      			$(".enable-mfa").show();
      			if(nModes === 1){
      				$(".enforce_mfa_desc.one").show();
      				$(".enforce_mfa_desc.many").hide();
      				$(".mode-cont .radio-cont").hide();
      				$(".mode-header").click();
      			}
      			if(nModes === 2){
      				$(".show-all-modes-but").html(I18N.get("IAM.MFA.SHOW.OTHER.MODE.2"));
      			}
      			<#if allow_sms_mode??>
      			if(mfaData.otp && mfaData.otp.address_mobile && !mfaData.otp.mobile){
      				$(".add-new-cont .add-new-number-but").click();
      				setTimeout(function(){
      					$(document.confirm_form.countrycode).val(mfaData.otp.address_mobile.country_code);
						$(document.confirm_form.countrycode).trigger('change');
      					var addressmob = mfaData.otp.address_mobile.r_mobile.split("-")[1];
      					$("#mobile_input").val(setSeperatedNumber(phoneData[$("#countNameAddDiv").val()], addressmob.toString()));
      					$("#mobile_input")[0].focus();
      				}, 220)
      			}
      			</#if>
      			<#if allow_oneauth_mode??>
					if(nModes > 1 && (alreadyConfiguredModes.length == 0 || mfaData.devices ) || checkConfiguredAllowed() ){
      			 		$(".sms-container, .totp-container, .yubikey-container").slideUp(200);
      			 		$(".show-all-modes-but").slideDown(200);
      			 		$(".oneauth-container .mode-header").click();
      			 		setTimeout(function(){
							$(".container").show();
						},250)
      			 	}
					else{
						$(".container").show();
					}
					if(isMobile){
						if(/Android/i.test(navigator.userAgent)){
							$(".add-oneauth .down-badges .appstore-icon").hide()
							$(".add-oneauth .down-badges .macstore-icon").hide()
						} else if(/iphone|ipad|ipod/i.test(navigator.userAgent)){
							$(".add-oneauth .down-badges .appstore-icon").css({"order":1});
							$(".add-oneauth .down-badges .playstore-icon").hide();
							$(".add-oneauth .down-badges .macstore-icon").hide();
						}
					}
					if(/Mac|Macintosh|OS X/i.test(navigator.userAgent)){
						$(".add-oneauth .down-badges .winstore-icon").hide();
						$(".oneauth-d-options .winstore-icon").hide();
					} else if(/windows|Win|Windows|Trident/i.test(navigator.userAgent)){
						$(".add-oneauth .down-badges .winstore-icon").css({"order":-1});
						$(".add-oneauth .down-badges .macstore-icon").hide();
						$(".oneauth-d-options .macstore-icon").hide();
					}
					else {
						$(".add-oneauth .down-badges .macstore-icon").hide();
						$(".oneauth-d-options .macstore-icon").hide();
					}
					if(/Mac|Macintosh|OS X/i.test(navigator.userAgent) && ($(window).width() < 620 && $(window).width() > 430)){
						$(".playstore-icon, .winstore-icon").hide()
					}
      			 <#else>
      			 	$(".container").show();
      			 </#if>
      		});
				}catch(e){}
				if(alreadyConfiguredModes != undefined && alreadyConfiguredModes.length > 0 ){
					for(var i = 0; i<alreadyConfiguredModes.length; i++){
						displayAlreadyConfigured(alreadyConfiguredModes[i], mfaData[alreadyConfiguredModes[i]]);
					}
				}
			}
			document.querySelector(".modes-container").addEventListener("click", checkEnable);
		</script>
	</html>
</#if>	
	