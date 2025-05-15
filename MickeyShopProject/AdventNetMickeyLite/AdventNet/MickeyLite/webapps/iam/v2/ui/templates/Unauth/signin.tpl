<!DOCTYPE html>
<meta name="IE_Compatible" http-equiv="X-UA-Compatible" content="IE=edge" />
<#if (signin.isQRLogin) >
	<#if (signin.partnerName == "arattai") >
		<#include "Weblogin.tpl">
	<#else>
		<#include "smartsignin.tpl">
	</#if>
<#else>
<html lang=<#if (('${signin.service_language}')?has_content)>"${signin.service_language}"<#else>"en"</#if>>
	<head>
		<style type="text/css">
			.signin_box {
				width: 500px;
				min-height: 520px;
				height: auto;
				background: #fff;
				box-sizing: border-box;
				padding: 50px 50px;
				border-radius: 2px;
				transition: all .1s ease-in-out;
				float: left;
				overflow-y: auto;
				display: table-cell;
				border-right: 2px solid #f1f1f1;
			}
			@media (min-width: 600px) and (max-width: 1024px) {
				.signin_box {   
					width: 100%;
					border-right: none;
			    }
			}
			@media only screen and (max-width: 600px) {
				.signin_box {   
					width: 100%;
				    padding: 0px 30px;
				    height: auto;
				    border-right: none;
			    }
			}
			.load-bg{top:0px}
			.darkmode .load-bg{background-color: #191A23}
		</style>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
        <link rel="preload" as="script" href="${za.wmsjsurl}">
        <#if signin.isEnabledZTM>
			<!-- Zoho Tag Manager -->
			<script type="text/javascript" defer>(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="//zohotagmanager.cdn.pagesense.io/ztmjs/a298f0ccdb294c7594b9b37933ea4a5e.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>
			<!-- End Zoho Tag Manager -->
		</#if>
		
		<meta name="robots" content="noindex, nofollow"/>
        <script type='text/javascript'>
        	var serviceUrl,serviceName=undefined;
			var csrfParam= "${za.csrf_paramName}";
			var csrfCookieName = "${za.csrf_cookieName}";
			var resetPassUrl = '${signin.resetPassUrl}';
			var resetIPUrl = '${signin.resetIPUrl}';
			var queryString = window.location.search.substring(1);
			var signup_url =  getSignupUrl();
			var signinParams= getSigninParms();
			var isMobile = parseInt('${signin.isMobile}');
			var loginID = "${Encoder.encodeJavaScript(signin.loginId)}";
			var isCaptchaNeeded ="${signin.captchaNeeded}";
			var UrlScheme = "${signin.UrlScheme}";
			var iamurl="${signin.iamurl}";
			var displayname = "${signin.app_display_name}";
			var reqCountry="${signin.reqCountry}";
			var cookieDomain="${signin.cookieDomain}";
			var iam_reload_cookie_name="${signin.iam_reload_cookie_name}";
			var isDarkMode = parseInt("${signin.isDarkmode}");
			var isMobileonly = 0;
			var uriPrefix = '${signin.uri_prefix}';
			var isClientPortal = parseInt("${signin.isClientPortal}");
			var contextpath = "${za.contextpath}";
			var enableServiceBasedBanner = parseInt('${signin.enableServiceBasedBanner}');
			var CC = '${signin.CC}';
			var isHideFedOptions = parseInt('${signin.showIdps}');			
			var accounts_support_contact_email_id = '${signin.accounts_support_contact_email_id}';
			var isneedforGverify = Boolean("<#if signin.isGoogleVerifyNeeded>true</#if>");
			var trySmartSignin = parseInt('${signin.trySmartSignin}');
			var docHead = document.head || document.getElementsByTagName("head" )[0] || document.documentElement;
			var passkeyURL = '${signin.passkeyURL}';
			var isPreview = false;
			var suspisious_login_link = '${signin.suspisious_login_learn_more_link}';
			var canShowResetIP='${signin.canShowResetIP}';
			var I18N = {
				data : {},
				load : function(arr) {
					$.extend(this.data, arr);
					return this;
				},
				get : function(key, args) {
					// { portal: "IAM.ERROR.PORTAL.EXISTS" }
					if (typeof key == "object") {
						for ( var i in key) {
							key[i] = I18N.get(key[i]);
						}
						return key;
					}
					var msg = this.data[key] || key;
					if (args) {
						arguments[0] = msg;
						return Util.format.apply(this, arguments);
					}
					return msg;
				}
			};
			function includeScript(url, callback) {
				var script = document.createElement("script"); 
				script.src = url; 
				script.async = false;
				if (callback) { 
					script.onload = script.onreadystatechange = function() { 
						if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete") {
							callback(); 
							script.onload = script.onreadystatechange = null; // To avoid calling repeatedly in IE 
						}
					};
				}
				docHead.appendChild(script); 
			};
			function onZAScriptLoad(){
				I18N.load({
					"IAM.ZOHO.ACCOUNTS" : '<@i18n key="IAM.ZOHO.ACCOUNTS" />',
					"IAM.ERROR.ENTER_PASS" : '<@i18n key="IAM.ERROR.ENTER_PASS" />',
					"IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" />',
					"IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" />',
					"IAM.SIGNIN" : '<@i18n key="IAM.SIGN_IN" />', 
					"IAM.VERIFY" : '<@i18n key="IAM.VERIFY" />',
					"IAM.GOOGLE.AUTHENTICATOR" : '<@i18n key="IAM.GOOGLE.AUTHENTICATOR" />',
					"IAM.NEW.SIGNIN.SMS.MODE" : '<@i18n key="IAM.NEW.SIGNIN.SMS.MODE" />',
					"IAM.NEW.SIGNIN.TOTP" : '<@i18n key="IAM.NEW.SIGNIN.TOTP" />',
					"IAM.NEW.SIGNIN.TOTP.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.TOTP.HEADER" />',
					"IAM.NEW.SIGNIN.VERIFY.PUSH" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.PUSH" />',
					"IAM.NEW.SIGNIN.VERIFY.CODE" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.CODE" />',
					"IAM.NEW.SIGNIN.TOUCHID.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.TOUCHID.TITLE" />',
					"IAM.NEW.SIGNIN.QR.CODE" : '<@i18n key="IAM.NEW.SIGNIN.QR.CODE" />',
					"IAM.NEW.SIGNIN.FACEID.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.FACEID.TITLE" />',
					"IAM.NEW.SIGNIN.ENTER.EMAIL.OR.MOBILE" : '<@i18n key="IAM.NEW.SIGNIN.ENTER.EMAIL.OR.MOBILE" />',
					"IAM.NEW.SIGNIN.OTP.SENT.DEVICE" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT.DEVICE" />',
					"IAM.NEW.SIGNIN.OTP.SENT" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT" />',
					"IAM.NEW.SIGNIN.OTP" : '<@i18n key="IAM.NEW.SIGNIN.OTP" />',
					"IAM.NEW.SIGNIN.TOUCHID.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.TOUCHID.HEADER" />',
					"IAM.NEW.SIGNIN.FACEID.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.FACEID.HEADER" />',
					"IAM.PUSH.RESEND.NOTIFICATION" : '<@i18n key="IAM.PUSH.RESEND.NOTIFICATION" />',
					"IAM.RESEND.PUSH.MSG" : '<@i18n key="IAM.RESEND.PUSH.MSG" />',
					"IAM.NEXT" : '<@i18n key="IAM.NEXT" />',
					"IAM.NEW.SIGNIN.ENTER.VALID.BACKUP.CODE" : '<@i18n key="IAM.NEW.SIGNIN.ENTER.VALID.BACKUP.CODE" />',
					"IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.NEW" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.NEW" />',
					"IAM.NEW.SIGNIN.FEDERATED.USER.ERROR" : '<@i18n key="IAM.NEW.SIGNIN.FEDERATED.USER.ERROR" />',
					"IAM.TFA.USE.BACKUP.CODE" : '<@i18n key="IAM.TFA.USE.BACKUP.CODE" />',
					"IAM.NEW.SIGNIN.CANT.ACCESS" : '<@i18n key="IAM.NEW.SIGNIN.CANT.ACCESS" />',
					"IAM.NEW.SIGNIN.USING.OTP" : '<@i18n key="IAM.NEW.SIGNIN.USING.OTP" />',
					"IAM.SIGNIN.KEEP.ME" : '<@i18n key="IAM.SIGNIN.KEEP.ME" />',
					"IAM.BACKUP.VERIFICATION_CODE" : '<@i18n key="IAM.BACKUP.VERIFICATION_CODE" />',
					"IAM.NEW.SIGNIN.BACKUP.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.BACKUP.HEADER" />',
					"IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE" />',
					"IAM.NEW.SIGNIN.KEEP.ACCOUNT.SECURE" : '<@i18n key="IAM.NEW.SIGNIN.KEEP.ACCOUNT.SECURE" />',
					"IAM.NEW.SIGNIN.ONEAUTH.INFO.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.ONEAUTH.INFO.HEADER" />',
					"IAM.HOME.WELCOMEPAGE.SIGNUP.NOW" : '<@i18n key="IAM.HOME.WELCOMEPAGE.SIGNUP.NOW" />',
					"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
					"IAM.NEW.SIGNIN.MFA.SMS.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.MFA.SMS.HEADER" />',
					"IAM.NEW.SIGNIN.YUBIKEY.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.TITLE" />',
					"IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW" />',
					"IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW.FOR.MOBILE" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW.FOR.MOBILE" />',
					"IAM.TFA.TRUST.BROWSER.QUESTION" : '<@i18n key="IAM.TFA.TRUST.BROWSER.QUESTION" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.TOTP" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.TOTP" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.OTP" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.OTP" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.TOUCHID" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.TOUCHID" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.FACEID" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.FACEID" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.YUBIKEY" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.YUBIKEY" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.SCANQR" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.SCANQR" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.PUSH" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.PUSH" />',
					"IAM.TRUST" : '<@i18n key="IAM.TRUST" />',
					"IAM.NOTNOW" : '<@i18n key="IAM.NOTNOW" />',
					"IAM.NEW.SIGNIN.RETRY.YUBIKEY": '<@i18n key="IAM.NEW.SIGNIN.RETRY.YUBIKEY" />',
					"IAM.RECOVERY.MOBILE.LABEL" : '<@i18n key="IAM.RECOVERY.MOBILE.LABEL" />',
					"IAM.MOBILE.OTP.SENT" : '<@i18n key="IAM.MOBILE.OTP.SENT" />',
					"IAM.NEW.SIGNIN.PROBLEM.SIGNIN" : '<@i18n key="IAM.NEW.SIGNIN.PROBLEM.SIGNIN" />',
					"IAM.TOTP.TIME.BASED.OTP" : '<@i18n key="IAM.TOTP.TIME.BASED.OTP" />',
					"IAM.NEW.SIGNIN.PASSWORD.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.PASSWORD.TITLE" />',
					"IAM.NEW.SIGNIN.PASSWORD.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.PASSWORD.HEADER" />',
					"IAM.NEW.SIGNIN.SAML.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.SAML.TITLE" />',
					"IAM.NEW.SIGNIN.SAML.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.SAML.HEADER" />',
					"IAM.NEW.SIGNIN.CHOOSE.OTHER.WAY" : '<@i18n key="IAM.NEW.SIGNIN.CHOOSE.OTHER.WAY" />',
					"IAM.NEW.SIGNIN.OTP.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.OTP.TITLE" />',
					"IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY" />',
					"IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY.DESC" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY.DESC" />',
					"IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" />',
					"IAM.NEW.SIGNIN.VERIFY.VIA.OTP" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.OTP" />',
					"IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH.DESC" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH.DESC" />',
					"IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH"/>',
					"IAM.NEW.SIGNIN.OTP.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.OTP.HEADER" />',
					"IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR.DESC" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR.DESC" />',
					"IAM.NEW.SIGNIN.TRY.ANOTHERWAY":'<@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY"/>',
					"IAM.NEW.SIGNIN.QR.HEADER":'<@i18n key="IAM.NEW.SIGNIN.QR.HEADER"/>',
					"IAM.NEW.SIGNIN.MFA.PUSH.HEADER":'<@i18n key="IAM.NEW.SIGNIN.MFA.PUSH.HEADER"/>',
					"IAM.NEW.SIGNIN.WAITING.APPROVAL":'<@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL"/>',
					"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER":'<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE":'<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE"/>',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED":'<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED"/>',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST":'<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST"/>',
					"IAM.SIGNIN.ERROR.USEREMAIL.NOT.EXIST":'<@i18n key="IAM.SIGNIN.ERROR.USEREMAIL.NOT.EXIST"/>',
					"IAM.NEW.SIGNIN.MFA.TOTP.HEADER":'<@i18n key="IAM.NEW.SIGNIN.MFA.TOTP.HEADER"/>',
					"IAM.NEW.SIGNIN.MFA.PASSWORD.HEADER":'<@i18n key="IAM.NEW.SIGNIN.MFA.PASSWORD.HEADER"/>',
					"IAM.NEW.SIGNIN.MFA.PASSWORD.DESC":'<@i18n key="IAM.NEW.SIGNIN.MFA.PASSWORD.DESC"/>',
					"IAM.NEW.SIGNIN.SERVICE.NAME.TITLE":'<@i18n key="IAM.NEW.SIGNIN.SERVICE.NAME.TITLE"/>',
					"IAM.SIGNIN.ERROR.CAPTCHA.INVALID":'<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.INVALID"/>',
					"IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE":'<@i18n key="IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"/>',
					"IAM.RESETPASS.PASSWORD.MIN.ONLY":'<@i18n key="IAM.RESETPASS.PASSWORD.MIN.ONLY"/>',
					"IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY":'<@i18n key="IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY"/>',
					"IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY":'<@i18n key="IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY"/>',
					"IAM.RESET.PASSWORD.POLICY.CASE.BOTH":'<@i18n key="IAM.RESET.PASSWORD.POLICY.CASE.BOTH"/>',
					"IAM.RESETPASS.PASSWORD.MIN.NO.WITH":'<@i18n key="IAM.RESETPASS.PASSWORD.MIN.NO.WITH"/>',
					"IAM.PASSWORD.POLICY.HEADING":'<@i18n key="IAM.PASSWORD.POLICY.HEADING"/>',
					"IAM.RESETPASS.PASSWORD.MIN":'<@i18n key="IAM.RESETPASS.PASSWORD.MIN"/>',
					"IAM.RESETPASS.PASSWORD.MIN":'<@i18n key="IAM.RESETPASS.PASSWORD.MIN"/>',
					"IAM.INCLUDE":'<@i18n key="IAM.INCLUDE"/>',
					"IAM.NEW.SIGNIN.PASSWORD.EXPIRED.ORG.DESC":'<@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.ORG.DESC"/>',
					"IAM.NEW.SIGNIN.PASSWORD.EXPIRED.ORG.DESC.NOW":'<@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.ORG.DESC.NOW"/>',
					"IAM.ERROR.ENTER.NEW.PASS":'<@i18n key="IAM.ERROR.ENTER.NEW.PASS"/>',
					"IAM.ERROR.PASS.LEN":'<@i18n key="IAM.ERROR.PASS.LEN"/>',
					"IAM.ERROR.PASSWORD.MAXLEN":'<@i18n key="IAM.ERROR.PASSWORD.MAXLEN"/>',
					"IAM.PASSWORD.POLICY.LOGINNAME":'<@i18n key="IAM.PASSWORD.POLICY.LOGINNAME"/>',
					"IAM.ERROR.WRONG.CONFIRMPASS":'<@i18n key="IAM.ERROR.WRONG.CONFIRMPASS"/>',
					"IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.DESC":'<@i18n key="IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.DESC"/>',
					"IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.TITLE":'<@i18n key="IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.TITLE"/>',
					"IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.BUTTON":'<@i18n key="IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.BUTTON"/>',
					"IAM.NEW.SIGNIN.TITLE.RANDOM":'<@i18n key="IAM.NEW.SIGNIN.TITLE.RANDOM"/>',
					"IAM.PLEASE.CONNECT.INTERNET":'<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>',
					"IAM.NEW.SIGNIN.RESEND.OTP":'<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>',
					"IAM.TFA.RESEND.OTP.COUNTDOWN":'<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
					"IAM.NEW.SIGNIN.PASS.PHRASE.TITLE":'<@i18n key="IAM.NEW.SIGNIN.PASS.PHRASE.TITLE"/>',
					"IAM.NEW.SIGNIN.PASS.PHRASE.DESC":'<@i18n key="IAM.NEW.SIGNIN.PASS.PHRASE.DESC"/>',
					"IAM.NEW.SIGNIN.MFA.PASSPHRASE.HEADER":'<@i18n key="IAM.NEW.SIGNIN.MFA.PASSPHRASE.HEADER"/>',
					"IAM.NEW.SIGNIN.MFA.PASSPHRASE.DESC":'<@i18n key="IAM.NEW.SIGNIN.MFA.PASSPHRASE.DESC"/>',
					"IAM.NEW.SIGNIN.PASSPHRASE.RECOVER.HEADER":'<@i18n key="IAM.NEW.SIGNIN.PASSPHRASE.RECOVER.HEADER"/>',
					"IAM.NEW.SIGNIN.BACKUP.RECOVER.HEADER":'<@i18n key="IAM.NEW.SIGNIN.BACKUP.RECOVER.HEADER"/>',
					"IAM.NEW.SIGNIN.PASSPHRASE.RECOVER.TITLE":'<@i18n key="IAM.NEW.SIGNIN.PASSPHRASE.RECOVER.TITLE"/>',
					"IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.TITLE":'<@i18n key="IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.TITLE"/>',
					"IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.DESC":'<@i18n key="IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.DESC"/>',
					"IAM.NEW.SIGNIN.IDENTITY.PROVIDER.TITLE":'<@i18n key="IAM.NEW.SIGNIN.IDENTITY.PROVIDER.TITLE"/>',
					"IAM.NEW.SIGNIN.TRY.ANOTHERWAY.HEADER":'<@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.HEADER"/>',
					"IAM.NEW.SIGNIN.ENTER.VALID.PASSPHRASE.CODE":'<@i18n key="IAM.NEW.SIGNIN.ENTER.VALID.PASSPHRASE.CODE"/>',
					"IAM.NEW.SIGNIN.RIGHT.PANEL.VERIFY.SCANQR":'<@i18n key="IAM.NEW.SIGNIN.RIGHT.PANEL.VERIFY.SCANQR"/>',
					"IAM.NEW.SIGNIN.RIGHT.PANEL.ALLOW.SCANQR":'<@i18n key="IAM.NEW.SIGNIN.RIGHT.PANEL.ALLOW.SCANQR"/>',
					"IAM.NEW.SIGNIN.RIGHT.PANEL.VERIFY.TOTP":'<@i18n key="IAM.NEW.SIGNIN.RIGHT.PANEL.VERIFY.TOTP"/>',
					"IAM.NEW.SIGNIN.RIGHT.PANEL.ALLOW.TOTP":'<@i18n key="IAM.NEW.SIGNIN.RIGHT.PANEL.ALLOW.TOTP"/>',
					"IAM.NEW.SIGNIN.JWT.TITLE":'<@i18n key="IAM.NEW.SIGNIN.JWT.TITLE"/>',
					"IAM.SIGNIN.REMOVE.DOMAIN":'<@i18n key="IAM.SIGNIN.REMOVE.DOMAIN"/>',
					"IAM.NEW.SIGNIN.INVALID.EMAIL.MESSAGE.NEW":'<@i18n key="IAM.NEW.SIGNIN.INVALID.EMAIL.MESSAGE.NEW"/>',
					"IAM.NEW.SIGNIN.EMAIL.TITLE":'<@i18n key="IAM.NEW.SIGNIN.EMAIL.TITLE"/>',
					"IAM.NEW.SIGNIN.RESEND.PUSH":'<@i18n key="IAM.NEW.SIGNIN.RESEND.PUSH"/>',
					"IAM.NEW.SIGNIN.RESEND.PUSH.COUNTDOWN":'<@i18n key="IAM.NEW.SIGNIN.RESEND.PUSH.COUNTDOWN"/>',
					"IAM.NEW.SIGNIN.PUSH.RND.DESC":'<@i18n key="IAM.NEW.SIGNIN.PUSH.RND.DESC"/>',
					"IAM.NO.RESULT.FOUND":'<@i18n key="IAM.NO.RESULT.FOUND"/>',
					"IAM.SEARCHING":'<@i18n key="IAM.SEARCHING"/>',
					"IAM.WEBAUTHN.ERROR.NotAllowedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotAllowedError"/>',
					"IAM.WEBAUTHN.ERROR.InvalidStateError":'<@i18n key="IAM.WEBAUTHN.ERROR.InvalidStateError"/>',
					"IAM.WEBAUTHN.ERROR.BrowserNotSupported" : '<@i18n key="IAM.WEBAUTHN.ERROR.BrowserNotSupported"/>',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.ErrorOccurred":'<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.ErrorOccurred"/>',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.ErrorOccurred":'<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.ErrorOccurred"/>',
					"IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED":'<@i18n key="IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED"/>',
					"IAM.WEBAUTHN.ERROR.AbortError":'<@i18n key="IAM.WEBAUTHN.ERROR.AbortError"/>',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidStateError":'<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidStateError"/>',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidStateError":'<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidStateError"/>',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidResponse":'<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidResponse"/>',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidResponse":'<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidResponse"/>',
					"IAM.PASS_POLICY.HEADING" : '<@i18n key="IAM.PASS_POLICY.HEADING" />',
					"IAM.PASS_POLICY.MIN_MAX" : '<@i18n key="IAM.PASS_POLICY.MIN_MAX" />',
					"IAM.PASS_POLICY.SPL" : '<@i18n key="IAM.PASS_POLICY.SPL" />',
					"IAM.PASS_POLICY.SPL_SING" : '<@i18n key="IAM.PASS_POLICY.SPL_SING" />',
					"IAM.PASS_POLICY.NUM" : '<@i18n key="IAM.PASS_POLICY.NUM" />',
					"IAM.PASS_POLICY.NUM_SING" : '<@i18n key="IAM.PASS_POLICY.NUM_SING" />',
					"IAM.PASS_POLICY.CASE" : '<@i18n key="IAM.PASS_POLICY.CASE" />',
					"IAM.NEW.SIGNIN.VERIFY.EMAIL.DESC" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.EMAIL.DESC" />',
					"IAM.NEW.SIGNIN.VERIFY.EMAIL.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.EMAIL.TITLE" />',
					"IAM.NEW.SIGNIN.VERIFY.EMAIL.OTP.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.EMAIL.OTP.TITLE" />',
					"IAM.NEW.SIGNIN.ENTER.EMAIL.ADDRESS" : '<@i18n key="IAM.NEW.SIGNIN.ENTER.EMAIL.ADDRESS" />',
					"IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE" />',
					"IAM.NEW.SIGNIN.PASSWORDLESS.OTP.VERIFY.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.PASSWORDLESS.OTP.VERIFY.TITLE" />',
					"IAM.NEW.SIGNIN.PASSWORDLESS.EMAIL.VERIFY.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.PASSWORDLESS.EMAIL.VERIFY.TITLE" />',
					"IAM.NEW.SIGNIN.PASSWORDLESS.PROBLEM.SIGNIN.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.PASSWORDLESS.PROBLEM.SIGNIN.HEADER" />',
					"IAM.WEBAUTHN.ERROR.UnknownError" : '<@i18n key="IAM.WEBAUTHN.ERROR.UnknownError" />',
					"IAM.WEBAUTHN.ERROR.HELP.HOWTO" : '<@i18n key="IAM.WEBAUTHN.ERROR.HELP.HOWTO" />',
					"IAM.WEBAUTHN.ERROR.TYPE.ERROR" : '<@i18n key="IAM.WEBAUTHN.ERROR.TYPE.ERROR" />',
					"IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE" />',
					"IAM.NEW.SIGNIN.CONTACT.ADMIN.DESC" : '<@i18n key="IAM.NEW.SIGNIN.CONTACT.ADMIN.DESC" />',
					"IAM.EMAIL.VERIFICATION" : '<@i18n key="IAM.EMAIL.VERIFICATION" />',
					"IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING" : '<@i18n key="IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING" />',
					"IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING" : '<@i18n key="IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING" />',
					"IAM.AC.CHOOSE.OTHER_MODES.DEVICE.HEADING" : '<@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DEVICE.HEADING" />',
					"IAM.NEW.SIGNIN.WHY.VERIFY" : '<@i18n key="IAM.NEW.SIGNIN.WHY.VERIFY" />',
					"IAM.EMPTY.BACKUPCODE.ERROR" : '<@i18n key="IAM.EMPTY.BACKUPCODE.ERROR" />',
					"IAM.SIGNIN.AMFA.VERIFICATION.HEADER" : '<@i18n key="IAM.SIGNIN.AMFA.VERIFICATION.HEADER" />',
					"IAM.AC.VIEW.OPTION" : '<@i18n key="IAM.AC.VIEW.OPTION" />',
					"IAM.NEW.SIGNIN.USING.MOBILE.OTP" : '<@i18n key="IAM.NEW.SIGNIN.USING.MOBILE.OTP" />',
					"IAM.NEW.SIGNIN.USING.EMAIL.OTP" : '<@i18n key="IAM.NEW.SIGNIN.USING.EMAIL.OTP" />',
					"IAM.NEW.GENERAL.SENDING.OTP" : '<@i18n key="IAM.NEW.GENERAL.SENDING.OTP" />'
			});
				$.fn.focus=function(){ 
					if(this.length){
						$(this)[0].focus();
					}
					return $(this);
				}
				$("body").css("visibility", "visible");
				$("#nextbtn").removeAttr("disabled"); 
				<#if (('${signin.idp}')?has_content)>
					handleMfaForIdpUsers('${signin.idp}');
					return false;
				</#if>
				<#if signin.hiderightpanel>
					$(".signin_container").css("maxWidth","500px");
					$(".rightside_box").hide();
					$("#recoverybtn, #problemsignin, .tryanother").css("right","0px");
				</#if>
				onSigninReady();
				<#if signin.isSalesIQBotEnabled & '${signin.salesWidgetCode}'?has_content>
					setTimeout(function() {
					    var headTag=document.getElementsByTagName('head')[0];
					    var salesScript = document.createElement("script");
					    salesScript.setAttribute("type","text/javascript");
					    salesScript.setAttribute("id","zsiqchat");
					    salesScript.innerHTML="var $zoho=$zoho || {};$zoho.salesiq = $zoho.salesiq || {widgetcode: \"${signin.salesWidgetCode}\", values:{},ready:function(){}};var d=document;s=d.createElement(\"script\");s.type=\"text/javascript\";s.id=\"zsiqscript\";s.defer=true;s.src=\"https://salesiq.zoho.com/widget\";t=d.getElementsByTagName(\"script\")[0];t.parentNode.insertBefore(s,t);";
					    headTag.appendChild(salesScript);
					}, ${signin.salesWidgetPopTime});
				</#if>
				<#if (('${signin.loginId}')?has_content)>
					handleCrossDcLookup("${Encoder.encodeJavaScript(signin.loginId)}");
				</#if>
				<#if (('${signin.domainlist}')?has_content)>
					handleDomainForPortal(${signin.domainlist});
				</#if>
				
				fediconsChecking();
			    if(isHideFedOptions === 0){
			    	$(".fed_2show,.line").hide();
			    }
				return false;
			}
			function zaOnLoadHandler() {
				var cssURLs,jsURLs;
				<#if (('${signin.cssURLs}')?has_content)>
					cssURLs = "${signin.cssURLs}";		
				</#if>
				<#if (('${signin.jsURLs}')?has_content)>
					jsURLs = "${signin.jsURLs}";		
				</#if>
				// Include CSS
				if(cssURLs) {
					cssURLs = cssURLs.split(","); 
					for(var i = 0, len = cssURLs.length; i < len; i++) {
						var style = document.createElement("link");
						style.href = cssURLs[i]; 
						style.rel = "stylesheet"; 
						docHead.appendChild(style); 
					}
				}
				
				// Synchronously Include Scripts
				if(jsURLs) {
					jsURLs = jsURLs.split(","); 
					var scriptIdx = 0; 
					(function _jsOnLoad() {
						if (scriptIdx == jsURLs.length) { // Last script, all scripts were loaded. So, call the users handler.  
							onZAScriptLoad();
						}else{
							var jsURL = jsURLs[scriptIdx++]; 
							if((jsURL.indexOf("jquery-3_5_1.min") != -1 && window.I18N)) { // Don't include jQuery, If it is already included in the page.
								 _jsOnLoad(); 
							} else { 
								includeScript(jsURL, _jsOnLoad); 
							}
						}
					})();
				}
			};
			zaOnLoadHandler();
			function getSignupUrl(){
				<#if (('${signin.signupurl}')?has_content)>
					return '${Encoder.encodeJavaScript(signin.signupurl)}';
				<#else>
					var signupurl= "${signin.accountssignupurl}";
					<#if (('${signin.servicename}')?has_content)>
						signupurl += "servicename=" + encodeURIComponent('${Encoder.encodeJavaScript(signin.servicename)}');
					</#if>
					<#if (('${signin.serviceurl}')?has_content)>
						signupurl += "&serviceurl="+encodeURIComponent('${Encoder.encodeJavaScript(signin.serviceurl)}');
					</#if>
					<#if (('${signin.appname}')?has_content)>
						signupurl += "&appname="+encodeURIComponent('${Encoder.encodeJavaScript(signin.appname)}');
					</#if>
					<#if (('${signin.getticket}')?has_content)>
						signupurl += "&getticket=true";
					</#if>
					<#if (('${signin.service_language}')?has_content)>
						signupurl += "&service_language="+ "${Encoder.encodeJavaScript(signin.service_language)}";
					</#if>
					<#if (('${signin.isDarkmode}') == "1" )>
						signupurl += "&darkmode=true";
					</#if>
					return signupurl; 
				</#if>
			}
			function getSigninParms(){
				var params = "cli_time=" + new Date().getTime();
				<#if (('${signin.servicename}')?has_content)>
					serviceName=encodeURIComponent('${Encoder.encodeJavaScript(signin.servicename)}');
					params += "&servicename=" + encodeURIComponent('${Encoder.encodeJavaScript(signin.servicename)}');
				</#if>
				<#if (('${signin.hide_signup}')?has_content)>
					params += "&hide_reg_link="+${Encoder.encodeJavaScript(signin.hide_signup)};
				</#if>	
				<#if (('${signin.appname}')?has_content)>
					params += "&appname="+encodeURIComponent('${Encoder.encodeJavaScript(signin.appname)}');
				</#if>	
				<#if (('${signin.getticket}')?has_content)>
					params += "&getticket=true";
				</#if>	
				<#if (('${signin.serviceurl}')?has_content)>
					params += "&serviceurl="+encodeURIComponent('${Encoder.encodeJavaScript(signin.serviceurl)}');
					serviceUrl = '${Encoder.encodeJavaScript(signin.serviceurl)}';
				</#if>	
				<#if (('${signin.service_language}')?has_content)>
					params += "&service_language="+encodeURIComponent('${Encoder.encodeJavaScript(signin.service_language)}');//no i18N
				</#if>
				<#if (('${signin.portal_id}')?has_content)>
					params += "&portal_id="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_id)}');
				</#if>	
				<#if (('${signin.portal_name}')?has_content)>
					params += "&portal_name="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_name)}');
				</#if>	
				<#if (('${signin.portal_domain}')?has_content)>
					params += "&portal_domain="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_domain)}');
				</#if>
				<#if (('${signin.context}')?has_content)>
						params += "&context="+encodeURIComponent('${Encoder.encodeJavaScript(signin.context)}');//no i18N
				</#if>
				<#if (('${signin.IAM_CID}')?has_content)>
						params += "&IAM_CID="+encodeURIComponent('${Encoder.encodeJavaScript(signin.IAM_CID)}');//no i18N
				</#if>
				<#if (('${signin.token}')?has_content)>
						params += "&token="+encodeURIComponent('${Encoder.encodeJavaScript(signin.token)}');//no i18N
				</#if>
				<#if (('${signin.signupurl}')?has_content)>
					params += "&signupurl="+encodeURIComponent('${Encoder.encodeJavaScript(signin.signupurl)}');//no i18N
				</#if>

				return params;
			}
			function getRecoveryURL(){
			 	var tmpResetPassUrl = resetPassUrl;
			 	<#if (('${signin.servicename}')?has_content)>
					tmpResetPassUrl += "?servicename=" + encodeURIComponent('${Encoder.encodeJavaScript(signin.servicename)}');
				</#if>
				<#if (('${signin.serviceurl}')?has_content)>
					tmpResetPassUrl += "&serviceurl="+encodeURIComponent('${Encoder.encodeJavaScript(signin.serviceurl)}');
				</#if>
				<#if (('${signin.m_redirect}')?has_content)>
					tmpResetPassUrl += "&m_redirect=" + "${Encoder.encodeJavaScript(signin.m_redirect)}";
				</#if>
				<#if (('${signin.signupurl}')?has_content)>
					tmpResetPassUrl += "&signupurl=" + encodeURIComponent('${Encoder.encodeJavaScript(signin.signupurl)}');//no i18N
				</#if>
				<#if (('${signin.hide_signup}')?has_content)>
					tmpResetPassUrl += "&hide_signup="+${Encoder.encodeJavaScript(signin.hide_signup)};
				</#if>
				<#if (('${signin.service_language}')?has_content)>
					tmpResetPassUrl += "&service_language="+ "${Encoder.encodeJavaScript(signin.service_language)}";
				</#if>
				<#if (('${signin.isDarkmode}') == "1" )>
					tmpResetPassUrl += "&darkmode=true";
				</#if>
				<#if (('${signin.portal_id}')?has_content)>
					tmpResetPassUrl += "&portal_id="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_id)}');
				</#if>	
				<#if (('${signin.portal_name}')?has_content)>
					tmpResetPassUrl += "&portal_name="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_name)}');
				</#if>	
				<#if (('${signin.portal_domain}')?has_content)>
					tmpResetPassUrl += "&portal_domain="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_domain)}');
				</#if>
				return tmpResetPassUrl;
			}
			
			function getIPRecoveryURL(){
			 	var tmpResetIPUrl = resetIPUrl;
			 	<#if (('${signin.servicename}')?has_content)>
					tmpResetIPUrl += "?servicename=" + euc('${signin.servicename}');
				</#if>
				<#if (('${signin.serviceurl}')?has_content)>
					tmpResetIPUrl += "&serviceurl="+euc('${Encoder.encodeJavaScript(signin.serviceurl)}');
				</#if>
				<#if (('${signin.signupurl}')?has_content)>
					tmpResetIPUrl += "&signupurl=" + euc('${Encoder.encodeJavaScript(signin.signupurl)}');//no i18N
				</#if>
				<#if (('${signin.hide_signup}')?has_content)>
					tmpResetIPUrl += "&hide_signup="+${signin.hide_signup};
				</#if>
				<#if (('${signin.service_language}')?has_content)>
					tmpResetIPUrl += "&service_language="+ "${signin.service_language}";
				</#if>
				return tmpResetIPUrl;
			}
			
		</script>
       	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0" />
        <title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
	</head>
	<body <#if (signin.isDarkmode == 1) > class="darkmode"</#if> style="visibility: hidden;">
			<#include "../zoho_line_loader.tpl">
			<div class="bg_one"></div>
    		<div class="Alert"> <span class="tick_icon"></span> <span class="alert_message"></span> </div>
    		<div class="Errormsg"> <div style="position:relative;display:flex;align-items:center;"> <span class="error_icon"></span> <span class="error_message"></span> <a class="error_help" href="#" onclick="closeTopErrNotification()"></a> <div class="topErrClose hide" onclick="closeTopErrNotification()"></div> </div> </div>
			<div class="container">
    		<div class="signin_container">
    			<div class='loader'></div>
    			<div class='blur_elem blur'></div>
    			<div class="signin_box" id="signin_flow">
    					<#if (signin.trySmartSignin == 1) && (signin.isMobile == 0)>
	    					<div class="smartsigninbutton" id="smartsigninbtn" onclick="openSmartSignInPage()" >
	    						<span class="ssibuttonqricon icon-SmartQR"></span>
	    						<span><@i18n key="IAM.NEW.SIGNIN.TRY.SMARTSIGNIN"/></span>
	    						<span class="ssibuttonshineicon icon-shine"></span>
	    					</div>
	    				</#if>
    					<#if signin.isPortalLogoURL>
    						<div><img class="portal_logo" src="${signin.portalLogoURL}"/></div>
						<#else>
							<div class='zoho_logo ${signin.servicename}'></div>
						</#if>
	    				<div id="signin_div">
	    					<form name="login" id="login" onsubmit="javascript:return submitsignin(this);" <#if (signin.isMobile == 1) > action="/signin/v2/lookup/"</#if> method="post" novalidate >
	    						<div class="signin_head">
			    					<span id="headtitle"><@i18n key="IAM.SIGN_IN"/></span>
			    					<span id="trytitle"></span>
									<div class="service_name"><@i18n key="IAM.NEW.SIGNIN.SERVICE.NAME.TITLE" arg0="${signin.app_display_name}"/></div>
									<div class="fielderror"></div>
								</div>
								<div class="fieldcontainer">
									<div class="searchparent" id="login_id_container">
									<div class="textbox_div" id="getusername">
									<span>
										<label for='country_code_select' class='select_country_code'></label>
										<select id="country_code_select" onchange="changeCountryCode();">
		                  					<#list signin.country_code as dialingcode>
	                          					<option data-num="${dialingcode.code}" value="${dialingcode.dialcode}" id="${dialingcode.code}" >${dialingcode.display}</option>
	                           				</#list>
										</select>
										<input id="login_id" placeholder="<@i18n key="IAM.NEW.SIGNIN.EMAIL.ADDRESS.OR.MOBILE"/>" value="${signin.loginId}" type="email" name="LOGIN_ID" class="textbox" required="" onkeypress="clearCommonError('login_id')" onkeyup ="checking()" onkeydown="checking()" autocapitalize="off" autocomplete="webauthn username email" autocorrect="off" ${signin.readOnlyEmail} tabindex="1" />
										<span class="doaminat hide" onclick="enableDomain()">@</span>
										<div class="textbox hide" id="portaldomain">
										<select class='domainselect' id='domaincontainer' onchange='handleDomainChange()'></select>
										</div>
										<div class="fielderror"></div>		
									</span>				
									</div>
									</div>
									<div class="getpassword zeroheight" id="password_container">
										<div class="hellouser">
											<div class="username"></div>
											<#if !signin.hide_change>
											<span class="Notyou bluetext" onclick="resetForm()"><@i18n key="IAM.PHOTO.CHANGE"/></span>
											</#if>
										</div>
										<div class="textbox_div">
											<input id="password" placeholder="<@i18n key="IAM.NEW.SIGNIN.PASSWORD"/>" name="PASSWORD" type="password" class="textbox" required="" onfocus="this.value = this.value;" onkeypress="clearCommonError('password')" autocapitalize="off" autocomplete="password" autocorrect="off" maxlength="250"/> 
											<span class="icon-hide show_hide_password" onclick="showHidePassword();"></span>
											<div class="fielderror"></div>
											<div class="textbox_actions" id="enableotpoption">
												<span class="bluetext_action" id="signinwithotp" onclick="showAndGenerateOtp()"></span>
												<#if !signin.ishideFp>
													<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
												</#if>
											</div>
											<div class="textbox_actions" id="enableforgot">
												<#if !signin.ishideFp>
													<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
												</#if>
											</div>
											<div class="textbox_actions_saml" id="enablesaml">
												<span class="bluetext_action signinwithsaml" onclick="enableSamlAuth();"><@i18n key="IAM.NEW.SIGNIN.USING.SAML"/></span>
												<#if !signin.ishideFp>
													<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
												</#if>
											</div>
											<div class="textbox_actions_saml" id="enablejwt">
												<a href="#" class="bluetext_action signinwithjwt"><@i18n key="IAM.NEW.SIGNIN.USING.JWT"/></a>
												<#if !signin.ishideFp>
													<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
												</#if>
											</div>	
										</div> 
									</div>
							<div class="textbox_div" id="mfa_device_container">
								<div class="devices">
									<select class='secondary_devices' onchange='changeSecDevice(this);'></select>
									<div class="deviceparent">
										<span class="deviceinfo icon-device"></span>
										<span class="devicetext"></span>
									</div>
								</div>
								<div class='rnd_container'>
									<div id="rnd_num"></div>
									<div class="bluetext_action rnd_resend resendotp" onclick="javascript:return submitsignin($('#login'));"><@i18n key="IAM.NEW.SIGNIN.RESEND.PUSH"/></div>
								</div>
							</div>
								<div id="otp_container">
									<div class="hellouser">
										<div class="username"></div>
										<#if !signin.hide_change>
										<span class="Notyou bluetext" onclick="resetForm()"><@i18n key="IAM.PHOTO.CHANGE"/></span>
										</#if>
									</div>
									<div class="textbox_div" >
										<div id="otp" class="textbox" onkeypress="clearCommonError('otp')"></div>
										<div class="fielderror"></div>
										<div class="textbox_actions otp_actions">
											<span class="bluetext_action" id="signinwithpass" onclick="showPassword()"><@i18n key="IAM.NEW.SIGNIN.USING.PASSWORD"/></span>
											<span class="bluetext_action signinwithsaml" onclick="enableSamlAuth();"><@i18n key="IAM.NEW.SIGNIN.USING.SAML"/></span>
											<a href="#" class="bluetext_action signinwithjwt" ><@i18n key="IAM.NEW.SIGNIN.USING.JWT"/></a>
											<span class="bluetext_action showmoresigininoption" onclick="showmoresigininoption()"><@i18n key="IAM.NEW.SIGNIN.CHOOSE.OTHER.WAY"/></span>
											<span class="bluetext_action bluetext_action_right resendotp" onclick="generateOTP(true);clearCommonError('otp');clearFieldValue('otp')"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
										</div>
									</div>
								</div>
							<div class="textbox_div" id="mfa_otp_container">
								<div id="mfa_otp" class="textbox" onkeypress="clearCommonError('mfa_otp')"></div>
								<div class="fielderror"></div>
								<div class="textbox_actions">
									<span class="bluetext_action bluetext_action_right resendotp" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
								</div>
							</div>
							<div class="textbox_div" id="mfa_email_container">
								<div id="mfa_email" class="textbox" onkeypress="clearCommonError('mfa_email')"></div> 
								<div class="fielderror"></div>
								<div class="textbox_actions">
									<span class="bluetext_action bluetext_action_right resendotp" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
								</div>
							</div>
							<div class="textbox_div" id="mfa_totp_container">
								<div id="mfa_totp" class="textbox" onkeypress="clearCommonError('mfa_totp')"></div>
								<div class="fielderror"></div>
							</div>
							
							<div class="qrcodecontainer" id="mfa_scanqr_container">
								<span class="qr_before"></span>
							    <img id="qrimg" src=""/>
							    <span class="qr_after"></span>
							</div>
							<div class="textbox_div" id="captcha_container">
								<input id="captcha" placeholder="<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA"/>" type="text" name="captcha" class="textbox" required="" onkeypress="clearCommonError('captcha')" autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="8"/>
								<div id="captcha_img" name="captcha" class="textbox"></div>
								<span class="reloadcaptcha icon-Reload" onclick="changeHip()"></span>
								<div class="fielderror"></div> 
							</div>
							<#if (signin.isMobile == 1) >
									<div class="btn blue waitbtn" id="openoneauth" onclick="QrOpenApp()">
										<span class="oneauthtext"><@i18n key="IAM.NEW.SIGNIN.OPEN.ONEAUTH"/></span>
									</div>
							</#if>
							<div id="yubikey_container">
								<div class="fielderror"></div>
							</div>
							<button class="btn blue waitbtn" id="waitbtn">
									<span class="loadwithbtn"></span>
									<span class="waittext"><@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL"/></span>
							</button>
							</div>
							<div class="textbox_actions_more" id="enablemore">
								<span class="bluetext_action showmoresigininoption" onclick="showmoresigininoption()"><@i18n key="IAM.NEW.SIGNIN.CHOOSE.OTHER.WAY"/></span>
								<#if !signin.ishideFp>
									<span class="bluetext_action bluetext_action_right blueforgotpassword" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
								</#if>
								<span class="bluetext_action bluetext_action_right resendotp" id="resendotp" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
								
								<div id="enableoptionsoneauth">
									<span class="signinoptiononeauth" id="signinwithpassoneauth" onclick="showPassword()"><@i18n key="IAM.NEW.SIGNIN.USING.PASSWORD"/></span>
									<span class="signinoptiononeauth" id="passlessemailverify" onclick="showAndGenerateOtp('email')"></span>
									<span class="signinoptiononeauth" id="signinwithotponeauth" onclick="showAndGenerateOtp('otp')"></span>
									<span class="signinwithsamloneauth signinoptiononeauth" onclick="enableSamlAuth();"><@i18n key="IAM.NEW.SIGNIN.USING.SAML"/></span>
									<span class="signinwithfedoneauth signinoptiononeauth" onclick="showMoreFedOptions();"><@i18n key="IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.TITLE"/></span>
									<a href="#" class="signinwithjwtoneauth signinoptiononeauth"><@i18n key="IAM.NEW.SIGNIN.USING.JWT"/></a>
								</div>
							</div>	
							<div class="addaptivetfalist">
									<div class="signin_head verify_title"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY"/></div>
									<div class="optionstry optionmod" id="trytotp" onclick="tryAnotherway('totp')" >
										<div class="img_option_try img_option icon-totp"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.TOTP.TITLE"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.TOTP.DESC"/></div>
										</div>
										<div class='mfa_totp_verify verify_totp' id='verify_totp_container'> 
											<div id="verify_totp" name="MFATOTP" class="textbox" onkeypress="clearCommonError('verify_totp')"/></div>
											<button class="btn blue" id="totpverifybtn" tabindex="2" >
												<span class="loadwithbtn"></span>
												<span class="waittext"><@i18n key="IAM.VERIFY"/></span>
											</button>
											<div class="fielderror"></div>
										</div>
									</div>
									<div class="optionstry optionmod" id="tryscanqr" onclick="tryAnotherway('qr')" >
										<div class="img_option_try img_option icon-qr"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.SCANQR.TITLE"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.SCANQR.DESC"/></div>
										</div>
										<div class="verify_qr" id="verify_qr_container">
											<div class="qrcodecontainer">
												<div>
													<span class='qr_before'></span>
												    <img id="verify_qrimg" src=""/>
												   	<span class='qr_after'></span>
												   	<div class="loader"></div>
												   	<div class="blur_elem blur"></div>
											   	</div>
											</div>
										   	<#if (signin.isMobile == 1) >
												<div class="btn blue waitbtn" id="openoneauth" onclick="QrOpenApp()">
													<span class="oneauthtext"><@i18n key="IAM.NEW.SIGNIN.OPEN.ONEAUTH"/></span>
												</div>
											</#if>
										</div>
									</div>
									<span class="close_icon error_icon" onclick="hideTryanotherWay()"></span>
									<div class='text16 pointer nomargin' id='recoverybtn_mob' onclick='showCantAccessDevice()'><@i18n key="IAM.NEW.SIGNIN.CANT.ACCESS"/></div>
									<div class="text16 pointer nomargin" id="problemsignin_mob" onclick="showproblemsignin()"><@i18n key="IAM.NEW.SIGNIN.PROBLEM.SIGNIN"/></div>
							</div>
							<div id="problemsigninui"></div>
							
							<button class="btn blue" id="nextbtn" tabindex="2" disabled="disabled"><span><@i18n key="IAM.NEXT"/></span></button>
							<div class="btn borderless" onclick="hideBackupOptions()"><@i18n key="IAM.BACK"/></div>
							<div class='text16 pointer nomargin' id='recoverybtn' onclick='showCantAccessDevice()'><@i18n key="IAM.NEW.SIGNIN.CANT.ACCESS"/></div>
							<div class="text16 pointer nomargin" id="problemsignin" onclick="showproblemsignin()"><@i18n key="IAM.NEW.SIGNIN.PROBLEM.SIGNIN"/></div>
							<div class="tryanother text16" onclick ="showTryanotherWay()"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY"/></div>
							<#if !signin.ishideFp>
								<div class="text16" id="forgotpassword"><a class="text16" href="#" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></a></div>
							</#if>
	    					</form>
	    					<div class="externaluser_container"></div>
							<button class="btn blue" id="continuebtn" onclick="handleLookupDetails(JSON.stringify(deviceauthdetails),true);return false"><span><@i18n key="IAM.CONTINUE"/></span></button>
	    					<div id="recovery_container">
								<div class="signin_head recoveryhead">
									<table id="recoverytitle"><span class='icon-backarrow backoption' onclick='goBackToProblemSignin()'></span><span class="rec_head_text"><@i18n key="IAM.NEW.SIGNIN.CANT.ACCESS"/></span></table>
									</div>
									<div id='recoverymodeContainer'></div>
									<div class='recoverymodes'>
										<div class="options options_hover" id="recoverOption" onclick="showBackupVerificationCode()">
											<div class="img_option icon-backup"></div>
											<div class="option_details">
												<div class="option_title"><@i18n key="IAM.TFA.USE.BACKUP.CODE"/></div>
												<div class="option_description"><@i18n key="IAM.NEW.SIGNIN.BACKUP.HEADER"/></div>
											</div>
										</div>
										<div class="options options_hover" id="passphraseRecover" onclick="showPassphraseContainer()">
											<div class="img_option icon-saml"></div>
											<div class="option_details">
												<div class="option_title"><@i18n key="IAM.NEW.SIGNIN.MFA.PASSPHRASE.HEADER"/></div>
												<div class="option_description"><@i18n key="IAM.NEW.SIGNIN.MFA.PASSPHRASE.DESC"/></div>
											</div>
										</div>
										<div class="options contact_support">
											<div class="img_option icon-support"></div>
											<div class="option_details">
												<div class="option_title"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div>
												<div class="option_description contactsuprt"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT.DESC" arg0="${signin.supportEmailAddress}"/></div>
										</div>
									</div>
								</div>
								<div class="btn greytext" ></div>
						   </div>
						   <form id='backup_container' onsubmit="javascript:return verifyBackupCode()" novalidate>
								<div class="signin_head backuphead">
									<span id="backup_title"><span class='icon-backarrow backoption' onclick='showCantAccessDevice()'></span><@i18n key="IAM.TFA.USE.BACKUP.CODE"/></span>
									<div class="backup_desc extramargin"><@i18n key="IAM.NEW.SIGNIN.BACKUP.HEADER"/></div>
								</div>
								<div class="textbox_div" id="backupcode_container">
									<input id="backupcode" placeholder='<@i18n key="IAM.BACKUP.VERIFICATION.CODE"/>' type="text" name="backupcode" class="textbox" required="" onkeypress="clearCommonError('backupcode')" onkeyup="submitbackup(event)" autocapitalize="off" autocomplete="off" autocorrect="off"/> 
									<div class="fielderror"></div>
									<span class="bluetext_action" id="recovery_passphrase" onclick="changeRecoverOption('passphrase')"><@i18n key="IAM.NEW.SIGNIN.MFA.PASSPHRASE.HEADER"/></span>
								</div>
								<div class="textbox_div" id="passphrase_container">
									<input id="passphrase" placeholder="<@i18n key="IAM.NEW.SIGNIN.PASSPHRASE.CODE"/>" type="password" name="PASSPHRASE" class="textbox" required="" onkeypress="clearCommonError('passphrase')" autocapitalize="off" autocomplete="off" autocorrect="off"/>
									<span class="icon-hide show_hide_password" onclick="showHidePassword();"></span>
									<div class="fielderror"></div>
									<span class="bluetext_action" id="recovery_backup" onclick="changeRecoverOption('recoverycode')"><@i18n key="IAM.NEW.SIGNIN.MFA.BACKUP.CODE"/></span>
								</div>
								<div class="textbox_div" id="bcaptcha_container">
									<input id="bcaptcha" placeholder="<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA"/>" type="text" name="captcha" class="textbox" required="" onkeypress="clearCommonError('bcaptcha')" onkeyup="submitbackup(event)" autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="8"/>
									<div id="bcaptcha_img" name="captcha" class="textbox"></div>
									<span class="reloadcaptcha" onclick="changeHip('bcaptcha_img','bcaptcha')"> </span>
									<div class="fielderror"></div> 
								</div>
								<button class="btn blue"><@i18n key="IAM.VERIFY"/></button>
								<div class="btn borderlessbtn back_btn"></div>
							</form>
							<form id="emailcheck_container" onsubmit="javascript:return verifyEmailValid();" novalidate>
								<div class="signin_head emailcheck_head">
									<span id="backup_title"><span class='icon-backarrow backoption' onclick='hideEmailOTPInitiate()'></span><@i18n key="IAM.NEW.SIGNIN.VERIFY.EMAIL.TITLE"/></span>
									<div class="backup_desc extramargin" id="emailverify_desc"><@i18n key="IAM.NEW.SIGNIN.VERIFY.EMAIL.DESC"/></div>
								</div>
								<div class="textbox_div" id="emailvalidate_container">
									<input id="emailcheck" placeholder="<@i18n key="IAM.NEW.SIGNIN.VERIFY.EMAIL.PLACEHOLDER"/>" name="EMAILCHECK" type="email" class="textbox" required="" onkeypress="clearCommonError('emailcheck')" autocapitalize="off" autocomplete="on" autocorrect="off" maxlength="250"/> 
									<div class="fielderror"></div>
								</div>
								<button class="btn blue"><@i18n key="IAM.NEXT"/></button>
							</form>
							<form id="emailverify_container" onsubmit="javascript:return verifyEmailOTP();" novalidate>
								<div class="signin_head emailverify_head">
									<span id="backup_title"><span class='icon-backarrow backoption' onclick='hideEmailOTPVerify()'></span><@i18n key="IAM.NEW.SIGNIN.VERIFY.EMAIL.TITLE"/></span>
									<div class="backup_desc extramargin" id="emailverify_desc"><@i18n key="IAM.NEW.SIGNIN.VERIFY.EMAIL.DESC"/></div>
								</div>
								<div class="textbox_div" id="emailotpverify_container">
									<div id="emailverify" class="textbox" onkeypress="clearCommonError('emailverify')"></div>
									<div class="fielderror"></div>
								</div>
								
								<span class="bluetext_action" id="signinwithpass" onclick="showPassword()"><@i18n key="IAM.NEW.SIGNIN.USING.PASSWORD"/></span>
								<span class="bluetext_action signinwithsaml" onclick="enableSamlAuth();"><@i18n key="IAM.NEW.SIGNIN.USING.SAML"/></span>
								<a href="#" class="bluetext_action signinwithjwt" ><@i18n key="IAM.NEW.SIGNIN.USING.JWT"/></a>
								<span class="bluetext_action bluetext_action_right resendotp resendotp_mb" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
								<div class="textbox_actions_more" id="enablemore">
									<span class="bluetext_action showmoresigininoption" onclick="showmoresigininoption('getbackemailverify');"><@i18n key="IAM.NEW.SIGNIN.CHOOSE.OTHER.WAY"/></span>
									<#if !signin.ishideFp>
										<span class="bluetext_action bluetext_action_right blueforgotpassword" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
									</#if>
									<span class="bluetext_action bluetext_action_right resendotp" id="resendotp" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
								</div>	
								<button class="btn blue" ><@i18n key="IAM.VERIFY"/></button>
							</form> 
	    				<div>
	    		</div>
	    			<div class="line">
		    			<span class="line_con">
		    				<span><@i18n key="IAM.OR"/></span>
		    			</span>
	    			</div>
	    				<div class="fed_2show">
							<div class="signin_fed_text"><@i18n key="IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE"/></div>
							<#if signin.apple>
								<span class="fed_div large_box apple_normal_icon apple_fed" id="macappleicon" onclick="createandSubmitOpenIDForm('apple');" title="<@i18n key="IAM.FEDERATED.SIGNIN.APPLE"/>">
						           <div class="fed_center_apple">
						                <span class="icon-apple_small fedicon"></span>
						                <span class="fed_text"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.APPLE"/></span>
						            </div>
						        </span>
							</#if>
							<#if signin.google>
								<span class="fed_div large_box google_icon google_fed" onclick="createandSubmitOpenIDForm('google');" title="<@i18n key="IAM.FEDERATED.SIGNIN.GOOGLE"/>">
						            <div class="fed_center_google">
						            	<span class="fed_google_large">
							                <span class="icon-google_small fedicon">
												<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>
											</span>
										</span>
										<span class="fed_text largeGoogleText"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.GOOGLE"/></span>
										<span class="fed_text smallGoogleText">Google</span>
						            </div>
						        </span>
							</#if>
							<#if signin.yahoo>
								<span class="fed_div large_box yahoo_icon yahoo_fed"  onclick="createandSubmitOpenIDForm('yahoo');" title="<@i18n key="IAM.FEDERATED.SIGNIN.YAHOO"/>">
								 <div class="fed_center">
						            <div class="icon-yahoo_small fedicon yahooicon"></div>
						            <span class="fed_text"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.YAHOO"/></span>
						         </div>
						        </span>
							</#if>
							<#if signin.facebook>
								<span class="fed_div large_box fb_fed_box facebook_fed" onclick="createandSubmitOpenIDForm('facebook');" title="<@i18n key="IAM.FEDERATED.SIGNIN.WITH.FACEBOOK"/>">
									<div class="fed_center">
							            <div class="icon-facebook_small fedicon"></div>
							            <span class="fed_text"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.FACEBOOK"/></span>
							        </div>
						        </span>
							</#if>
							<#if signin.linkedin>
								 <span class="fed_div large_box linkedin_fed_box linkedin_fed" onclick="createandSubmitOpenIDForm('linkedin');" title="<@i18n key="IAM.FEDERATED.SIGNIN.LINKEDIN"/>">
						            <div class="fed_center_linkedIn">
						                <span class="icon-linkedin_small fedicon linkedicon"></span>
						            </div>
						        </span>
							</#if>
							<#if signin.twitter>
								<span class="fed_div large_box twitter_fed_box twitter_fed" onclick="createandSubmitOpenIDForm('twitter');" title="<@i18n key="IAM.FEDERATED.SIGNIN.TWITTER"/>">
						            <div class="fed_center">
						                <span class="icon-twitter_small fedicon"></span>
						                <span class="fed_text"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.TWITTER"/></span>
						            </div>
						        </span>
							</#if>
							<#if signin.weibo>
								<span class="fed_div large_box weibo_icon weibo_fed" onclick="createandSubmitOpenIDForm('weibo');" title="<@i18n key="IAM.FEDERATED.SIGNIN.WEIBO"/>">
						            <div class="fed_center">
						                <span class="icon-weibo_small fedicon">
						                		<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>
						                </span>
						                <span class="fed_text">Weibo</span>
						            </div>
						        </span>
							</#if>
							<#if signin.baidu>
								<span class="fed_div large_box baidu_icon baidu_fed"  onclick="createandSubmitOpenIDForm('baidu');" title="<@i18n key="IAM.FEDERATED.SIGNIN.BAIDU"/>">
										<div class="fed_center">
							            <div class="icon-baidu_small fedicon baiduicon">
							            		<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>
							            </div>
							           	</div>	
						        </span>
							</#if>
							<#if signin.qq>
								<span class="fed_div large_box qq_icon qq_fed" onclick="createandSubmitOpenIDForm('qq');" title="<@i18n key="IAM.FEDERATED.SIGNIN.QQ"/>">
									 <div class="fed_center">
							            <div class="icon-qq_small fedicon">
							            		<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>
							            </div>
							            <span class="fed_text">QQ</span>
							         </div>
						        </span>
							</#if>
							<#if signin.douban>
								<span class="fed_div large_box douban_icon douban_fed" onclick="createandSubmitOpenIDForm('douban');" title="<@i18n key="IAM.FEDERATED.SIGNIN.DOUBAN"/>">
									 <div class="fed_center">
							            <div class="icon-douban_small fedicon"></div>
							            <span class="fed_text">Douban</span>
							         </div>
						        </span>
							</#if>
							<#if signin.azure>
								<span class="fed_div large_box MS_icon azure_fed" onclick="createandSubmitOpenIDForm('azure');" title="<@i18n key="IAM.FEDERATED.SIGNIN.MICROSOFT"/>">
						            <div class="fed_center">
						                <span class="icon-azure_small fedicon">
						                		<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>
						                </span>
						                <span class="fed_text"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.MICROSOFT"/></span>
						            </div>
						        </span>
							</#if>
							<#if signin.intuit>
								<span class="fed_div large_box intuit_icon intuit_fed" onclick="createandSubmitOpenIDForm('intuit');" title="<@i18n key="IAM.FEDERATED.SIGNIN.INTUIT"/>">
									 <div class="fed_center intuit_fed">
						             	<div class="icon-intuit_small fedicon intuiticon"></div>
						             </div>
						        </span>
							</#if>
							<#if signin.wechat>
								<span class="fed_div large_box wechat_icon wechat_fed" onclick="createandSubmitOpenIDForm('wechat');" title="<@i18n key="IAM.FEDERATED.SIGNIN.WECHAT"/>">
						            <div class="fed_center">
						                <span class="icon-wechat_small fedicon"></span>
						                <span class="fed_text">WeChat</span>
						            </div>
						        </span>
							</#if>
							<#if signin.slack>
								<span class="fed_div large_box slack_icon slack_fed" onclick="createandSubmitOpenIDForm('slack');" title="<@i18n key="IAM.FEDERATED.SIGNIN.SLACK"/>">
									 <div class="fed_center">
							            <div class="icon-slack_small fedicon slackicon">
							            		<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>
							            	</div>
							            	<span class="fed_text"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.SLACK"/></span>
							         </div>
						        </span>
							</#if>
							<#if signin.apple>
								<span class="fed_div large_box apple_normal_icon apple_fed" id="appleNormalIcon" onclick="createandSubmitOpenIDForm('apple');" title="<@i18n key="IAM.FEDERATED.SIGNIN.APPLE"/>">
						             <div class="fed_center">
						                <span class="icon-apple_small fedicon"></span>
						                <span class="fed_text"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.APPLE"/></span>
						            </div>
						        </span>
							</#if>
							<#if signin.adp>
								<span class="fed_div large_box adp_icon adp_fed" onclick="createandSubmitOpenIDForm('adp');" title="<@i18n key="IAM.FEDERATED.SIGNIN.ADP"/>">
									<div class="fed_center">
						           	 	<div class="icon-adp_small fedicon"></div>
						            	</div>	
						        </span>
							</#if>
							<#if signin.feishu>
								<span class="fed_div large_box feishu_icon feishu_fed" onclick="createandSubmitOpenIDForm('feishu');" title="<@i18n key="IAM.FEDERATED.SIGNIN.FEISHU"/>">
						            <div class="fed_center">
						            	<span class="icon-feishu_small fedicon">
						            		<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>
						            	</span>
						            <span class="fed_text"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.FEISHU"/></span>
						            </div>
						        </span>
							</#if>
							<#if signin.github>
								<span class="fed_div large_box github_icon github_fed" onclick="createandSubmitOpenIDForm('github');" title="<@i18n key="IAM.FEDERATED.SIGNIN.WITH.GITHUB"/>">
						            <div class="fed_center">
							            <span class="icon-github_small fedicon"></span>
										<span class="fed_text"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.GITHUB"/></span>
						            </div>
						        </span>
							</#if>
							<span class="fed_div more" id="showIDPs" title="<@i18n key="IAM.FEDERATED.SIGNIN.MORE"/>" onclick="showMoreIdps();"> <span class="morecircle"></span> <span class="morecircle"></span> <span class="morecircle"></span></span>
							<div class="zohosignin hide" onclick="showZohoSignin()"><@i18n key="IAM.NEW.SIGNIN.USING.ZOHO"/><span class="fedarrow"></span></div>	
					</div>
    			</div>
    			<div class="nopassword_container">
    				<div class="nopassword_icon icon-hint"></div>
    				<div class="nopassword_message"><@i18n key="IAM.NEW.SIGNIN.NO.PASSWORD.MESSAGE" arg0="goToForgotPassword();"/></div>
    			</div>
    			<div class="go_to_bk_code_container">
    				<div class="close_btn" onclick="hideBkCodeRedirection()"></div>
    				<div class="nopassword_icon icon-hint"></div>
    				<div class="backup_info_tab">
    					<div style="font-size:12px;font-weight:500;"><@i18n key="IAM.NEW.SIGNIN.MFA.FAILURE.TRY.BACKUP.CODE"/></div>
    					<div style="margin-top: 5px;color: #000000BF;"><@i18n key="IAM.NEW.SIGNIN.MFA.FAILURE.BACKUP.REMINDER"/></div>
    				</div>
    				<div class="button_parent"><span class="backup_action" onclick="showBackupVerificationCode()"><@i18n key="IAM.TRY.NOW"/></span></div>
    			</div>
    			<div class="password_expiry_container">
    				<div class="passexpsuccess"></div>
    				<div class="signin_head">
							<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED"/></span>
							<div class="pass_name extramargin" id="password_desc"></div>
					</div>
					<div class="textbox_div" id="npassword_container">
							<input id="new_password" onkeyup="setPassword(event)" placeholder='<@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.NEW.PASSWORD"/>' name="newPassword" type="password" class="textbox" required="" onkeypress="clearCommonError('password')" autocapitalize="off" autocomplete="password" autocorrect="off" />
							<span class="icon-hide show_hide_password" onclick="showHidePassword();"></span>
							<div class="fielderror"></div>
					</div>
					<div class="textbox_div" id="rpassword_container">
							<input id="new_repeat_password" onkeyup="setPassword(event)" placeholder='<@i18n key="IAM.CONFIRM.PASS"/>' name="cpwd" type="password" class="textbox" required="" onkeypress="clearCommonError('password')" autocapitalize="off" autocomplete="password" autocorrect="off" /> 
					</div>
					<button class="btn blue" id="changepassword" onclick="updatePassword();"><span><@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET"/></span></button>
    			</div>
    			
    			<div class="resetIP_container">
    				<div class="hellouser">
						<div class="username"></div>
						<#if !signin.hide_change>
						<span class="Notyou bluetext" onclick="resetForm(true)"><@i18n key="IAM.PHOTO.CHANGE"/></span>
						</#if>
					</div>
					
    				<div class="signin_head">
							<span id="headtitle"><@i18n key="IAM.ERRORJSP.IP.NOT.ALLOWED.TITLE"/></span>
							<div class="pass_name extramargin" id="ip_desc"><@i18n key="IAM.SIGNIN.ERROR.USER.NOT.ALLOWED.IP.RESETOPTION" arg0='${signin.currentIP}'/></div>
					</div>
					<div class="text16 pointer nomargin" id="goto_resetIP" onclick="goToForgotPassword(true);"><@i18n key="IAM.IP.RESET.QUESTION"/></div>
    			</div>
    			
    			
    			<div class="terminate_session_container">
    				<div class="signin_head">
							<span id="headtitle"><@i18n key="IAM.PASSWORD.QUITSESSIONS.HEAD"/></span>
							<div class="pass_name extramargin" id="password_desc"><@i18n key="IAM.PASSWORD.QUITSESSIONS.DECRIPTION"/></div>
					</div>
					<form id="terminate_session_form" name="terminate_session_container" onsubmit="return send_terminate_session_request(this);" novalidate>
						<div class="checkbox_div" id="terminate_web_sess" style="padding: 10px;margin-top:10px;">
							<input id="termin_web" name="signoutfromweb" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_web" class="session_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.WEB" /></span>
								<span id="terminate_session_web_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.SESSION.DESC"/></span>
							</label>
						</div>
						<div class="checkbox_div" id="terminate_mob_apps" style="padding: 10px;margin-top:10px">
							<input id="termin_mob" name="signoutfrommobile" class="checkbox_check" type="checkbox" onchange="showOneAuthTerminate(this)">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_mob" class="session_label big_checkbox_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.MOBILE.SESSION" /></span>
								<span id="terminate_session_weband_mobile_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.MOBILE.SESSION.DESC"/></span>
							</label>
						</div>
						<div class="oneAuthLable">
							<div class="oneauthdiv"> 
								<span class="oneauth_icon one_auth_icon_v2"></span>
								<span class="text_container">
									<div class="text_header"><@i18n key="IAM.PASSWORD.TERMINATE.INCLUDE.ONEAUTH" /></div>
									<div class="text_desc"><@i18n key="IAM.PASSWORD.TERMINATE.INCLUDE.ONEAUTH.DESC" /></div>
								</span>
								<div class="togglebtn_div include_oneAuth_button">
									<input class="real_togglebtn" id="include_oneauth" type="checkbox">
									<div class="togglebase">
										<div class="toggle_circle"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="checkbox_div" id="terminate_api_tok" style="padding: 10px;margin-top:10px">
							<input id="termin_api" name="signoutfromapiToken" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_api" class="session_label big_checkbox_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.DELETE.APITOKENS" /></span>
								<span id="terminate_session_web_desc_apitoken" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.REVOKE.CONNECTED.APPS.DESC"/></span>
							</label>
						</div>
						<button class="btn blue checkbox_mod" id="terminate_session_submit"><span><@i18n key="IAM.CONTINUE"/></span></button>
					</form>
    			</div>
    				<div class="trustbrowser_ui">
						<div class="signin_head">
							<span id="headtitle"><@i18n key="IAM.TFA.TRUST.BROWSER.QUESTION"/></span>
							<div class="service_name mod_sername"></div>
						</div>
						<button class="btn blue trustdevice trustbtn" onclick="updateTrustDevice(true)">
							<span class="loadwithbtn"></span>
							<span class="waittext"><@i18n key="IAM.TRUST"/></span>
						</button>
						<button class="btn grey trustdevice notnowbtn"  onclick="updateTrustDevice(false)">
							<span class="loadwithbtn"></span>
							<span class="waittext"><@i18n key="IAM.NOTNOW"/></span>
						</button>
				</div>
				<div id="restict_signin">
					<div class='signin_head restrict_head'><@i18n key="IAM.NEW.SIGNIN.RESTRICT.SIGNIN.HEADER"/></div>
					<div class='restrict_icon'></div> 
					<div class='restrict_desc service_name'><@i18n key="IAM.NEW.SIGNIN.RESTRICT.SIGNIN.DESC"/></div>
					<button class="btn blue trybtn" id="restict_btn" tabindex="2" onclick="window.location.reload()"><@i18n key="IAM.YUBIKEY.TRY.AGAIN"/></button>
				</div>
    		</div>
    		
    		<div class="rightside_box">
    			<div class='mfa_panel hide'>
    				<div class="product_img" id="product_img"></div>
						<div class="product_head"><@i18n key="IAM.NEW.SIGNIN.KEEP.ACCOUNT.SECURE"/></div>	
						<div class="product_text"><@i18n key="IAM.NEW.SIGNIN.ONEAUTH.INFO.HEADER" arg0="${signin.oneAuthUrl}"/></div>
    				</div>
				</div>
    		</div>
    		<#if !signin.hideSignUpOption>
				<div id="signuplink"><@i18n key="IAM.HOME.WELCOMEPAGE.SIGNUP.NOW" arg0="register()"/></div>
			</#if>
			<div id="enableCookie" style='display:none;text-align:center'>
	            <#if signin.isPortalLogoURL>
	             	<div><img class='zoho_logo_position_center' src="${signin.portalLogoURL}" height="46"/></div>
	            <#else>
	                   <div class='zoho_logo ${signin.servicename} zoho_logo_position_center'></div>
	            </#if>
            <div style="text-align: center;padding: 10px;"><@i18n key="IAM.ERROR.COOKIE_DISABLED"/></div>
	    </div>
		</div>    	
	    <noscript>
		    <div style="position: fixed; top: 0px; left: 0px; z-index: 3;height: 100%; width: 100%; background-color: #FFFFFF">
		    	<div id="enableCookie" style='text-align:center'>
		            <#if signin.isPortalLogoURL>
		                    <div><img class='zoho_logo_position_center' src="${signin.portalLogoURL}" height="46"/></div>
		            <#else>
		                   <div class='zoho_logo ${signin.servicename} zoho_logo_position_center'></div>
		            </#if>
		            <div style="text-align: center;padding: 10px;"><@i18n key="IAM.JAVASCRIPT.DISABLED.WARNING.MESSAGE"/></div>
	    		</div>
		    </div>
		</noscript>
		</div>
		<#include "footer.tpl">
	</body>
</html>
</#if>